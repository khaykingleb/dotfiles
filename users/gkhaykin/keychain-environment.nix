{ pkgs }:
let
  serviceName = "onepassword-environment";
in
{
  inherit serviceName;

  # Build an executable for starting programs that need secrets.
  # `onepassword.nix` resolves secrets during activation and stores them in one
  # macOS Keychain item. This executable reads that item, exports only the
  # variable names listed before `--`, then runs the command after `--`.
  # This gives GUI-launched MCP servers access without calling `op` and
  # prompting for authorization every time they start.
  package = pkgs.writeShellApplication {
    name = "with-keychain-environment";
    text = ''
      requested_variables=()

      while (( $# > 0 )) && [[ "$1" != "--" ]]; do
        if [[ ! "$1" =~ ^[A-Za-z_][A-Za-z0-9_]*$ ]]; then
          echo "with-keychain-environment: invalid environment variable name: $1" >&2
          exit 2
        fi

        requested_variables+=("$1")
        shift
      done

      if (( ''${#requested_variables[@]} == 0 || $# < 2 )); then
        echo "usage: with-keychain-environment VARIABLE... -- COMMAND [ARG...]" >&2
        exit 2
      fi
      shift

      if ! encoded_environment="$(/usr/bin/security find-generic-password -s ${serviceName} -w 2>/dev/null)"; then
        echo "with-keychain-environment: 1Password environment not found in the login keychain; run 'just nix-apply' to populate it" >&2
        exit 1
      fi

      if ! decoded_environment="$(/usr/bin/base64 -d <<< "$encoded_environment")"; then
        echo "with-keychain-environment: unable to decode the cached 1Password environment" >&2
        exit 1
      fi
      unset encoded_environment

      # Forward only explicitly requested secrets so each MCP receives the
      # minimum credentials it needs.
      for requested_variable in "''${requested_variables[@]}"; do
        variable_found=false

        # Parse assignments as data rather than sourcing or evaluating secret
        # values as shell code.
        while IFS='=' read -r name value; do
          if [[ "$name" == "$requested_variable" ]]; then
            export "$name=$value"
            variable_found=true
            break
          fi
        done <<< "$decoded_environment"

        if [[ "$variable_found" != true ]]; then
          echo "with-keychain-environment: $requested_variable not found in the cached 1Password environment" >&2
          exit 1
        fi
      done

      unset decoded_environment requested_variable variable_found name value requested_variables
      exec "$@"
    '';
  };
}
