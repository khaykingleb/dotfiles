{ pkgs, ... }: {
  imports = [
    ./zsh
    ./terminals

    ./asdf.nix
    ./git.nix
  ];
}
