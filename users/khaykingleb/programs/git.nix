# Version control system
{ ... }: {
  programs.git = {
    enable = true;
    userName = "Gleb Khaykin";
    userEmail = "khaykingleb@gmail.com";

    lfs.enable = true;

    extraConfig = {
      # Push to remote automatically if it's not set (won't need to run `git push --set-upstream origin <branch>` every time)
      push.autoSetupRemote = true;
      # Pull with rebase instead of merge
      pull.rebase = true;
      # Automatically setup merge branches when pulling
      branch.autoSetupMerge = true;
    };
  };
}
