# Git

- Commit messages follow Conventional Commits (enforced by semantic-release): `type(scope): description`. Scope is required; use `scope/ticket` when a ticket number is available. Types: `feat`, `fix`, `refactor`, `test`, `chore`, `docs`, `ci`, `build`, `perf`, `revert`. Breaking changes: `feat!:` or `BREAKING CHANGE:` footer.
- Let configured commit hooks run normally; do not run `pre-commit run --all-files` before every commit. Run focused checks while iterating, and run the full suite only before final PR handoff, when explicitly requested, or when repository policy requires it.
- Never add AI attribution, branding, or co-author trailers to commits or pull requests, including `Co-authored-by` and “Generated with” messages.
- Treat “comment on the PR” as a top-level comment and “comment on lines, entries, or changes” as inline diff comments. Ask which form the user wants when the request is ambiguous.
- Add inline comments only on meaningful decisions or diff hunks. Explain context, rationale, or tradeoffs instead of restating the changed line.
- Put the overall change summary in the PR description or a top-level comment rather than repeating it across inline comments.
