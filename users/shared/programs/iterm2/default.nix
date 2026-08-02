{ config, lib, ... }:
{
  home.activation.configureIterm2Preferences = lib.hm.dag.entryAfter [ "linkGeneration" ] ''
    $DRY_RUN_CMD /usr/bin/defaults write com.googlecode.iterm2 \
      LoadPrefsFromCustomFolder -bool true
    $DRY_RUN_CMD /usr/bin/defaults write com.googlecode.iterm2 \
      PrefsCustomFolder -string \
      "${config.home.homeDirectory}/.config/dotfiles/users/shared/programs/iterm2"
  '';
}
