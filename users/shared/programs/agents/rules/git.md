# Git

- Commit messages follow Conventional Commits (enforced by semantic-release): `type(scope): description`. Scope is required; use `scope/ticket` when a ticket number is available. Types: `feat`, `fix`, `refactor`, `test`, `chore`, `docs`, `ci`, `build`, `perf`, `revert`. Breaking changes: `feat!:` or `BREAKING CHANGE:` footer.
- Always run `pre-commit run --all-files` before committing if hooks are configured.
- Never add AI attribution, branding, or co-author trailers to commits or pull requests, including `Co-authored-by` and “Generated with” messages.
