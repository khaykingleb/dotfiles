# Cursor editor configuration
{ config, lib, ... }:
let
  managedCursorExtensions = (import ./vscode/extensions.nix) ++ [
    "anthropic.claude-code"
    "anysphere.cursorpyright"
    "anysphere.remote-containers"
    "anysphere.remote-ssh"
    "hediet.vscode-drawio"
  ];
  mcpServers = (import ./agents/mcp-servers.nix { inherit lib; }).cursor;
in
{
  home.file = {
    ".cursor/mcp.json".text = builtins.toJSON { inherit mcpServers; };
    "Library/Application Support/Cursor/User/keybindings.json" = {
      force = true;
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/dotfiles/users/shared/programs/cursor/keybindings.json";
    };
    "Library/Application Support/Cursor/User/settings.json" = {
      force = true;
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/dotfiles/users/shared/programs/vscode/settings.json";
    };
  };

  # Keep Cursor extensions declarative by installing missing entries and removing undeclared ones.
  home.activation.cursorExtensions = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    cursor_bin="/opt/homebrew/bin/cursor"

    if [[ ! -x "$cursor_bin" ]]; then
      echo "Cursor CLI is not available"
    else
      declare -A currentExtensions
      for extension in $("$cursor_bin" --list-extensions); do
        currentExtensions["$extension"]=1
      done

      ${builtins.concatStringsSep "\n" (
        builtins.map (extension: ''
          if [[ -z "''${currentExtensions[${extension}]+unset}" ]]; then
            echo "Installing ${extension}"
            $DRY_RUN_CMD "$cursor_bin" --install-extension ${extension} &> /dev/null
          fi
          unset 'currentExtensions[${extension}]'
        '') managedCursorExtensions
      )}

      for extension in "''${!currentExtensions[@]}"; do
        echo "Uninstalling $extension"
        $DRY_RUN_CMD "$cursor_bin" --uninstall-extension "$extension" &> /dev/null
      done
    fi
  '';
}
