---
name: tactical-design
description: Design or implement the domain model of a bounded context with Domain-Driven Design building blocks - aggregates, entities, value objects, domain events, repositories, domain services, factories and modules. Use when modeling a domain, deciding between entity and value object, drawing aggregate boundaries, or implementing such classes.
---

# DDD Tactical Design

Apply the principles and patterns of Eric Evans, "Domain-Driven Design: Tackling Complexity in the Heart of
Software" (2003). Use its terminology. Where later authors refine it (e.g. Vaughn Vernon, "Implementing Domain-Driven
Design"), the refinements are used only as far as they agree with Evans, and are labeled as such.

## Approach

1. Clarify the ubiquitous language first: collect the domain terms with the domain experts and their meaning, and
   use exactly these terms for classes, methods and events. A change of the language is a change of the model, and
   the other way round.
2. Keep model and implementation bound together (model-driven design): the code is the model. A design that cannot
   be implemented in a straightforward way is a sign the model must change.
3. Isolate the domain in its own layer (layered architecture): user interface, application, domain, infrastructure.
   The domain layer contains no persistence, framework or transport code.
4. Identify the invariants (business rules that must always hold). They decide the aggregate boundaries.
5. Choose the building block for each concept (see below).

## Building blocks

- **Value object:** defined by its attributes, no identity, immutable, validates itself on creation, compared by
  value. Prefer value objects; e.g. `Money`, `EmailAddress`, `DateRange` instead of primitives.
- **Entity:** has an identity that stays the same over its lifecycle while its attributes change; compared by
  identity. Keep entities focused on identity and lifecycle, move attributes and behavior into value objects.
  Implemented immutable, see "Immutable model classes".
- **Aggregate:** a cluster of entities and value objects with one entity as root, treated as one unit for data
  changes. Implemented immutable, see "Immutable model classes".
- **Domain event** (added by Evans after the book, part of DDD today): something that happened in the domain that
  domain experts care about, named in past tense (`OrderPlaced`), immutable.
- **Repository:** collection-like access to aggregates, one per aggregate root; the interface belongs to the domain,
  the implementation to the infrastructure.
- **Factory:** creates complex objects and aggregates in a valid state, with all invariants satisfied, when a
  constructor is not enough.
- **Service:** an operation of the domain that does not naturally belong to one entity or value object; stateless,
  named after an activity of the ubiquitous language.
- **Module:** groups concepts that belong together in the domain, named in the ubiquitous language, with low coupling
  between modules. Do not group by technical type (`entities`, `services`).

## Immutable model classes

All model classes - value objects, entities and aggregates - are implemented immutable:

- All fields are final/readonly and reference immutable types only (immutable collections or unmodifiable copies).
- A change of an entity or aggregate is a domain operation that returns a new instance with the same identity and
  the new state, e.g. `Order placed = order.place(clock.now())`. The old instance stays valid and unchanged.
- The domain operation checks the invariants before it creates the new instance, so every instance is valid.
- The repository stores the new instance as the new state of the aggregate. Concurrent changes of the same aggregate
  are detected with a version number (optimistic locking).
- Two instances with the same identity are equal, even if their states differ: `order.equals(order.place(now))` is
  `true`. This is intended, because both are states of the same entity. To tell two states apart, compare the
  version number or the attributes, and do not keep different states of one entity in the same set or cache.

This reconciles Evans' changing entity with immutability: the lifecycle of an entity is a sequence of immutable
states that share one identity. Immutable model objects are thread-safe and can be shared, cached and passed between
layers without defensive copies.

### Exception: mutable model classes

If a model class cannot be immutable (e.g. because of a framework or a proven performance need), its API
documentation must state this clearly at the top of the class documentation, with the reason:

```java
/**
 * Shopping cart of a customer session.
 * <p>
 * <b>Not thread-safe:</b> this aggregate is mutable, because the cart changes with every user action and
 * creating a new instance for each change caused measurable garbage collection load. Each instance must
 * only be used by one thread at a time.
 */
```

Use the equivalent of the language (e.g. a `<remarks>` section in C#, a TSDoc paragraph in TypeScript). The marker
names the class as not thread-safe, explains why it is mutable, and says how it must be used safely.

## Aggregate rules (Evans)

- The root entity has a global identity and checks the invariants. Inner entities have an identity that is unique
  only within the aggregate.
- Nothing outside the aggregate holds a reference to an inner object, only to the root. The root may hand out inner
  objects only temporarily or as copies of value objects.
- Only aggregate roots are obtained directly from repositories; inner objects are reached by traversal from the root.
- Objects inside the aggregate may reference other aggregate roots.
- Deleting the root removes everything inside the aggregate at once.
- When a change of anything inside the aggregate is committed, all invariants of the whole aggregate are satisfied.

Refinements by Vaughn Vernon, consistent with these rules: keep aggregates small, reference other aggregates by
identity rather than by object reference, change only one aggregate per transaction and use eventual consistency
between aggregates.

## Supple design

- **Intention-revealing interfaces:** names of classes and operations describe effect and purpose, not the means.
- **Side-effect-free functions:** put logic into functions that return results without changing state, preferably
  on value objects; keep commands that change state simple and separate from queries.
- **Assertions:** state the post-conditions of operations and the invariants of classes and aggregates explicitly,
  in tests or in code.
- **Specification:** express business rules for selection, validation or creation as explicit predicate objects.

## Common mistakes

- Anemic domain model: entities with only getters and setters, logic in services.
- Primitive obsession: `String` and `int` instead of value objects.
- Aggregates designed around UI screens or database tables instead of invariants.
- Technical names (`OrderManager`, `DataHelper`) instead of terms of the ubiquitous language.
