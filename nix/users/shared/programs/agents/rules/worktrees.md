# Worktrees

- Use an explicit directory name for every new worktree; never accept a generated or implicit name.
- For ticketed work, use `<repository>-<ticket-id-lowercase>-<ticket-title-slug>` beside the primary checkout, for example `infra-mosh-3722-deploy-shaping-platform-api-to-qa`.
- Use the ticket's configured Git branch name when available.
- Before creation, verify that neither the target directory nor branch already exists.
- Create the worktree from the intended, freshly fetched base branch.
