# Shell designed for interactive use
{ pkgs, config, ... }: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    autosuggestion.enable = true;

    shellAliases = {
      vim = "nvim";
      cat = "bat";
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
