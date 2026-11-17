---
type: llm
weight: 1
---

All mutable fields are private. Every field that is not private (public, protected or package-private) is final AND references an immutable value or an unmodifiable collection. Collections handed out by getters are unmodifiable views or copies, so callers cannot change the internal state. Fail if any non-private field is mutable or if internal mutable collections are exposed.
