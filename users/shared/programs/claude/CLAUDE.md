# Claude Code — Global Instructions

## Tools

- Shell: zsh
- Editor: Cursor

## Dotfiles

- Store durable personal preferences, Cursor rules, Cursor skills, and Claude instructions in `/Users/gkhaykin/.config/dotfiles`.
- Do not write directly to `~/.cursor` or `~/.claude` for persistent preferences unless the user says it is temporary.
- When adding Cursor or Claude config, update the matching dotfiles Nix mapping so it is managed by Home Manager.

## Decision Approval

- Treat questions, exploration, and requests for recommendations as read-only. Do not edit files or mutate external state unless the user explicitly asks for implementation.
- Before implementing, ask when multiple materially different approaches exist or the choice affects architecture, dependencies, security, CI, public APIs, repository structure, or long-term maintenance.
- Obtain explicit approval before broad formatting or rewrites, scope expansion, destructive actions, external writes, repository creation, or publishing data.
- Present the relevant options and tradeoffs concisely. Recommend an option when useful, but do not select it on the user's behalf.
- If the user questions or redirects an active implementation, pause all mutations, answer the question, and wait for explicit confirmation before continuing.
- If the user explicitly delegates a choice with instructions such as "use your judgment" or "pick the best option," proceed without asking again.
- Routine, reversible implementation details within an explicitly approved approach do not require additional approval.
- Read-only investigation and proportionate verification are allowed without approval.

## Code Style

- Write code that is correct, readable, and elegant — in that order.
- Idiomatic over clever. Follow established best practices and ecosystem conventions for the language.
- Don't copy existing patterns in the repo if they are of poor quality. Poor quality signals: swallowed errors, untested code, outdated language idioms, opaque naming, wrong abstraction level, or known tech debt (TODO/FIXME).
- Readability first: optimize only when there's a measured problem.
- No over-engineering. Extract abstractions at three or more call sites, not before.
- Dependencies: pragmatic — prefer stable API and active maintenance (security patches land, tracks ecosystem changes).
- Prefer explicit over implicit.

## Naming

- Descriptive, even if long. Short only in tight scopes (loops, closures).
- No abbreviations at function/module level.

## Comments & Docs

- No comments that narrate what the code does.
- Document public API. Comment non-obvious "why" decisions — not "what".

## Testing

- TDD: write the test before the implementation.
- Table-driven / parametrized tests — one test function, many cases.
- Every public function covers the happy path, all error paths, and non-obvious edge cases. No numeric coverage target.

## Error Handling

- Fail fast in services — surface errors immediately, don't swallow them.
- Graceful degradation in user-facing code.

## Kubernetes

- Always use `kubie` for Kubernetes context management before running `kubectl`.
- Do not assume the current Kubernetes context is correct.
- Default to read-only Kubernetes commands first: `kubectl get`, `kubectl describe`, `kubectl logs`, and `kubectl events`.
- Ask before running mutating commands such as `kubectl apply`, `kubectl delete`, `kubectl patch`, `kubectl rollout restart`, or commands that change context-sensitive state.
- If the intended cluster or namespace is unclear, ask before running any cluster-mutating command.

## Language Conventions

### Go
- Standard library first; add deps only when necessary.
- `fmt.Errorf("context: %w", err)` for wrapping; `errors.New` for leaf errors.
- Accept interfaces, return concrete types. Interfaces should be as small as the consumer needs — don't require 10 methods if you only use 2.
- Prefer `any` over `interface{}`.
- `context.Context` is always the first parameter.
- Table-driven tests with `t.Run`; use `testify` for assertions.

### Rust
- Prefer `tokio` for async. Avoid `unwrap()`/`expect()` outside tests.
- Tests in a `#[cfg(test)]` module in the same file.

### Python
- `uv` for dependency management.
- `ruff` for linting and formatting. Prefer `pathlib.Path` over `os.path`.
- `pytest` with `@pytest.mark.parametrize` for table-driven tests.
- Type-annotate everything.
- Write docstrings in Google style (enforced by `pydoclint`).

## Git

- Conventional Commits (enforced by semantic-release): `type(scope): description`. Scope is required; use `scope/ticket` when a ticket number is available. Types: `feat`, `fix`, `refactor`, `test`, `chore`, `docs`, `ci`, `build`, `perf`, `revert`. Breaking changes: `feat!:` or `BREAKING CHANGE:` footer.
- Run `pre-commit run --all-files` before committing if hooks are configured.
