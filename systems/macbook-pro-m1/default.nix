# Handles system-level configuration for Macbook Pro M1 (macOS)
{ user, ... }:
{
  imports = [
    ../../modules/darwin
    ./home-manager.nix
  ];

  my.isPersonal = true;

  # Used for backwards compatibility
  system.stateVersion = 5;
  system.primaryUser = user;

  # networking.hostName = hostName;
}
