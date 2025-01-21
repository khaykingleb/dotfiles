{ pkgs, ... }: {
  home.packages = with pkgs; [
    nil # nix language server
    nixpkgs-fmt # nix formatter
  ];
}
