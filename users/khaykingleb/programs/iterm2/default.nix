{ pkgs, config, ... }: {
  # Save the preferences to a custom folder or URL:
  # iTerm2 → Settings → General → Settings → Load settings from a custom folder or URL
  #  → Specify a custom folder or URL → Save changes

  home.packages = with pkgs; [
    iterm2
  ];

  home = {
    file."Library/Preferences/com.googlecode.iterm2.plist" = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/dotfiles/users/khaykingleb/programs/iterm2/com.googlecode.iterm2.plist";
    };
  };
}
