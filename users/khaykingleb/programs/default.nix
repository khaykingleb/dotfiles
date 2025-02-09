{ ... }: {
  imports = [
    ./iterm2
    ./vscode
    ./zsh

    ./asdf.nix
    ./conda.nix
    ./git.nix
    ./ssh.nix
  ];
}
