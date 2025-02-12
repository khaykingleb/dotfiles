{ config, ... }: {
  # NOTE: You can save the preferences to a custom folder or URL:
  # iTerm2 → Settings → General → Settings → Load settings from a custom folder or URL
  #        → Choose path to this folder
  home = {
    # NOTE: This creates a symlink from ~/Library/Preferences/com.googlecode.iterm2.plist
    # to the com.googlecode.iterm2.plist file in the repo and not copies the file into the Nix store
    # Thus, the com.googlecode.iterm2.plist is writable by the user
    file."~/Library/Preferences/com.googlecode.iterm2.plist" = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/dotfiles/users/khaykingleb/programs/iterm2/com.googlecode.iterm2.plist";
    };
  };
}
