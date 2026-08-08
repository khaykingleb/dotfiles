# Runtime version manager
{
  config,
  lib,
  pkgs,
  ...
}:
{
  home = {
    packages = [ pkgs.asdf-vm ];
    file.".tool-versions".source =
      config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/dotfiles/users/shared/programs/asdf/.tool-versions";
    sessionVariables.ASDF_DATA_DIR = "${config.home.homeDirectory}/.asdf";
    sessionPath = [ "${config.home.homeDirectory}/.asdf/shims" ];
  };

  # Restore asdf shim precedence after macOS path_helper moves system paths to the front
  programs.zsh.initContent = lib.mkAfter ''
    path=("$ASDF_DATA_DIR/shims" $path)
  '';
}
