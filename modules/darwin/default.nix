# System level configuration for MacOS
{ pkgs, ... }:
{
  imports = [
    ../common
  ];

  # Auto upgrade nix package and the daemon service.
  # services.nix-daemon.enable = true;

  nix = {
    settings = {
      # Necessary for using flakes on this system
      experimental-features = "nix-command flakes";
    };
  };
}
