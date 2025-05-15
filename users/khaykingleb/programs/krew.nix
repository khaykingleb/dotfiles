{ ... }: {
  programs.zsh = {
    initExtra = ''
      # >>> KREW
      export PATH="''${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
      # <<< KREW
    '';
  };
}
