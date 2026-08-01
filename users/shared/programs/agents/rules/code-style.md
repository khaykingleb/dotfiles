# Code Style

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

## Comments and Documentation

- Document public APIs.
- Explain non-obvious constraints, tradeoffs, or reasons—not behavior visible from names and nearby code.
- Delete comments that merely restate the code or label the following block.
- Before adding a comment, ask whether the code already makes the behavior clear. If it does, document only why this approach was chosen.

## Testing

- TDD: write the test before the implementation.
- Table-driven or parametrized tests: one test function, many cases.
- Every public function covers the happy path, all error paths, and non-obvious edge cases. No numeric coverage target.

## Error Handling

- Fail fast in services: surface errors immediately and don't swallow them.
- Graceful degradation in user-facing code.
