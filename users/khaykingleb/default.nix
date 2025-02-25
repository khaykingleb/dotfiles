{ pkgs, ... }:
{
  imports = [
    ./programs

    ./completions.nix
    ./fonts.nix
  ];

  home = {
    username = "khaykingleb";
    homeDirectory = if pkgs.stdenv.hostPlatform.isDarwin then "/Users/khaykingleb" else "/home/khaykingleb";
    stateVersion = "24.11"; # NOTE: you should stay at the version you originally installed
  };

  # Enable HM to manage itself when in standalone mode
  programs.home-manager.enable = true;
}
