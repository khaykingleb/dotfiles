---
name: pr-description
description: Writes short, human-readable pull request descriptions. Use when the user asks for a PR description, pull request body, or wording for a PR, especially when they want it simple and without templates.
---

# PR Description

## Instructions

Write a short, human-readable PR description.

Keep it plain and concise. No headings, no test plan, no summary section, and no external links unless the user explicitly asks for them.

Use bullets only when they make the description easier to read. Do not force bullets for short, straightforward changes.

Only describe what the PR changes and why, based on the actual diff or context provided. Avoid adding broader future context, unrelated implementation details, or issue tracker references unless requested.

Optimize for reviewer understanding. Prefer explaining the user-visible or reviewer-visible bug first, then the important behavior change. Use implementation details only when they help explain why the fix is correct.

For bug fixes, avoid vague summaries like "improves handling." Say what was wrong and what now happens instead. If there is a subtle semantic change, name it plainly.

For incident-driven fixes, focus on the causal bug and the invariant restored by the PR. Do not center incidental symptoms unless they directly explain the fix.

For bug fixes, include concrete before/after evidence (command output, logs, screenshots) when it helps a reviewer verify the fix. Simple "Before:" / "After:" labels around those blocks are fine — that is not the kind of template or heading to avoid.

It is fine to use clear opener phrases like "This PR addresses", "This PR solves", or "This PR adds" when they make the description read naturally. Do not strip this kind of wording just to be terse.

Use the structure that reads most naturally for the change. One or two short paragraphs is often enough, but bullets are fine when they make the description clearer.

## Example

```text
This PR adds a standalone `together-hf-model-cache-reconciler` chart and deploys it through ArgoCD for model shaping clusters.

It also removes the cache reconciler resources from the `together-finetune` chart, so the reconciler is managed as its own application instead of being embedded in finetune.
```

```text
This PR fixes noisy 404s from duplicate orchestrator callbacks.

`MarkCompleted` and `MarkFailed` only update operations that are still `PENDING` or `RUNNING`. When Kafka redelivers a callback for an operation that is already `COMPLETED` or `FAILED`, the update used to match nothing and get reported as `NotFound`.

Now we check that case and treat already-terminal operations as idempotent success. Redis result writes are also first-write-wins, so a duplicate callback cannot overwrite the original result.
```

```text
This PR fixes orphaned RL VCJobs when orchestrator shutdown interrupts session cleanup.

In prod, session `b0fc09e2-833d-4a64-80ed-060d52c007cd` created VCJob `main-b0fc09e2-833d-4a64-80ed-060d52c007cd` and reached `RUNNING`. The API later received a successful stop request for that session, which should have led the orchestrator to tear down the session runtime and delete the VCJob. Around the same time, the orchestrator pod was `OOMKilled`, so cleanup was cancelled before the Kubernetes VCJob delete completed. After restart, the orchestrator lost its in-memory session runtime and startup reconciliation only considered API `RUNNING` sessions. Since the stopped session was no longer active, the leftover VCJob was neither reconnected nor deleted and kept consuming GPUs.

This PR closes both gaps: VCJob deletes are shielded from cancellation once cleanup starts, and startup reconciliation now also compares deployment-owned VCJobs against the active API session set so any leftover VCJob for a non-active session is deleted.
```
