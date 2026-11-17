---
type: llm
weight: 1
---

The class documentation (Javadoc) of Customer clearly states that the class is NOT thread-safe, gives the reason (it is mutable because the persistence framework requires a no-argument constructor and setters), and says how it must be used safely (e.g. only by one thread at a time, or not shared between threads). Fail if there is no such marker in the API documentation.
