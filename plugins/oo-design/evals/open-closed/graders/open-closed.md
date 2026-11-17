---
type: llm
weight: 1
---

The review identifies the growing switch over carriers as a violation of the Open/Closed Principle (OCP): every new carrier requires a change of this class. It proposes polymorphism or a strategy per carrier (e.g. a ShippingTariff interface with one implementation per carrier), and names the concrete change this makes easier: adding a carrier without changing existing code.
