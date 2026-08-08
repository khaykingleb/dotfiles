# Version control system
{ ... }:
{
  programs.git = {
    enable = true;

    # Use git-lfs for large files
    lfs = {
      enable = true;
      skipSmudge = true;
    };

    settings = {
      user = {
        name = "Gleb Khaykin";
        email = "khaykingleb@gmail.com";
      };
      # Push to remote automatically if it's not set
      # (you don't need to run `git push --set-upstream origin <branch>` every time)
      push.autoSetupRemote = true;
      # Pull with rebase instead of merge
      pull.rebase = true;
      # Prune remote branches that have been deleted on the remote
      fetch.prune = true;
    };
  };

  # Use diff-so-fancy for better git diffs
  programs.diff-so-fancy = {
    enable = true;
    enableGitIntegration = true;
  };
}
