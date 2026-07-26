# System level configuration for macOS
{ lib, user, ... }:
{
  options.my.isPersonal = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Whether the system is personal or work-related";
  };

  imports = [
    ../common
    ./homebrew.nix
    ./home-manager.nix
  ];

  config = {
    system = {
      stateVersion = 5;
      primaryUser = user;
    };
  };
}
