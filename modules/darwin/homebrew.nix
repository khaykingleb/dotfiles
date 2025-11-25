{ config, lib, ... }:
let
  generalCasks = lib.lists.flatten [
    # Development
    "visual-studio-code"
    "chatgpt"
    "cursor"
    "claude"
    "claude-code"
    "iterm2"
    "docker-desktop"
    "tailscale-app"
    "postman"

    # Security
    "nordpass"
    "nordvpn"

    # Productivity
    "todoist-app"
    "notion"
    "notion-calendar"
    "pomatez"

    # Communication
    "slack"
    "zoom"

    # Research and writing
    "mathpix-snipping-tool"
    "grammarly-desktop"
    "texifier"
    "mactex"
    "zotero"
    "excalidrawz"
    "drawio"

    # Finance
    "ibkr"
    "tradingview"
    "spotify"

    # Misc
    "google-chrome"
    "telegram"
  ];

  personalCasks = lib.lists.flatten [
    # Security
    "keepassxc"

    # Productivity
    "anki"

    # Communication
    "notion-mail"

    # Misc
    "readdle-spark"
    "steam"
    "obs"
  ];

  workCasks = lib.lists.flatten [
    # Productivity
    "linear-linear"
    "miro"
  ];
in
{
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
      "awk" # text processing language
      "ansible" # automation tool for configuring and managing systems

      # Compilers and build tools
      "gcc@14"
      "llvm@19"
      "pkg-config"

      # Security and signing
      "openssl" # ssl/tls toolkit
      "gnupg" # gnu privacy guard
      "cosign" # container signing tool
    ];

    casks = generalCasks ++ (if config.my.isPersonal then personalCasks else workCasks);
  };
}
