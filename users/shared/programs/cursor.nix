# Cursor rules and Claude Code global instructions
{ config, lib, ... }:
let
  extensions = (import ./vscode/extensions.nix) ++ [
    "anthropic.claude-code"
    "anysphere.cursorpyright"
    "anysphere.remote-containers"
    "anysphere.remote-ssh"
    "hediet.vscode-drawio"
  ];

  rules = [
    "code-style.mdc"
    "dotfiles.mdc"
    "git.mdc"
    "go.mdc"
    "kubernetes.mdc"
    "python.mdc"
    "rust.mdc"
  ];

  skills = [
    "code-review"
    "linear-ticket-writing"
    "pr-description"
  ];
in
{
  home.file =
    {
      ".cursor/mcp.json".source = ./cursor/mcp.json;
      "Library/Application Support/Cursor/User/keybindings.json".source =
        config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/dotfiles/users/shared/programs/cursor/keybindings.json";
      "Library/Application Support/Cursor/User/settings.json".source =
        config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/dotfiles/users/shared/programs/vscode/settings.json";
    }
    //
    (builtins.listToAttrs (map
      (name: {
        name = ".cursor/rules/${name}";
        value.source = ./cursor/rules/${name};
      })
      rules))
    // (builtins.listToAttrs (map
      (name: {
        name = ".cursor/skills/${name}/SKILL.md";
        value.source = ./cursor/skills/${name}/SKILL.md;
      })
      skills));

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
        '') extensions
      )}

      for extension in "''${!currentExtensions[@]}"; do
        echo "Uninstalling $extension"
        $DRY_RUN_CMD "$cursor_bin" --uninstall-extension "$extension" &> /dev/null
      done
    fi
  '';
}
