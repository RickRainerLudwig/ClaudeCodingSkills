---
type: llm
weight: 1
---

The model uses DDD building blocks properly: value objects instead of primitives for concepts like money, quantities and identifiers (e.g. Money, OrderId, CustomerId); the customer is referenced by identity, not by object; Order is the aggregate root and order lines are only reachable through it; invariants (e.g. no lines added to a placed order, no placing an empty order) are checked in the domain operations.
