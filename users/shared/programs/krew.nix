{ ... }: {
  programs.zsh = {
    initContent = ''
      # >>> KREW
      export PATH="''${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
      # <<< KREW
    '';
  };
}
