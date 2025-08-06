# Handles system-level configuration for Macbook Pro M1 (macOS)
{ ... }:
{
  imports = [
    ../../modules/darwin
    ./home-manager.nix
  ];

  my.isPersonal = true;

  # Used for backwards compatibility
  system.stateVersion = 5;

  # networking.hostName = hostName;
}
