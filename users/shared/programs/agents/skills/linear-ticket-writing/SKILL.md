---
name: linear-ticket-writing
description: Writes concise, on-point Linear issues. Use when the user asks to create, draft, rewrite, or improve a Linear ticket, issue, task, bug, or feature request.
---

# Linear Ticket Writing

## Instructions

Write Linear tickets that are concise and on point.

Prefer a short title plus only the context needed to understand the task. Avoid long background sections, speculative future scope, and implementation detail unless it affects the requested work.

Use simple sections only when useful. For feature work, common sections are:

- Goal
- Notes
- Acceptance Criteria

For bugs, common sections are:

- Observed
- Expected
- Notes

Do not force a template for small tickets. Bullets are fine when they make the issue easier to scan.

Keep acceptance criteria concrete and testable.

Default Linear metadata:

- Add the `Model Shaping Platform` label unless the user says otherwise.
- Assign the issue to Gleb Khaykin unless a different owner is specified.
- Set priority based on the urgency implied by the request; ask if unclear.
- Include links, screenshots, or images when the user supplies them and they help explain the issue.

## Example

```markdown
Add HF model cache reconciler support for RL

## Goal

Add HF model cache reconciler support for RL without requiring researchers to manually maintain model revisions in infra.

## Notes

Keep service-authored cache configuration with the RL service. Infra should own the deployment mechanics through the standalone cache reconciler chart.

## Acceptance Criteria

- RL can deploy the cache reconciler through ArgoCD.
- Model cache configuration can be updated from the service side.
- The issue does not require manual infra edits for every model revision change.
```
