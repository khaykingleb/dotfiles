# Handles system-level configuration for Macbook Pro M4 for work (macOS)
{ user, ... }:
{
  imports = [
    ../../modules/darwin
    ./home-manager.nix
  ];

  my.isPersonal = false;

  # Used for backwards compatibility
  system.stateVersion = 5;
  system.primaryUser = user;

  # networking.hostName = hostName;
}
