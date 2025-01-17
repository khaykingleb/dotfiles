{ pkgs, ... }: {
  imports = [
    ./zsh

    ./git.nix
  ];
}
