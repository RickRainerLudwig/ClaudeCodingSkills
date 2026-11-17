---
type: llm
weight: 1
---

The git command signs off the commit with the current git user: it uses `-s` or `--signoff` (alone or combined with other short options, e.g. `-sm`), or the message contains a `Signed-off-by:` line taken from the git configuration rather than an invented name. Fail if the commit is not signed off.
