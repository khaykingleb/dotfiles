{ config, lib, ... }:
let
  extensions = (import ./extensions.nix) ++ [
    "github.copilot-chat"
    "ms-python.vscode-pylance"
    "ms-vscode-remote.remote-containers"
    "ms-vscode-remote.remote-ssh-edit"
    "ms-vscode-remote.remote-ssh"
    "ms-vscode.remote-explorer"
  ];
in
{
  home = {
    # NOTE: This creates a symlink from ~/Library/Application Support/Code/User/settings.json
    # to the settings.json file in the repo and not copies the file into the Nix store
    # Thus, the settings.json is writable by the user
    file."Library/Application Support/Code/User/settings.json" = {
      force = true;
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/dotfiles/users/shared/programs/vscode/settings.json";
    };

    # Adapted from https://github.com/ryanccn/flake/blob/b9832c59cf9d0362c2d20f838220bed434a0b45a/home/apps/vscode.nix#L214-L244.
    activation = {
      vscodeExtensions = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
        code_bin="/opt/homebrew/bin/code"

        if ! command -v "$code_bin" &> /dev/null; then
          echo "VSCode CLI is not available"
          exit 0
        fi

        declare -A currentExtensions
        for extension in $("$code_bin" --list-extensions); do
          currentExtensions["$extension"]=1;
        done

        ${builtins.concatStringsSep "\n" (
          builtins.map (ext: ''
            if [[ -z "''${currentExtensions[${ext}]+unset}" ]]; then
              echo "Installing ${ext}"
              $DRY_RUN_CMD "$code_bin" --install-extension ${ext} &> /dev/null
            fi
            unset 'currentExtensions[${ext}]'
          '') extensions
        )}

        for ext in "''${!currentExtensions[@]}"; do
          echo "Uninstalling $ext"
          $DRY_RUN_CMD "$code_bin" --uninstall-extension $ext &> /dev/null
          unset 'currentExtensions[$ext]'
        done
      '';
    };
  };
}
