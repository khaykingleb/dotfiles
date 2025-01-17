# Shell designed for interactive use
{ pkgs, lib, ... }: {
  programs.zsh = {
    enable = true;
    syntaxHighlighting.enable = true;
    autosuggestion.enable = true;

    shellAliases = {
      vim = "nvim";
    };

    # Community-driven framework for managing the zsh configuration
    oh-my-zsh = {
      enable = true;
    };

    plugins = [
      # Theme for Zsh
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
    ];

    # Custom ZSH settings
    initExtra = ''
      # Source powerlevel10k
      source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
      [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

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

  # Save Powerlevel10k config to the user's home directory
  home.file = {
    ".p10k.zsh" = {
      source = ./config/p10k.zsh;
    };
  };
}
