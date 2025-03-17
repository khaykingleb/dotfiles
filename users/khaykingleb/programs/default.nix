{ ... }: {
  imports = [
    ./iterm2
    ./vscode
    ./zsh

    ./asdf.nix
    ./conda.nix
    ./direnv.nix
    ./git.nix
    ./ssh.nix
    ./zoxide.nix
  ];
}
