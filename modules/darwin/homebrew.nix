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

      # Security
      "gnupg"
      "cosign"
    ];

    casks = [
      # Development
      "visual-studio-code"
      "cursor"
      "iterm2"
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

      # Research
      "texifier"
      "zotero"
      "mathpix-snipping-tool"

      # Finance
      "ibkr"

      # Misc
      "telegram"
      "spotify"
      "keepassxc"
      "obs"
    ];
  };
}
