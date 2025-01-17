{ pkgs, ... }: {
  # Set up font to MesloLGS NF
  home.packages = with pkgs; [
    iterm2
  ];
}
