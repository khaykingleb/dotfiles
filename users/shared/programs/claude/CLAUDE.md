# Claude Code — Global Instructions

## Tools

- Shell: zsh
- Editor: Cursor

## Dotfiles

- Store durable personal preferences, Cursor rules, Cursor skills, and Claude instructions in `/Users/gkhaykin/.config/dotfiles`.
- Do not write directly to `~/.cursor` or `~/.claude` for persistent preferences unless the user says it is temporary.
- When adding Cursor or Claude config, update the matching dotfiles Nix mapping so it is managed by Home Manager.

## Code Style

- Write code that is correct, readable, and elegant — in that order.
- Idiomatic over clever. Follow established best practices and ecosystem conventions for the language.
- Don't copy existing patterns in the repo if they are of poor quality.
- Readability first: optimize only when there's a measured problem.
- No over-engineering. Extract abstractions at three or more call sites, not before.
- Dependencies: pragmatic — use what's well-maintained and saves real time.
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

- Conventional Commits (enforced by semantic-release).
- Run `pre-commit run --all-files` before committing if hooks are configured.
