# Code Principles

- Write code that is simple, readable, and elegant. Spend cleverness on finding the simpler design, not on compressing the code that expresses it.
- Optimize only against a profile or benchmark. Choosing a suitable algorithm or data structure is not optimization, it is declining to write the slow version; the same goes for decisions that are cheap now and expensive to retrofit, like N+1 queries or unbounded memory growth.
- Don't copy existing patterns in the repo if they are of poor quality: swallowed errors, untested code, outdated language idioms, opaque naming, wrong abstraction level, or known tech debt (TODO/FIXME). Write it properly and say why you departed from the surrounding code.
- No over-engineering: no speculative abstractions, options, or layers for needs that have not arrived. Extract at three or more call sites, not before, and prefer duplication to an abstraction that does not fit.
- Prefer the standard library. A new dependency widens the agreed scope: raise it before adding it, and say what it buys over writing the code yourself.
- Leave no dead code: delete what you replace, along with unreachable branches, unused helpers, and commented-out blocks.

## API Design

- Keep the exported surface as small as callers need. Unexporting later breaks them; not exporting yet costs nothing.
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
- Write comments about the current contract, invariant, or non-obvious reason. Never describe the diff, mention replaced or removed implementations, restate the code, label a block, or record history; git owns history.
- When you change code, update or delete the comments describing it. A stale comment is worse than no comment.

## Testing

- Fixing a bug starts with a test that reproduces it and fails. For new code, write tests alongside the implementation.
- Test behavior through the public interface, not implementation details: assert on what a call returns or persists, not on which collaborators it invoked or in what order. A test that breaks when you refactor without changing behavior is testing the wrong thing.
- Cover the happy path, the error paths a caller can actually trigger, and non-obvious edge cases. Skip trivial wrappers and accessors. No numeric coverage target.
- Use table-driven or parametrized tests when cases differ only in inputs and expectations; write them separately when the setup or assertions differ.
- Mock only at real boundaries — network, clock, filesystem, external services. Prefer real objects or fakes for anything you own.
- Tests must be deterministic: no sleeps, no wall-clock dependence, no ordering between tests.

## Error Handling

- Fail fast on bugs: violated invariants, impossible states, and programmer error should crash loudly rather than limp on.
- Degrade gracefully on expected external failures: a timeout, an unavailable third party, or a missing optional feature should reduce what the user gets, not break the page. Show them something actionable, never a stack trace or a raw error.
- Never catch an error you cannot handle. Logging it and continuing is swallowing it with extra steps; let it propagate to someone who can decide.
- Add context when propagating, enough that the message alone locates the failure: what was attempted and with which identifiers. Don't restate the same operation at every layer, and never put secrets or personal data in an error message.
