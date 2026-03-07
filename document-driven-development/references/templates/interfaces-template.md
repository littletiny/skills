# Interface Contracts: <Feature Name>

> Defines all cross-module boundaries. Changes here affect multiple developers.

---

## Version

**Interface Version**: 1.0
**Last Updated**: <Date>
**Status**: Draft | Stable | Deprecated

---

## Module: <Name A>

### Exports

```python
@dataclass
class DataTypeA:
    """Description"""
    field: Type
    
class ModuleA:
    def method_1(self, input: Type) -> ResultType:
        """Description of what it does.
        
        Args:
            input: Description
            
        Returns:
            Description
            
        Raises:
            ErrorType: When/why
        """
        ...
```

---

## Module: <Name B>

### Exports

```python
@dataclass
class DataTypeB:
    """Description"""
    field: Type
    
class ModuleB:
    def method_1(self, data: DataTypeA) -> ResultType:
        """Description.
        
        Note: Depends on Module A's output format.
        """
        ...
```

---

## Data Flow

```
[External Input]
    ↓
[Module A] → DataTypeA
    ↓
[Module B] → DataTypeB
    ↓
[External Output]
```

---

## Change Log

| Version | Date | Changes | Author |
|---------|------|---------|--------|
| 1.0 | <Date> | Initial interface definition | <Name> |

---

## Review Checklist

- [ ] All data structures have type annotations
- [ ] All functions have docstrings
- [ ] Error cases documented
- [ ] No circular dependencies
- [ ] Version number updated on change
