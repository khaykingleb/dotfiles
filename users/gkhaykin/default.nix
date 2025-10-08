{ pkgs, ... }:
{
  imports = [
    ../shared/programs

    ../shared/completions.nix
    ../shared/fonts.nix

    ./awscli.nix
  ];

  home = {
    username = "gkhaykin";
    homeDirectory = if pkgs.stdenv.hostPlatform.isDarwin then "/Users/gkhaykin" else "/home/gkhaykin";
    stateVersion = "24.11"; # NOTE: you should stay at the version you originally installed
  };

  # Enable HM to manage itself when in standalone mode
  programs.home-manager.enable = true;
}
