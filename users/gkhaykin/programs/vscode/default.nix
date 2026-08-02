{ config, ... }:
{
  home.file = {
    "Desktop/misc/misc.code-workspace" = {
      force = true;
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/dotfiles/users/gkhaykin/programs/vscode/misc.code-workspace";
    };
    "Desktop/together/together.code-workspace" = {
      force = true;
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/dotfiles-private/workspaces/together.code-workspace";
    };
  };
}
