{
  config,
  lib,
  pkgs,
  ...
}:
let
  onePasswordAccount = "together-ai.1password.com";

  onePasswordEnvironmentVariables = {
    ANTHROPIC_API_KEY = "op://Employee/Anthropic/credential";
    GRAFANA_SERVICE_ACCOUNT_TOKEN = "op://Employee/Grafana MCP Service Account/token";
    NETBOX_TOKEN = "op://Employee/NetBox/credential";
    TOGETHER_PROD_API_KEY = "op://Employee/Together Prod/public_credential";
    TOGETHER_PROD_INTERNAL_API_KEY = "op://Employee/Together Prod/internal_credential";
    TOGETHER_PROD_BASE_URL = "op://Employee/Together Prod/base_url";
    TOGETHER_QA_API_KEY = "op://Employee/Together QA/public_credential";
    TOGETHER_QA_INTERNAL_API_KEY = "op://Employee/Together QA/internal_credential";
    TOGETHER_QA_BASE_URL = "op://Employee/Together QA/base_url";
  };

  environmentTemplate = pkgs.writeText "onepassword-environment.tpl" (
    lib.concatStrings (
      lib.mapAttrsToList (name: reference: "${name}={{ ${reference} }}\n") onePasswordEnvironmentVariables
    )
  );

  # The resolved variables are cached in the login keychain (encrypted at
  # rest, silently readable once logged in) so shells never have to talk to
  # 1Password directly. This is necessary because `op` prompts for
  # authorization per terminal, which is unusable with agent-spawned shells.
  keychainService = "onepassword-environment";
in
{
  home.packages = [ pkgs._1password-cli ];

  # Refresh the keychain copy from 1Password on every activation. This is the
  # only step that talks to 1Password, so `just nix-apply` costs one biometric
  # prompt and everything stays fresh without any prompts at shell init.
  home.activation.refreshOnePasswordEnvironment = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    if [[ -v DRY_RUN ]]; then
      verboseEcho "Would refresh the 1Password environment in the login keychain"
    elif onepassword_environment="$(${lib.getExe' pkgs._1password-cli "op"} inject --account ${lib.escapeShellArg onePasswordAccount} --in-file ${environmentTemplate})"; then
      # base64 collapses the blob to one safe token, and `security -i` reads
      # the command from stdin, keeping secrets out of process arguments.
      printf 'add-generic-password -U -s %s -a %s -w %s\n' \
        ${lib.escapeShellArg keychainService} \
        ${lib.escapeShellArg config.home.username} \
        "$(printf '%s' "$onepassword_environment" | /usr/bin/base64)" \
        | /usr/bin/security -i
      unset onepassword_environment
    else
      echo "warning: unable to reach 1Password; keeping the previous keychain copy" >&2
    fi
  '';

  programs.zsh.initContent = ''
    if onepassword_environment="$(/usr/bin/security find-generic-password -s ${lib.escapeShellArg keychainService} -w 2>/dev/null)"; then
      # Parsed rather than eval'd so secret values are never run as shell code.
      while IFS='=' read -r name value; do
        [[ -n "$name" ]] && export "$name=$value"
      done <<< "$(/usr/bin/base64 -d <<< "$onepassword_environment")"
    else
      print -u2 "warning: 1Password environment not found in the keychain; run 'just nix-apply' to populate it"
    fi
    unset onepassword_environment name value
  '';
}
