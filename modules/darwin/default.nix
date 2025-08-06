# System level configuration for MacOS
{ lib, ... }:
{
  options.my.isPersonal = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Whether the system is personal or work-related";
  };

  imports = [
    ../common
    ./homebrew.nix
  ];

  # Auto upgrade nix package and the daemon service.
  # services.nix-daemon.enable = true;
}
