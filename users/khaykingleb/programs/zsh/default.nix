# Shell designed for interactive use
{ pkgs, config, ... }: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
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
      # Initialize powerlevel10k
      source ~/.p10k.zsh

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

      # Conda initialize
      __conda_setup="$('/Users/khaykingleb/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
      if [ $? -eq 0 ]; then
          eval "$__conda_setup"
      else
          if [ -f "/Users/khaykingleb/anaconda3/etc/profile.d/conda.sh" ]; then
              . "/Users/khaykingleb/anaconda3/etc/profile.d/conda.sh"
          else
              export PATH="/Users/khaykingleb/anaconda3/bin:$PATH"
          fi
      fi
      unset __conda_setup
    '';
  };

  # NOTE: This creates a symlink from ~/.p10k.zsh to the p10k.zsh file in the repo
  # and not copies the file into the Nix store. Thus, the ~/.p10k.zsh is writable by the user
  home = {
    file.".p10k.zsh" = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/dotfiles/users/khaykingleb/programs/zsh/p10k.zsh";
    };
  };
}
