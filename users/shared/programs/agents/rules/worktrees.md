# Worktrees

- Use an explicit directory name for every new worktree; never accept a generated or implicit name.
- For ticketed work, use `<repository>-<ticket-id-lowercase>` beside the primary checkout, for example `together-shaping-mosh-3603`.
- Use the ticket's configured Git branch name when available.
- Before creation, verify that neither the target directory nor branch already exists.
- Create the worktree from the intended, freshly fetched base branch.
