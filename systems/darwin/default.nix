# System level configuration for MacOS
# * Creates actual system users
# * Manages system-wide settings
# * Handles OS-level configurations

{ pkgs, ... }: {
  imports = [
    ./packages.nix
  ];

  # Necessary for using flakes on this system
  nix.settings.experimental-features = "nix-command flakes";

  # Used for backwards compatibility
  system.stateVersion = 5;

  # Tell nix-darwin about the existing user
  # (You need to create the user in the System Preferences -> Users & Groups first)
  users.users.khaykingleb = {
    name = "khaykingleb";
    home = "/Users/khaykingleb";
    shell = pkgs.zsh;
  };
}
