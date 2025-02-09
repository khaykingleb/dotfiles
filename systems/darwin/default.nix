# System level configuration for MacOS
{ pkgs, lib, ... }:
let
  user = "khaykingleb";
in
{
  imports = [
    ./packages.nix
  ];

  # Used for backwards compatibility
  system.stateVersion = 5;

  # Auto upgrade nix package and the daemon service.
  # services.nix-daemon.enable = true;

  # Setup user, packages, programs
  nix = {
    settings = {
      # Necessary for using flakes on this system
      experimental-features = "nix-command flakes";
    };
  };

  # Allow some unfree packages
  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "vscode"
    "vscode-with-extensions"
    "ngrok"
  ];

  # Tell nix-darwin about the existing user
  # (you need to create the user in the "System Preferences" -> "Users & Groups" first)
  users.users.${user} = {
    name = "${user}";
    home = "/Users/${user}";
    shell = pkgs.zsh;
  };
}
