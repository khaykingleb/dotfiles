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

    # TODO(khaykingleb): add notion-mail cask when it's available in homebrew
    # Productivity
    "notion"
    "notion-calendar"
    "pomatez"

    # Communication
    #"slack"
    "zoom"

    # TODO(khaykingleb): add preplexity cask when it's available in homebrew
    # Research and writing
    "mathpix-snipping-tool"
    "excalidrawz"
    "drawio"

    # Misc
    "google-chrome"
    "telegram"
    "spotify"
  ];

  personalCasks = lib.lists.flatten [
    # Security
    "1password"
    "keepassxc"

    # Productivity
    "todoist-app"
    "anki"

    # Communication
    "notion-mail"

    # Misc
    "readdle-spark"
    "steam"

    # Research and writing
    "texifier"
    "mactex"
    "zotero"

    # Finance
    "ibkr"
    "tradingview"

    # Misc
    "obs"
    "steam"
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
      "awk"
      "ansible"

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
