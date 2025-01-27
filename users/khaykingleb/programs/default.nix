{ pkgs, ... }: {
  # General user packages
  home.packages = with pkgs; [
    ngrok
  ];

  # Program specific packages
  imports = [
    ./iterm2
    ./vscode
    ./zsh

    ./asdf.nix
    ./conda.nix
    ./git.nix
    ./nix.nix
    ./ssh.nix
  ];
}
