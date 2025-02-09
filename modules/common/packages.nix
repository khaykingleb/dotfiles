# List packages installed in system profile
{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    vim
    neovim
    git
    curl
    wget
    neofetch
    tldr
    htop
    jq
    yq
    tree
    bat
    ngrok

    # Nix-related packages
    nil
    nixpkgs-fmt
  ];
}
