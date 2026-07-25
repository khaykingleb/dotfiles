---
paths:
  - "**/*.go"
---

# Go

- Standard library first; add external dependencies only when necessary.
- `fmt.Errorf("context: %w", err)` for wrapping; `errors.New` for leaf errors.
- Accept interfaces and return concrete types. Interfaces should be as small as the consumer needs.
- Prefer `any` over `interface{}`.
- `context.Context` is always the first parameter.
- Use table-driven tests with `t.Run` and `testify` for assertions.
