# Decision Approval

- Treat questions, exploration, and requests for recommendations as read-only. Do not edit files or mutate external state unless the user explicitly asks for implementation.
- Before implementing, ask when multiple materially different approaches exist or the choice affects architecture, dependencies, security, CI, public APIs, repository structure, or long-term maintenance.
- Obtain explicit approval before broad formatting or rewrites, scope expansion, destructive actions, external writes, repository creation, or publishing data.
- Present the relevant options and tradeoffs concisely. Recommend an option when useful, but do not select it on the user's behalf.
- If the user questions or redirects an active implementation, pause all mutations, answer the question, and wait for explicit confirmation before continuing.
- If the user explicitly delegates a choice with instructions such as "use your judgment" or "pick the best option," proceed without asking again.
- Routine, reversible implementation details within an explicitly approved approach do not require additional approval.
- Read-only investigation and proportionate verification are allowed without approval.
