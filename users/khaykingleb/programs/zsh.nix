# Shell designed for interactive use
{ pkgs, ... }: {
  programs.zsh = {
    enable = true;
    syntaxHighlighting.enable = true;
    autosuggestion.enable = true;

    oh-my-zsh = {
      enable = true;
      theme = "robbyrussell";
    };

    # Custom ZSH settings
    initExtra = ''
      # Cursor style
      echo -e -n "\x1b[\x35 q"                  # Use beam shape cursor on startup
      preexec() { echo -e -n "\x1b[\x35 q" ; }  # Use beam shape cursor for each new prompt

      # Navigation by words
      bindkey "^[[1;3D" backward-word  # Option + Left Arrow
      bindkey "^[[1;3C" forward-word   # Option + Right Arrow

      # Word deletion
      bindkey "∂" kill-word            # Option + d: delete word after cursor
      bindkey "ß" backward-kill-word   # Option + s: delete word before cursor

      # Undo
      bindkey "Ω" undo                 # Option + z: undo last edit
    '';
  };
}
