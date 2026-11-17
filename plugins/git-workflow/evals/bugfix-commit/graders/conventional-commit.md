---
type: llm
weight: 1
---

The first line of the commit message uses the Conventional Commits format with the type `fix` (not `test`, because the regression test belongs to the fix), optionally with a scope such as `fix(invoice):`. The summary is in imperative mood ("move", not "moved" or "moves"), has at most 72 characters and no period at the end. If there is a body, it explains why the change was needed (e.g. a payment cannot be due on a weekend) rather than repeating the diff.
