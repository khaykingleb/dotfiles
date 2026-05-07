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

It is fine to use clear opener phrases like "This PR addresses", "This PR solves", or "This PR adds" when they make the description read naturally. Do not strip this kind of wording just to be terse.

Use the structure that reads most naturally for the change. One or two short paragraphs is often enough, but bullets are fine when they make the description clearer.

## Example

```text
This PR adds a standalone `together-hf-model-cache-reconciler` chart and deploys it through ArgoCD for model shaping clusters.

It also removes the cache reconciler resources from the `together-finetune` chart, so the reconciler is managed as its own application instead of being embedded in finetune.
```
