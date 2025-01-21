{ pkgs, ... }: {
  # Set up font to MesloLGS NF
  home.packages = with pkgs; [
    iterm2
  ];

  home.file = {
    # iTerm2 has an option to export the preferences to a custom location
    # (iTerm2 → Settings → General → Settings → Load settings from a custom folder or URL
    #  → Specify a custom folder or URL → Save changes)
    # Then move this file here
    "Library/Preferences/com.googlecode.iterm2.plist" = {
      source = ./com.googlecode.iterm2.plist;
    };
  };
}
