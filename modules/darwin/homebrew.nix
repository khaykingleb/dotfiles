{ ... }: {
  homebrew = {
    enable = true;

    # NOTE: list of dependencies that shouldn't be isolated with nix as this binaries
    # will be used to build other tools. That's why we're installing them here with homebrew
    brews = [
      "openssl"
      "gnupg"
      "cosign"
      "readline"
      "sqlite3"
      "xz"
      "zlib"
    ];

    casks = [
      # Development
      "visual-studio-code"
      "cursor"
      "iterm2"
      "tailscale"
      "postman"
      "slack"

      # Productivity
      "anki"
      "readdle-spark"
      "todoist"
      "notion"
      "notion-calendar"

      # Research
      "texifier"
      "zotero"
      "mathpix-snipping-tool"

      # Misc
      "telegram"
      "spotify"
    ];
  };
}
