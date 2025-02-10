# System level configuration for MacOS
{ pkgs, ... }:
{
  imports = [
    ../common
    ./homebrew.nix
  ];

  # Auto upgrade nix package and the daemon service.
  # services.nix-daemon.enable = true;
}
