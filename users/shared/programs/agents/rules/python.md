# Python

- Use `uv` for dependency management.
- Use `ruff` for linting and formatting. Prefer `pathlib.Path` over `os.path`.
- Use `pytest` with `@pytest.mark.parametrize` for table-driven tests.
- Type-annotate everything and use `ty` for type checking.
- Write Google-style docstrings, enforced by `pydoclint`.
- Use `asyncio.TaskGroup` for concurrent work. A task whose reference you don't hold can be garbage collected mid-flight, so never fire and forget.
- Don't block the event loop: move synchronous I/O and CPU-bound work to `asyncio.to_thread` or a process pool.
- Put an `asyncio.timeout` on anything that can hang.
- Prefer vertical formatting when it clarifies an expression's outer structure.
  Keep self-contained nested expressions inline when they fit within the line
  limit; do not recursively expand syntax merely because its parent is
  multiline.
