---
name: code-review
description: Performs defect-first reviews of code changes, prioritizing API semantics and correctness over tests, documentation, and style. Use when the user asks to review a diff, commit, branch, or pull request.
---

# Code Review

## Review process

When reviewing a GitHub PR URL or number:

- Use `gh pr view` and `gh pr diff` to retrieve the exact PR.
- Verify the PR number, title, base branch, head branch, and head SHA before reviewing.
- Never assume the currently checked-out branch corresponds to the PR.
- If GitHub access fails, stop and report the access issue.

Review the change, not the entire codebase. Establish the intended behavior from the PR, issue, and commits. Inspect every changed production file plus relevant callers, callees, contracts, tests, and history. Compare against the base version to distinguish introduced defects from pre-existing issues. Trace concrete failure paths end-to-end and verify each finding before reporting it.

Prioritize review effort in this order:

1. API semantics: compatibility, contracts, ownership boundaries, and surprising behavior
2. Implementation semantics: correctness, security, concurrency, data integrity, resource handling, and error paths
3. Documentation: inaccurate or missing documentation for changed behavior
4. Tests: meaningful coverage of behavior, failures, and non-obvious edge cases
5. Code style: readability or maintainability issues that automated tooling cannot enforce

Use formatters, linters, type checkers, and focused tests when available. Do not substitute tool output for semantic review.

## Findings

Report only actionable defects introduced or exposed by the change. Do not report:

- Purely stylistic preferences
- Pre-existing issues unaffected by the change
- Speculative risks without a concrete failure scenario
- Missing tests unless an important behavior or regression is left unverified
- Praise, summaries, or implementation walkthroughs unless requested

For each finding:

- Assign a severity: `P0` blocks all use, `P1` causes serious failures, `P2` causes ordinary functional failures, or `P3` is a limited but real defect.
- Use a short, imperative title.
- Cite the smallest relevant file and line range.
- Explain the concrete failure scenario and impact.
- State why the changed code causes it.
- Suggest a direction for correction when it is not obvious.

Order findings by severity. If there are no actionable findings, say so plainly and mention any verification gaps.
