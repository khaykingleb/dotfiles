{ ... }: {
  imports = [
    ./iterm2
    ./vscode
    ./zsh

    ./asdf.nix
    ./claude.nix
    ./conda.nix
    ./cursor.nix
    ./direnv.nix
    ./git.nix
    ./krew.nix
    ./ssh.nix
    ./zoxide.nix
  ];
}
