---
name: coding-principles
description: General clean code principles - Single Level of Abstraction (SLA), Single Responsibility Principle (SRP), Don't Repeat Yourself (DRY), Keep It Simple (KISS), You Aren't Gonna Need It (YAGNI), separation of concerns and others. Use whenever writing, changing or refactoring code, and when reviewing code for readability and maintainability.
---

# Coding Principles

We strive to apply the following principles in all code. They serve readability and a low cost of change; when two
principles conflict, choose the variant that is easier to understand and to change, and say why.

## Structure

- **Single Level of Abstraction (SLA):** all statements of a function are on the same level of abstraction. A
  function either orchestrates steps (calls of well-named functions) or does detail work (string handling, loops,
  arithmetic), not both. Symptom: a high-level step next to low-level details in one function; remedy: extract the
  details into a function named after its intention.
- **Single Responsibility Principle (SRP):** a function, class or module has one reason to change. Symptoms:
  "and" in a name, functions with sections separated by blank lines or comments, classes that change for unrelated
  reasons. For classes, see also the `solid` skill.
- **Separation of concerns:** keep domain logic, persistence, user interface, communication and configuration apart.
- **Composition over inheritance:** inherit only for a real "is a" relation that satisfies the Liskov Substitution
  Principle; otherwise combine objects.

## Encapsulation and immutability

- **Mutable fields are private.** State that can change is only changed through the methods of its class, which
  keep the invariants.
- **Non-private fields are immutable:** `final` (Java), `readonly` or `const` (C#, TypeScript), `const` (C++).
  This makes them safe to share, also between threads.
- The referenced object must be immutable, too: a `final List` or `readonly string[]` can still be modified
  through its content. Use immutable types or unmodifiable copies (e.g. `List.copyOf()`, `ReadonlyArray`,
  `IReadOnlyList`) for non-private fields.

## Duplication and simplicity

- **Don't Repeat Yourself (DRY):** every piece of knowledge (business rule, constant, algorithm, configuration) has
  one authoritative place. DRY is about knowledge, not about similar-looking code: two pieces of code that look the
  same but change for different reasons are not duplicates. Extract when the duplication is the same knowledge;
  when unsure, wait for the third occurrence (rule of three).
- **Keep It Simple (KISS):** choose the simplest solution that meets the requirements. Avoid clever code, needless
  indirection and premature optimization.
- **You Aren't Gonna Need It (YAGNI):** do not build features, parameters, extension points or abstractions for
  requirements that do not exist yet.

## Behavior and interfaces

- **Principle of least astonishment:** names, signatures and behavior do what a reader expects; no hidden side
  effects.
- **Command-query separation (CQS):** a function either changes state (command) or returns a result (query), not
  both, unless there is a good reason (e.g. `pop()`).
- **Tell, don't ask:** tell an object what to do instead of querying its state and deciding for it.
- **Law of Demeter:** a method talks to its direct collaborators only; avoid chains like
  `order.getCustomer().getAddress().getCity()`.
- **Fail fast:** validate input at the boundaries and report errors immediately and clearly; never silently ignore
  errors or return invented defaults.

## Readability

- Names reveal the intention; the name of a function says what it achieves, not how.
- Functions are short and do one thing; few parameters (more than three is a hint to introduce a parameter object).
- No magic numbers or strings: use named constants.
- Comments explain intention, not what the code does.

## Boy scout rule

Leave the code a bit cleaner than you found it, but within the scope of the task: improve what you touch, and
propose larger clean-ups separately instead of mixing them into an unrelated change.
