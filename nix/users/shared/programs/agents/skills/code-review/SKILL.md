---
name: code-review
description: Performs defect and API-design reviews of code changes, prioritizing API semantics and correctness over tests, documentation, and style. Use when the user asks to review a diff, commit, branch, or pull request.
---

# Code Review

## Checking out a pull request

For a GitHub PR URL or number, check out the PR locally. The user walks through the review and iterates on the PR in the same tree.

- Use `gh pr view` and `gh pr diff` to retrieve the exact PR. Read its number, title, and base branch. If GitHub access fails, stop and report the access issue.
- Put review worktrees in the `prs` directory one level above the directory that holds the primary checkout. For a primary checkout at `<root>/<group>/<repo>`, use `<root>/prs`.
- Add each worktree from the review clone at `prs/<repo>`. If that clone does not exist, clone the repository there first. Never check out a PR in the review clone itself.
- Name the worktree `<repo>-<number>-<short-slug>`, with three or four words from the PR title as the slug. Find an existing worktree by matching `<repo>-<number>-*`, so a renamed PR keeps its worktree.
- For a new worktree, fetch the review clone, run `git worktree add --detach <path> origin/<base-branch>`, and then run `gh pr checkout <number>` inside the worktree.
- If the worktree already exists, update it to the latest PR head. If it has uncommitted changes or unpushed commits, stop and ask first. Those are the user's edits.
- Work in the worktree, not in another checkout.
- Never remove review worktrees. The user decides when to clean them up.

## Review process

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

For a PR, rely on CI for formatters, linters, type checkers, and the full test suite. Run a focused test only to confirm a suspected defect. For local changes, which have not been through CI, run the formatters, linters, and type checkers that the repository provides.

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

Start the report with this header. Omit the `PR` line for a local review.

```text
Path: <absolute path of the reviewed tree>
PR: [<repo>#<number>](<url>) <title>
```

Cite files relative to that tree.

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

- Mark it as blocking or non-blocking. Do not assign defect severity unless it also causes a concrete failure.
- Use a short, imperative title.
- Cite the smallest relevant file and line range.
- Give a concrete example using an actual or representative caller, payload, configuration, state transition, or rollout sequence that exposes the concern.
- Explain the affected contract, ownership boundary, compatibility concern, or maintenance consequence.
- Propose a specific correction at the right abstraction level. Include short pseudocode when it makes the solution materially clearer.

Report defects and design concerns in separate sections. If neither has actionable findings, say so plainly and mention any verification gaps.
