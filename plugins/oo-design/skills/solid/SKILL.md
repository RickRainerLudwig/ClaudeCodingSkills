---
name: solid
description: Design classes and interfaces, or assess existing ones, with the SOLID principles of object-oriented design. Use when designing new classes or modules, splitting a class that grew too large, introducing interfaces or abstractions, or reviewing a design for coupling, cohesion and extensibility.
---

# SOLID Principles

Apply the principles to reduce the cost of change, not as an end in themselves. Each recommendation must name the
concrete change it makes easier; otherwise keep the simpler design.

## The principles

- **Single Responsibility (SRP):** a class has one reason to change, i.e. it serves one actor or concern.
  Symptoms of a violation: the class name contains "And" or "Manager", unrelated methods, changes for different
  reasons touch the same class.
- **Open/Closed (OCP):** extend behavior by adding code, not by changing existing code. Symptoms: growing
  `switch`/`if` chains over types. Remedy: polymorphism or strategies, but only for variation that actually occurs.
- **Liskov Substitution (LSP):** a subtype is usable wherever its base type is expected, without surprises.
  Symptoms: overrides that throw "not supported", strengthened preconditions, `instanceof` checks by callers.
- **Interface Segregation (ISP):** clients depend only on the methods they use. Symptoms: implementations with
  empty or throwing methods, interfaces with many unrelated methods.
- **Dependency Inversion (DIP):** high-level policy does not depend on low-level details; both depend on
  abstractions owned by the high-level side. Symptoms: domain code that creates database or HTTP clients itself.

## When reviewing a design

1. Identify the reasons for change and the actors of each class.
2. Check each principle; report violations with the concrete symptom and its cost.
3. Propose the smallest change that removes the cost, and say what it costs in added complexity.
4. Do not introduce abstractions with only one implementation unless they decouple a layer boundary or are needed
   for testing.
