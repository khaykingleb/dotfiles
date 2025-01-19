{ pkgs, ... }: {
  home.packages = with pkgs; [
    nil # Nix Language Server
  ];
}
