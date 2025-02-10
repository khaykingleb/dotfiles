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
  };
}
