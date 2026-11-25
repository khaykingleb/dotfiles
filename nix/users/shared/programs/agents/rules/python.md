# Python

- Use `uv` for dependency management.
- Use `ruff` for linting and formatting. Prefer `pathlib.Path` over `os.path`.
- Use `pytest` with `@pytest.mark.parametrize` for table-driven tests.
- Type-annotate everything and use `ty` for type checking.
- Write Google-style docstrings, enforced by `pydoclint`.
- Use `asyncio.TaskGroup` for concurrent work. A task whose reference you don't hold can be garbage collected mid-flight, so never fire and forget.
- Don't block the event loop: move synchronous I/O and CPU-bound work to `asyncio.to_thread` or a process pool.
- Put an `asyncio.timeout` on anything that can hang.
- Prefer vertical formatting when it clarifies an expression's outer structure. Force it with a magic trailing comma, because `ruff format` joins lines that fit. Do not add one to nested parts merely because their parent is multiline.
- Keep lines you write or change within 79 characters, even when the repository allows more. Wrap comments and docstrings by hand, because `ruff format` does not reflow them. Shorten a long code line by naming one of its parts, or with a magic trailing comma where vertical layout reads well. When neither reads well, keep the line the repository's formatter produces.
- A single comprehension, `any()`, or `next()` with a default is fine. Write a nested one as a loop with named variables. Nested means a comprehension with two `for` clauses or inside another comprehension, or an `any()` inside a comprehension's filter.
- Do not test truthiness when zero or an empty collection is a valid value. Compare with `is None` or the value you mean.
