{
  config,
  pkgs,
  ...
}:
{
  programs.nh = {
    enable = true;
    darwinFlake =
      if pkgs.stdenv.hostPlatform.isDarwin then "${config.home.homeDirectory}/.config/dotfiles" else null;
  };

  home.packages = [ pkgs.nvd ];
}
