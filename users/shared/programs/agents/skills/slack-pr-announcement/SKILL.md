---
name: slack-pr-announcement
description: Produces copy-paste-ready Slack announcements for engineering pull requests, stacked PRs, and cross-repository rollouts. Use when the user asks to introduce a PR, request review in Slack, explain a large or layered change, or announce validation and known issues.
---

# Slack PR Announcement

Write the final message as rendered Markdown that can be copied from Cursor into
Slack's rich-text composer.

## Gather context

1. Inspect every supplied PR with `gh`; verify title, URL, base/head branches,
   stack order, and actual diff scope.
2. Read the related Linear issue when the problem or intended outcome is not
   obvious from the PR.
3. Include cross-repository PRs that are required to deploy or validate the
   change.
4. Report only verification that actually ran. Distinguish local checks, CI,
   QA smoke tests, and production rollout.
5. Surface known issues and temporary workarounds with their tracking ticket.

## Write the message

- Return only the finished Slack message.
- Start with `Hi @name, please take a look at ...` when an audience is given.
- Lead with the problem and why the change exists. Do not begin with a list of
  PRs.
- Explain the proposed solution and its durable boundary in two to four concise
  sentences.
- For a stack, list PRs bottom-to-top with Markdown links and one-line scopes.
- List deployment or infra PRs separately when they are not part of the stack.
- State how to review and merge the stack: layers can be reviewed in parallel,
  preferably bottom-up; merging the top lands the approved stack atomically.
- Include a compact validation summary when it increases reviewer confidence.
- Call out blockers, migration risks, or temporary compatibility measures
  plainly. Never bury them after generic praise.
- Avoid templates, headings, filler, and exhaustive implementation details.

## Example

```markdown
Hi @reviewer, please take a look at the new shaping platform API.

Today, cluster capacity is tied to the FT-owned API, so RL cannot consume the
same fresh cluster view without depending on FT concepts. The new platform API
gives agents one neutral place to report by `cluster_key`, while FT and RL read
the same short-lived capacity contract.

Since the change spans several reviewer boundaries, I split it into a GitHub
stack:

1. [#101 — API contract](https://github.com/example/repo/pull/101) — protobuf,
   generated clients, and API documentation.
2. [#102 — Capacity implementation](https://github.com/example/repo/pull/102)
   — auth, storage, handlers, health, and tests.
3. [#103 — Image publishing](https://github.com/example/repo/pull/103) —
   container and release automation.
4. [#104 — Helm chart](https://github.com/example/repo/pull/104) — deployment,
   secrets, ingress, and probes.

Deployment is tracked separately in
[infra #201](https://github.com/example/infra/pull/201).

QA smoke testing passed authorization, report/get/list, replacement, validation,
expiry, and the documented JSON response shape.

Please note that the legacy service still owns a broad route wildcard. The
infra PR uses a temporary ordering override; the durable routing cleanup is
tracked in [TEAM-123](https://linear.app/example/issue/TEAM-123).

Each stack layer shows only its own diff. Review can happen in parallel,
ideally bottom-up; merging the top PR lands the approved stack atomically.
```
