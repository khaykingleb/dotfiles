{ ... }: {
  homebrew = {
    enable = true;

    # NOTE: list of dependencies that shouldn't be isolated with nix as this binaries
    # will be used to build other tools. That's why we're installing them here with homebrew
    brews = [
      "openssl"
      "readline"
      "sqlite3"
      "xz"
      "zlib"
      "gcc@14"
      "llvm@19"
      "ossp-uuid"
      "pkg-config"
      "icu4c"

      # Security
      "gnupg"
      "cosign"
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

      # Research and writing
      "texifier"
      "mactex"
      "zotero"
      "mathpix-snipping-tool"
      "excalidrawz"
      "drawio"

      # Finance
      "ibkr"

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
