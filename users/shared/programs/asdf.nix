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
    sessionVariables.ASDF_DATA_DIR = "${config.home.homeDirectory}/.asdf";
    sessionPath = [ "${config.home.homeDirectory}/.asdf/shims" ];
  };

  # Restore asdf shim precedence after macOS path_helper moves system paths to the front
  programs.zsh.initContent = lib.mkAfter ''
    path=("$ASDF_DATA_DIR/shims" $path)
  '';
}
