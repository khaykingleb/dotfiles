{ pkgs, ... }: {
  # List packages installed in system profile
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
  ];
}
