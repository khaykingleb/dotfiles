{ pkgs, ... }: {
  imports = [
    ./zsh
    ./terminals

    ./git.nix
  ];
}
