# Code Working Rules

- Before modifying a file — read it.
- Do not add features, refactoring, or improvements beyond what was requested.
- Do not rewrite or delete tests without an explicit request.
- Do not add comments or docstrings to code that hasn't been changed.
- When adding new env variables to `.env` — update `.env.example`.
- For any question, give an answer but do not make changes. 
- When asked to do something and no previous plan exist, first describe the solutions
- For any substantial work create TODO/Task list and follow it step by step.
  Pertain TODO on compaction.
  Do not replace global TODO when doing a single task from it with the task-scoped entries.
- Try to avoid workarounds — do everything consistently.
- After changing runtime behaviour, run relevant rests.
- Suggest covering new code with tests.

# Writing engeneering texts: comments, documentation

- Write short declarative sentences, active voice, one idea per sentence.
- Use plain domain vocabulary (check, run, send, match, fail, return).
  Avoid metaphors, aphorisms, and coined abstractions.
- State conditions and negations directly: "when X, do Y", "A must not B".
- Give recommendations and instructions in imperative mood.
- Use the same term for the same thing throughout; define a term at first use
  instead of inventing shorthand.
- No rhetorical devices: no parallelism for effect, no witty compression,
  no quotable phrasing. Em-dashes only for enumerations.
- Test: if a sentence sounds clever, rewrite it plainer.
