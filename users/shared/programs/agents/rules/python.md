---
{
  "description": "Python conventions",
  "filePatterns": [
    "**/*.py",
    "**/pyproject.toml",
    "**/uv.lock"
  ]
}
---

# Python

- Use `uv` for dependency management.
- Use `ruff` for linting and formatting. Prefer `pathlib.Path` over `os.path`.
- Use `pytest` with `@pytest.mark.parametrize` for table-driven tests.
- Type-annotate everything.
- Write Google-style docstrings, enforced by `pydoclint`.
