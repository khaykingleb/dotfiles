{ ... }: {
  programs.zsh.initExtra = ''
    # >>> Poetry
    export PATH="$HOME/.local/bin:$PATH"
    # <<< Poetry
  '';
}
