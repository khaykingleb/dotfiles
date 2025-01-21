{ pkgs, ... }: {
  # Save the preferences to a custom folder or URL:
  # iTerm2 → Settings → General → Settings → Load settings from a custom folder or URL
  #  → Specify a custom folder or URL → Save changes
  # Then move this file here to com.googlecode.iterm2.plist

  # If you set up iTerm2 from scratch, you need to take com.googlecode.iterm2.plist from the repo
  # and save its contents to ~/Library/Preferences/iterm2/com.googlecode.iterm2.plist
  home.packages = with pkgs; [
    iterm2
  ];
}
