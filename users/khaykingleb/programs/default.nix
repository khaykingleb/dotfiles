{ ... }: {
  imports = [
    ./iterm2
    ./vscode
    ./zsh

    ./asdf.nix
    ./conda.nix
    ./direnv.nix
    ./docker.nix
    ./git.nix
    ./ssh.nix
  ];
}
