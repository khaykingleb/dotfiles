{ pkgs, ... }: {
  # Set up font to MesloLGS NF
  home.packages = with pkgs; [
    iterm2
  ];

  # iTerm2 has an option to load the preferences from a custom location
  # (iTerm2 → Preferences → General → Preferences → Load preferences from a custom folder or URL)
  # Set the location to ~/.config/iterm2/nix_config.plist
  home.file = {
    ".config/iterm2/nix_config.plist" = {
      source = ./config.plist;
    };
  };
}
