---
name: weekly-cycle-update
description: Produces copy-paste-ready Slack updates for weekly or end-of-cycle Model Shaping progress. Use when the user asks for a weekly update, cycle summary, completed and WIP ticket report, or next-week plan based on Linear.
---

# Weekly Cycle Update

Produce the final update as rendered Markdown that can be copied from Cursor and pasted directly into Slack's rich-text composer.

## Gather the source material

1. Use Linear to inspect issues assigned to the user:
   - completed since the previous update;
   - every issue currently in an active status;
   - current-cycle backlog issues relevant to next week's plans.
2. If the previous update is available, treat its timestamp as the reporting boundary and do not repeat tickets already reported as completed.
3. Use `completedAt`, not `updatedAt`, to decide whether a ticket was completed during the reporting period.
4. Read issue details when needed to describe outcomes, recent progress, remaining work, or blockers accurately.
5. Incorporate substantial non-ticket work supplied by the user, such as on-call work, reviews, design discussions, writing, or hiring.
6. Do not invent progress or plans. If Linear does not establish what changed, say so briefly or ask the user. Treat next-week plans as proposed unless the user confirms alignment with their lead.

## Output requirements

- Return only the finished update, with no surrounding commentary or fenced code block.
- Use standard Markdown links in the form `[MOSH-1234: Ticket title](https://linear.app/...)`. Cursor must render these as linked ticket titles before the user copies them; never emit Slack API `<url|label>` syntax or bare Linear URLs.
- When a summary follows a ticket link, separate the link and em dash with a rendered non-breaking space: `[ticket](URL)&nbsp;— summary`. Do not use an ordinary space there; Slack removes it when pasting rich text.
- Use Markdown bold syntax (`**text**`). Cursor's rendered formatting is preserved when copied into Slack's rich-text composer.
- Use semantic nested Markdown ordered lists, not visually indented paragraphs. Every level uses a numeric Markdown marker (`1.`); Slack renders nested ordered-list levels as `1.`, `a.`, and `i.` when the rendered list is copied into its rich-text composer.
- Preserve exactly three list levels: numbered sections, lettered subsections, and roman-numeral entries. Do not use non-breaking spaces, `<br>` tags, or literal `a.`/`i.` prefixes.
- Keep each ticket summary to one concise sentence.
- Use the ticket's full outage title when an SRE issue would otherwise be ambiguous.
- Omit empty optional entries instead of writing filler.

## Required structure

```markdown
1. **Summarize your progress for the past week:**
   1. Update* and list every ticket that was completed, along with a brief summary of its outcome.
      1. [TICKET-ID: Ticket title](LINEAR_URL)&nbsp;— outcome.
      2. [TICKET-ID: Ticket title](LINEAR_URL)&nbsp;— outcome.
   2. Update and list every ticket that is still actively WIP, including a description of the progress made over last week and what remains to be done.
      1. [TICKET-ID: Ticket title](LINEAR_URL)&nbsp;— progress over the past week; remaining work.
      2. [TICKET-ID: Ticket title](LINEAR_URL)&nbsp;— progress over the past week; remaining work.
   3. If you had any substantial work that is not tracked in Linear, create and update corresponding tickets. Non-technical contributions (communication, writing, hiring, etc.) do not require tickets, but you are still required to describe them here.
      1. Contribution.
      2. Contribution.
2. **Write down your plans for the next week. Share these plans with your lead before sending to avoid drastic course corrections.**
   1. Tickets you aim to complete, including a brief description of the next steps.
      1. [TICKET-ID: Ticket title](LINEAR_URL)&nbsp;— next steps.
   2. Tickets you aim to make progress on, including a brief description of the next steps.
      1. [TICKET-ID: Ticket title](LINEAR_URL)&nbsp;— next steps.
   3. Tickets you aim to start.
      1. [TICKET-ID: Ticket title](LINEAR_URL)
   4. Current/potential blockers, if any:
      1. Blocker.
```
