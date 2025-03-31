# Handles system-level configuration for Macbook Pro M1 (macOS)
{ hostName, ... }:
{
  imports = [
    ../../modules/darwin
    ./home-manager.nix
  ];

  # Used for backwards compatibility
  system.stateVersion = 5;

  # networking.hostName = hostName;
}
