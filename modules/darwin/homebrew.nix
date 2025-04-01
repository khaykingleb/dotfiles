{ ... }: {
  homebrew = {
    enable = true;

    # NOTE: list of dependencies that shouldn't be isolated with nix as this binaries
    # will be used to build other tools. That's why we're installing them here with homebrew
    brews = [
      "readline" # line-editing library
      "sqlite3" # lightweight database engine
      "xz" # compression library
      "zlib" # compression library
      "ossp-uuid" # uuid generation library
      "icu4c" # unicode and globalization library

      # Compilers and build tools
      "gcc@14"
      "llvm@19"
      "pkg-config"

      # Security and signing
      "openssl" # ssl/tls toolkit
      "gnupg" # gnu privacy guard
      "cosign" # container signing tool
    ];

    casks = [
      # Development
      "visual-studio-code"
      "cursor"
      "iterm2"
      "docker"
      "tailscale"
      "postman"
      "chatgpt"
      "1password"

      # Productivity
      "todoist"
      "notion"
      "notion-calendar"
      "anki"
      "pomatez"

      # Communication
      "readdle-spark"
      "slack"
      "zoom"

      # TODO(khaykingleb): add preplexity cask when it's available in homebrew
      # Research and writing
      "texifier"
      "mactex"
      "zotero"
      "mathpix-snipping-tool"
      "excalidrawz"
      "drawio"

      # Finance
      "ibkr"
      "tradingview"

      # Misc
      "google-chrome"
      "telegram"
      "spotify"
      "keepassxc"
      "obs"
      "steam"
    ];
  };
}
