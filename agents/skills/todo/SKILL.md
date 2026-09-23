---
name: TODO
description: Maintain a session TODO list in a Markdown file under .agent-todo/.
---

# TODO

Maintain the session TODO list in `.agent-todo/NAME.md` relative to the workspace root.

- Choose a short, descriptive, kebab-case `NAME` for the session. Reuse the same file throughout the session.
- Read an existing TODO file before updating it. Do not overwrite another session's file.
- Use a Markdown heading and checkboxes: `- [ ]` for pending tasks and `- [x]` for completed tasks.
- Create the list before substantial work. Update it as tasks are completed or requirements change.
- Keep tasks concise and actionable. Record blockers under the affected task.
- Preserve the full session list when working on a single task. Add subtasks as needed.
- When work is aborted, replace its entry and all subentries with one struck-out summary: `- ~~Aborted: summary of the work and its subtasks.~~`.
- Include the file path in compaction summaries. Read the file when resuming the session.
