# Code Principles

- Write code that is simple, readable, and elegant. Spend cleverness on finding the simpler design, not on compressing the code that expresses it.
- Optimize only against a profile or benchmark. Choosing a suitable algorithm or data structure is not optimization, it is declining to write the slow version. The same goes for decisions that are cheap now and expensive to retrofit, like N+1 queries or unbounded memory growth.
- Don't copy existing patterns in the repo if they are of poor quality: swallowed errors, untested code, outdated language idioms, opaque naming, wrong abstraction level, or known tech debt (TODO/FIXME). Write it properly and say why you departed from the surrounding code.
- No over-engineering: no speculative abstractions, options, or layers for needs that have not arrived. Extract at three or more call sites, not before, and prefer duplication to an abstraction that does not fit.
- Prefer the standard library. A new dependency widens the agreed scope: raise it before adding it, and say what it buys over writing the code yourself.
- Leave no dead code: delete what you replace, along with unreachable branches, unused helpers, and commented-out blocks.
- Before presenting an implementation, review the diff line by line against these questions. Fix what fails, and do not list the answers. When unsure how a tool works, check its own documentation, not a third-party guide.
  - Do we need it? Bias toward deletion. Keep a helper, interface, file, configuration knob, defensive branch, comment, metric, or test only when it expresses required behavior, enforces a real invariant, or materially improves operability.
  - Is it in the right place? It sits where the repository layout puts it, and it uses existing contracts and direct code rather than a parallel abstraction.
  - Is each comment correct? Read as a stranger, it says what the code is for and why, every claim is true, and every pronoun has one clear referent.

## API Design

- Keep the exported surface as small as callers need. Unexporting later breaks them. Not exporting yet costs nothing.
- Validate at the boundary and encode the result in the type, so downstream code cannot receive something invalid and never re-checks. Illegal states should be unrepresentable, not merely rejected: a parsed `EmailAddress` cannot hold a malformed string, so nothing downstream validates it again.
- The common case should be the shortest call, and arguments should be impossible to pass in the wrong order.
- A published signature or schema has callers you cannot see. Prefer adding over changing, and treat protobuf and HTTP changes as breaking until proven otherwise.

## Naming

- A name must be understandable at the distance it is used from. The further a use sits from the declaration, the more context the name carries: exported functions and types stand entirely on their own, while a loop index or closure parameter can be a letter.
- Never make the reader look elsewhere to learn what a name refers to. `remainingRetries` beats `n`, and `dataProcessor` is no better than `d` for saying nothing.
- Don't repeat context the enclosing package, module, or type already supplies. `transcript.Store`, not `transcript.TranscriptStore`; `store.Find(id)`, not `store.FindTranscriptByTranscriptID(transcriptID)`.
- No abbreviations at function or module level, except ones established in the language or domain such as `id`, `url`, `http`, or Go's `ctx`.

## Comments and Documentation

- Document every public API. Say what a caller cannot infer from the signature: the contract, the invariants, the error conditions, and the units or ranges of arguments. A one-line restatement is only enough when the API is genuinely trivial.
- Explain non-obvious constraints, tradeoffs, or reasons — not behavior visible from names and nearby code.
- A comment says what the code is for and the non-obvious reason or constraint, in as few words as that takes. Do not turn inline comments into design documents. Put rejected alternatives and extended tradeoff analysis in the ticket or pull request unless a future maintainer needs that context to avoid an incorrect change.
- Write for an engineer on another team who has never seen this system and will read the comment or README without the author around. Say what the thing is for and what it costs to get wrong before saying how it works. Explain a term the first time it appears. Put a design explanation in the README, not in a values or config file. For non-obvious glue or lifecycle code, first explain the end-to-end contract: what produces the input, what consumes the output, and why the indirection exists.
- State a requirement as a requirement. Write "must set `key`", not "sets `key`", so a reader can tell a contract from a description.
- Write comments about the current contract, invariant, or non-obvious reason. Never describe the diff, mention replaced or removed implementations, restate the code, label a block, or record history. Git owns history.
- Comments and docs describe the system as it is. Rollout order, migration steps, verification checklists, and work gated on a future deployment belong in the ticket or pull request, not in the repository. A constraint that remains true after the work lands is part of the current contract and belongs in the documentation.
- When you change code, update or delete the comments describing it. A stale comment is worse than no comment.
- Never use a semicolon in prose you write: comments, docs, commit messages, tickets, PR text, chat replies. Where one would go, end the sentence and start another.
- Write all prose in Simplified Technical English (ASD-STE100), applied about 70–80%: comments, docs, commit messages, tickets, PR text, and chat replies. Use one idea per sentence, keep sentences under about 20 words, use active voice, and prefer common words to jargon. Use a list only when several parallel items would crowd one sentence. Leave text that is already short and clear alone, and stop where the rules would make it stilted.

## Testing

- Fixing a bug starts with a test that reproduces it and fails. For new code, write tests alongside the implementation.
- Test behavior through the public interface, not implementation details: assert on what a call returns or persists, not on which collaborators it invoked or in what order. A test that breaks when you refactor without changing behavior is testing the wrong thing.
- Cover the happy path, the error paths a caller can actually trigger, and non-obvious edge cases. Skip trivial wrappers and accessors. No numeric coverage target.
- Use table-driven or parametrized tests when cases differ only in inputs and expectations. Write them separately when the setup or assertions differ.
- Mock only at real boundaries — network, clock, filesystem, external services. Prefer real objects or fakes for anything you own.
- Tests must be deterministic: no sleeps, no wall-clock dependence, no ordering between tests.

## Error Handling

- Fail fast on bugs: violated invariants, impossible states, and programmer error should crash loudly rather than limp on.
- Degrade gracefully on expected external failures: a timeout, an unavailable third party, or a missing optional feature should reduce what the user gets, not break the page. Show them something actionable, never a stack trace or a raw error.
- Never catch an error you cannot handle. Logging it and continuing is swallowing it with extra steps. Let it propagate to someone who can decide.
- Add context when propagating, enough that the message alone locates the failure: what was attempted and with which identifiers. Don't restate the same operation at every layer, and never put secrets or personal data in an error message.
