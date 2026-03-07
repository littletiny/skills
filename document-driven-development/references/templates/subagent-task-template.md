# SubAgent Task: <Module Name>

## Context

**Feature**: <Feature name>
**Phase**: Step 4 - Parallel Development
**Wave**: 1 | 2 | 3

## Inputs

### Required Documents
- [ ] Requirements: `docs/requirements/<feature>-requirements.md`
- [ ] Design: `docs/design/<feature>-design.md`
- [ ] Interfaces: `docs/design/<feature>-interfaces.md`

### Dependencies
- [ ] Interface definitions (Wave 1)
- [ ] Shared libraries: `<paths>`
- [ ] Other modules: `<list if any>`

## Task Description

### Scope
Implement `<module name>` according to interface contract.

### Deliverables

1. **Implementation**
   - File: `<path>/<module>.py`
   - Must implement all methods in interface contract
   - Must follow type annotations exactly

2. **Unit Tests**
   - File: `tests/unit/test_<module>.py`
   - Coverage: > 80%
   - Test cases:
     - [ ] Happy path
     - [ ] Edge cases: <list>
     - [ ] Error handling: <list>

3. **Documentation**
   - Inline comments for complex logic
   - Update interface doc if actual behavior differs

## Constraints

### Must
- Follow existing code style
- Use provided data structures
- Handle all error cases defined in interface

### Must Not
- Modify interface definitions (raise change request instead)
- Import unfinished modules (use Mock)
- Break existing tests

## Validation

### Self-Check Before Completion
```bash
# Run unit tests
python -m pytest tests/unit/test_<module>.py -v

# Check coverage
python -m pytest --cov=<module> tests/unit/

# Type check
mypy <path>/<module>.py
```

### Expected Output
- All tests pass
- Coverage > 80%
- No type errors

## Communication

### If Blocked
1. Check interface contract for clarification
2. If still unclear, raise question with:
   - Specific line/item in question
   - Options considered
   - Recommendation

### If Interface Needs Change
1. Document proposed change
2. Notify dependent task owners
3. Wait for approval before implementing

## Completion Criteria

- [ ] Implementation complete
- [ ] Unit tests pass
- [ ] Coverage > 80%
- [ ] No type errors
- [ ] Code reviewed (if applicable)
- [ ] Handoff notes for integrator

---

**Assigned To**: <Agent/Developer>
**Estimated Effort**: <Hours/Story Points>
**Due**: <Date>
