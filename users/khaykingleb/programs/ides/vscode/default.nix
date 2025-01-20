{ pkgs, ... }: {
  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      # Nix
      jnoortheen.nix-ide # language support
    ];

    userSettings = {
      "terminal.integrated.fontFamily" = "MesloLGM Nerd Font Mono";
    };
  };
}
