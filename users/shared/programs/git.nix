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

      # Produce cleaner diffs and include the common ancestor in conflict markers.
      diff.algorithm = "histogram";
      diff.colorMoved = "default";
      merge.conflictStyle = "zdiff3";

      # Reuse recorded conflict resolutions across rebases and merges.
      rerere.enabled = true;
      # Delete only merged local branches whose upstream was removed.
      alias.cleanup-branches = ''
        !f() {
          git fetch --prune || return
          git for-each-ref --format='%(refname:short) %(upstream:track)' refs/heads |
            while read -r branch tracking; do
              if [ "$tracking" = "[gone]" ]; then
                git branch -d "$branch"
              fi
            done
        }; f
      '';
    };
  };

  # Use diff-so-fancy for better git diffs
  programs.diff-so-fancy = {
    enable = true;
    enableGitIntegration = true;
  };
}
