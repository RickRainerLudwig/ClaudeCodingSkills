---
type: llm
weight: 1
---

The Order aggregate and its entities and value objects are immutable: all fields are final, collections are unmodifiable or immutable copies, and there are no setters. Operations that change the order (adding a line, placing it) return a new Order instance with the same identity instead of modifying the existing one. Fail if any model class has non-final fields or mutating methods, unless that class is documented as not thread-safe with a reason.
