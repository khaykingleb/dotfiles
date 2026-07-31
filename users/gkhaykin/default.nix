{ inputs, pkgs, ... }:
{
  imports = [
    ../shared/programs
    ./onepassword-environment.nix

    ../shared/completions.nix
    ../shared/fonts.nix

    "${inputs.private-config}/together-awscli.nix"
  ];

  home = {
    username = "gkhaykin";
    homeDirectory = if pkgs.stdenv.hostPlatform.isDarwin then "/Users/gkhaykin" else "/home/gkhaykin";
    stateVersion = "24.11"; # NOTE: you should stay at the version you originally installed
  };

  # Enable HM to manage itself when in standalone mode
  programs.home-manager.enable = true;

  programs.zsh.initContent = ''
    # tenantctl
    source ~/.zsh_tenantctl
  '';
}
