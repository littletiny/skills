# Methodology: The Layer Cake

> Complex systems fail at boundaries between abstraction layers.

---

## Core Concept

Think of a system as a layer cake:

```
[Application Layer]      ← Business logic, user workflows
[Service Layer]          ← APIs, interfaces, contracts  
[Infrastructure Layer]   ← Databases, networks, filesystem
[System Layer]           ← OS, processes, resources
[Hardware Layer]         ← CPU, memory, disk, network
```

**The Pattern**: When something breaks, the symptom appears at one layer, but the cause often resides at another. The layer boundary is where context gets lost and assumptions get made.

---

## The Lens

### Questions to Ask

- At which layer is the error *manifesting*?
- At which layer is the error *originating*?
- What is being lost in translation between layers?
- What does Layer N assume about Layer N-1 that might not be true?

### Key Distinctions

| Manifestation Layer | Common Root Layers | Translation Gap |
|--------------------|--------------------|-----------------|
| Application error | Service/Infra | Assumed availability |
| Service timeout | System/Network | Assumed responsiveness |
| Data corruption | Infrastructure/Hardware | Assumed durability |
| Performance issue | Any layer below | Assumed capacity |

---

## Boundaries

### When Applicable

- Symptoms don't match apparent cause
- "That should work" but doesn't
- Issues that cross component boundaries
- Heisenbugs that change when observed

### When NOT Applicable

- Pure algorithmic errors (single layer)
- Clear syntax/type errors
- Issues fully contained in one function/module

### Common Misapplications

**Don't use to**: Blame lower layers without evidence. The cake goes both ways—sometimes Layer N-1 breaks because Layer N uses it wrong.

**Don't confuse with**: Simple causality (A → B). Layer Cake is about *translation failures* between contexts.

---

## Related Methodologies

- **[Binary Search]**: Complements by narrowing which layer
- **[Time Travel]**: Helps trace how error propagates up layers
- **[Isolation vs Integration]**: Decides whether to separate or connect layers

---

## Exemplary Cases

- [Case: Markdown nesting error](../cases/2026-03-07-markdown-nesting.md) - Application layer symptom, parser layer cause
- [Case: Import cycle](../cases/2026-03-08-import-cycle.md) - Service layer symptom, design layer cause

---

## Principles Derived

> "Errors are social—they happen at the interface between components, not inside them."

> "The layer that reports the error is rarely the layer that caused it."

> "Assumptions are the gaps between layers."

---

## Evolution Log

| Date | Change | Trigger |
|------|--------|---------|
| 2026-03-07 | Created | Realized markdown parsing error was layer boundary issue (app vs parser) |

---

**Methodology Status**: Stable
