# Rust

- Prefer `tokio` for async. Avoid `unwrap()` and `expect()` outside tests.
- Never hold a `std::sync::Mutex` guard across an `.await`. Use `tokio::sync::Mutex` when the lock must span a suspension point.
- Move blocking or CPU-bound work off the runtime with `spawn_blocking`.
- Prefer `JoinSet` over detached `tokio::spawn`: a task nobody awaits is a task nobody notices failing.
- Keep tests in a `#[cfg(test)]` module in the same file.
