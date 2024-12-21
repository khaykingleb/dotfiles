{ pkgs, ... }: {
  imports = [
    ./packages.nix
  ];

  # Necessary for using flakes on this system
  nix.settings.experimental-features = "nix-command flakes";

  # Used for backwards compatibility
  system.stateVersion = 5;

  # The platform the configuration will be used on
  nixpkgs.hostPlatform = "aarch64-darwin";
}
