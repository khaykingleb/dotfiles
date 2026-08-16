{ ... }:
{
  imports = [
    # Editors and agents
    ./claude.nix
    ./cursor
    ./vscode

    # Shell and terminal
    ./atuin.nix
    ./direnv.nix
    ./iterm2
    ./tmux.nix
    ./zoxide.nix
    ./zsh

    # Development
    ./asdf
    ./gh.nix
    ./git.nix
    ./nh.nix
    ./ssh.nix

    # Cloud and Kubernetes
    ./awscli.nix
    ./krew.nix
    ./kubie.nix
  ];
}
