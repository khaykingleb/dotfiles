# Shell designed for interactive use
{ pkgs, config, ... }: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    autosuggestion.enable = true;

    shellAliases = {
      vim = "nvim";
      cd = "z";
      cat = "bat --paging=never --style=plain";
      du = "dua";
      df = "duf";
      ls = "eza";
      ll = "eza --long --header";
      la = "eza --all --long --header";
      tree = "eza --tree";
      dig = "doggo";

      # Update gcc compiler to version 14
      gcc = "gcc-14";
      cpp = "cpp-14";
      "c++" = "c++-14";
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
    initContent = ''
      # >>> General
      # Initialize powerlevel10k
      source ~/.p10k.zsh

      # Initialize gcc/clang compilers
      export PATH="/opt/homebrew/opt/gcc/bin:/opt/homebrew/opt/llvm/bin:$PATH"
      export PKG_CONFIG_PATH="/opt/homebrew/bin/pkg-config:$(brew --prefix icu4c)/lib/pkgconfig:$(brew --prefix curl)/lib/pkgconfig:$(brew --prefix zlib)/lib/pkgconfig"

      # Update PATH for MacTeX binaries
      eval "$(/usr/libexec/path_helper)"

      # Cursor style
      echo -e -n "\x1b[\x35 q"                  # Use beam shape cursor on startup
      preexec() { echo -e -n "\x1b[\x35 q" ; }  # Use beam shape cursor for each new prompt

      # Navigate by shell arguments, splitting common command delimiters
      autoload -Uz select-word-style
      select-word-style Shell
      zstyle ':zle:*' subword-range '][/.=:() -'

      # Navigation by words
      bindkey "^[[1;3D" backward-word  # Option + Left Arrow
      bindkey "^[[1;3C" forward-word   # Option + Right Arrow

      # Word deletion
      bindkey $'\ed' kill-word           # Option + d: delete word after cursor
      bindkey $'\es' backward-kill-word  # Option + s: delete word before cursor
      bindkey "∂" kill-word              # macOS Option + d fallback
      bindkey "ß" backward-kill-word     # macOS Option + s fallback

      # Undo
      bindkey $'\ez' undo  # Option + z: undo last edit
      bindkey "Ω" undo     # macOS Option + z fallback
      # <<< General
    '';
  };

  # NOTE: This creates a symlink from ~/.p10k.zsh to the p10k.zsh file in the repo
  # and not copies the file into the Nix store. Thus, the ~/.p10k.zsh is writable by the user
  home = {
    file.".p10k.zsh" = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/dotfiles/users/shared/programs/zsh/p10k.zsh";
    };
  };
}
