---
name: code-review
description: Performs defect and API-design reviews of code changes, prioritizing API semantics and correctness over tests, documentation, and style. Use when the user asks to review a diff, commit, branch, or pull request.
---

# Code Review

## Review process

When reviewing a GitHub PR URL or number:

- Use `gh pr view` and `gh pr diff` to retrieve the exact PR.
- Verify the PR number, title, base branch, head branch, and head SHA before reviewing.
- Never assume the currently checked-out branch corresponds to the PR.
- If GitHub access fails, stop and report the access issue.

Review the change, not the entire codebase. Establish the intended behavior from the PR, issue, and commits. Inspect every changed production file plus relevant callers, callees, contracts, tests, and history. Compare against the base version to distinguish introduced defects from pre-existing issues. Trace concrete failure paths end-to-end and verify each finding before reporting it.

Review every change through two lenses:

1. Defects: correctness, security, data integrity, compatibility, and failure handling.
2. API design: contracts, field ownership, abstraction boundaries, coupling, naming, presence semantics, compatibility, and rollout behavior.

Prioritize review effort in this order:

1. API semantics: compatibility, contracts, ownership boundaries, and surprising behavior
2. Implementation semantics: correctness, security, concurrency, data integrity, resource handling, and error paths
3. Documentation: inaccurate or missing documentation for changed behavior
4. Tests: meaningful coverage of behavior, failures, and non-obvious edge cases
5. Code style: readability or maintainability issues that automated tooling cannot enforce

Use formatters, linters, type checkers, and focused tests when available. Do not substitute tool output for semantic review.

## API design review

For API, protobuf, schema, and message changes, verify:

- Fields live on the narrowest type that owns them.
- Shared envelopes contain only genuinely cross-cutting data.
- Variant-specific data lives in the relevant command or response.
- Optionality and default-value semantics are intentional.
- Changes remain backward- and forward-compatible.
- Producer/consumer rollout ordering is safe.
- Internal fields are not unintentionally customer-visible.
- Naming communicates each field's meaning and scope.

## Findings

Report both actionable defects and actionable design concerns introduced or exposed by the change. Do not suppress a design concern merely because the current implementation functions correctly. Do not report:

- Purely stylistic preferences
- Pre-existing issues unaffected by the change
- Speculative risks without a concrete failure scenario or design consequence
- Missing tests unless an important behavior or regression is left unverified
- Praise, summaries, or implementation walkthroughs unless requested

### Defects

For each defect:

- Assign a severity: `P0` blocks all use, `P1` causes serious failures, `P2` causes ordinary functional failures, or `P3` is a limited but real defect.
- Use a short, imperative title.
- Cite the smallest relevant file and line range.
- Give a minimal concrete example showing the relevant state or input, the action that triggers the defect, and the resulting failure.
- Explain the user or operational impact.
- State why the changed code causes it.
- Propose a specific correction at the right abstraction level. Include short pseudocode when it makes the solution materially clearer.

Keep the example and correction concise when the failure and fix are straightforward. Include enough detail that the author can verify the claim and act on it without asking for a follow-up explanation.

Order defects by severity.

### API and design concerns

For each design concern:

- Mark it as blocking or non-blocking; do not assign defect severity unless it also causes a concrete failure.
- Use a short, imperative title.
- Cite the smallest relevant file and line range.
- Give a concrete example using an actual or representative caller, payload, configuration, state transition, or rollout sequence that exposes the concern.
- Explain the affected contract, ownership boundary, compatibility concern, or maintenance consequence.
- Propose a specific correction at the right abstraction level. Include short pseudocode when it makes the solution materially clearer.

Report defects and design concerns in separate sections. If neither has actionable findings, say so plainly and mention any verification gaps.
