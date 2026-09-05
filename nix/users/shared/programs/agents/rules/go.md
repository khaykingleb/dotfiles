# Go

- Standard library first; add external dependencies only when necessary.
- `fmt.Errorf("context: %w", err)` for wrapping; `errors.New` for leaf errors.
- Accept interfaces and return concrete types. Interfaces should be as small as the consumer needs — don't require ten methods when only two are used.
- Prefer `any` over `interface{}`.
- `context.Context` is always the first parameter.
- Use table-driven tests with `t.Run` and `testify` for assertions. Run them with `-race`.
- Every goroutine needs a known lifetime: something must wait for it or cancel it. Use `errgroup` for fan-out rather than bare `go` statements.
- Honour cancellation. Pass `ctx` to every blocking call and select on `ctx.Done()` in loops.
- Guard shared state with a mutex, or don't share it. Prefer passing ownership over locking.
