# Runtime version manager
{
  config,
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
}
