# Design: <Feature Name>

> What and how. Describes the solution architecture.

---

## Overview

High-level description of the approach.

## Architecture

### Diagram

```
[Input] → [Component A] → [Component B] → [Output]
              ↓
         [Component C]
```

### Components

| Component | Responsibility | Interface |
|-----------|---------------|-----------|
| A | <What it does> | <Key methods> |
| B | <What it does> | <Key methods> |
| C | <What it does> | <Key methods> |

## Data Structures

### Core Data Types

```python
@dataclass
class InputData:
    """Description of input"""
    field1: Type
    field2: Type

@dataclass
class OutputData:
    """Description of output"""
    result: Type
    metadata: MetaType
```

### State Management

- <How state is tracked>
- <Persistence strategy>

## Algorithms/Logic

### Key Algorithm: <Name>

```
1. Step one
2. Step two
3. Step three
```

**Complexity**: <Time/Space>

## External Dependencies

| Dependency | Purpose | Alternative if Unavailable |
|------------|---------|---------------------------|
| <Lib A> | <Usage> | <Fallback> |
| <Service B> | <Usage> | <Fallback> |

## Error Handling

| Error Scenario | Response | Recovery |
|----------------|----------|----------|
| <Error A> | <Action> | <Recovery> |
| <Error B> | <Action> | <Recovery> |

## Testing Strategy

- Unit tests: <Coverage target>
- Integration tests: <Scope>
- E2E tests: <Scenarios>

---

**Design Status**: Draft | Review | Approved
**Last Updated**: <Date>
