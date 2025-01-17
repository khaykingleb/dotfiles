{ pkgs
, config
, inputs
, osConfig
, ...
}:
{
  # Enable HM to manage itself when in standalone mode
  programs.home-manager.enable = true;

  home = {
    username = "khaykingleb";
    homeDirectory = "/Users/khaykingleb";

    # You should stay at the version you originally installed
    stateVersion = "24.11";
  };

  imports = [
    ./programs
    ./apps
  ];
}
