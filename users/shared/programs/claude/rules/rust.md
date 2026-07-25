---
paths:
  - "**/*.rs"
---

# Rust

- Prefer `tokio` for async. Avoid `unwrap()` and `expect()` outside tests.
- Keep tests in a `#[cfg(test)]` module in the same file.
