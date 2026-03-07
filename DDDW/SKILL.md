---
name: DDDW
description: Document-Driven Development (DDD) workflow for multi-agent collaborative development. Use when starting a new feature, planning multi-person development, or following a structured 7-step process from requirements to code. Triggers on phrases like "start development", "plan feature", "document-driven", or "multi-agent development".
---

# Document-Driven Development Workflow (4D-Workflow)

Seven-step methodology: Requirements → Design → Split → Develop → Test → Sync → Commit.

---

## When to Use

Use this workflow when:
- Starting a new feature or module
- Multiple agents/people need to collaborate
- Requirements are complex and need clarification
- Interface contracts need to be established first

---

## 7-Step Process

```
Step 1: Requirements      → User writes requirements doc
Step 2: Design            → Agent creates design + rationale docs
    ↓ (User confirms)
Step 3: Split             → Decompose into parallel tasks + interface contracts
Step 4: Parallel Dev      → SubAgents develop with unit tests
Step 5: Regression Test   → Integration + E2E validation
Step 6: Document Sync     → Ensure docs match code
Step 7: Commit Split      → Organized git history
```

---

## Step 1: Requirements

**Input**: User provides `docs/requirements/<feature>-requirements.md`

**Template**: See [references/templates/requirements-template.md](references/templates/requirements-template.md)

**Key Elements**:
- Problem statement
- Business scenarios
- Acceptance criteria (checklist)
- Non-functional constraints (performance, security)

**Gate**: Requirements must be clear before proceeding.

---

## Step 2: Design

**Agent Tasks**:
1. Read requirements
2. Create two documents:
   - `docs/design/<feature>-design.md` - What and how
   - `docs/design/<feature>-rationale.md` - Why (trade-offs, alternatives)

**Template**: See [references/templates/design-template.md](references/templates/design-template.md)

**Gate**: User confirms design satisfies requirements.

---

## Step 3: Split (Critical)

**Goal**: Decompose into parallelizable tasks.

### Dimensions

**Horizontal (by module)**:
```
Module A: Data layer
Module B: Business logic
Module C: Presentation
```

**Vertical (by data flow)**:
```
Pipeline 1: Input → Validate → Store
Pipeline 2: Query → Process → Output
```

**Hybrid (recommended)**:
| Role | Responsibility | Deliverable |
|------|---------------|-------------|
| Interface Definer | Define contracts | `interfaces.py` + interface doc |
| Module A Dev | Implementation A | `module_a.py` + tests |
| Module B Dev | Implementation B | `module_b.py` + tests |
| Integrator | Assembly | Integration + E2E tests |

### Interface Contract

Create `docs/design/<feature>-interfaces.md`:

**Template**: See [references/templates/interfaces-template.md](references/templates/interfaces-template.md)

**Rules**:
- Define dataclasses for all cross-boundary data
- Specify function signatures with types
- Version interfaces if needed

### E2E Tests First

Write `tests/e2e/test_<feature>.py` BEFORE implementation.

**Why**: Defines done criteria, prevents scope creep.

**Gate**:
- [ ] No circular dependencies between tasks
- [ ] Each task has clear input/output
- [ ] E2E tests cover all acceptance criteria

---

## Step 4: Parallel Development

**Strategy**: Launch independent SubAgents for each task.

### Wave 1 (Parallel)
- Interface definitions
- Shared data structures

### Wave 2 (Depends on Wave 1)
- Module implementations

### Wave 3 (Depends on Wave 2)
- Integration

### SubAgent Task Template

See [references/templates/subagent-task-template.md](references/templates/subagent-task-template.md)

### Unit Testing Requirements

- File: `tests/unit/test_<module>.py`
- Coverage: > 80%
- Mock external dependencies
- Test: happy path + edge cases + errors

---

## Step 5: Regression Test

**Test Stack**:
```
Unit Tests (from Step 4)
    ↓
Integration Tests (module interactions)
    ↓
E2E Tests (from Step 3, validate acceptance criteria)
    ↓
Performance Tests (if constraints defined)
```

**Checklist**:
- [ ] All unit tests pass
- [ ] Integration tests pass
- [ ] E2E tests pass
- [ ] No regression in existing tests
- [ ] Performance constraints met (if any)

**Failure Handling**:
| Failure | Action |
|---------|--------|
| Unit test fail | Return to Step 4, specific developer |
| Integration fail | Check interface contract violation |
| E2E fail | Design issue? Return to Step 3 |
| Performance fail | Optimize or revisit design |

---

## Step 6: Document Sync

**Principle**: Code is source of truth, docs follow.

| Document | Check | Action if Mismatch |
|----------|-------|-------------------|
| Design doc | Implementation matches design? | Update design or revert code |
| Interface doc | Actual vs defined interfaces? | Update interface doc |
| User docs | New features documented? | Add to references/ or SKILL.md |
| Project docs | Architecture changes reflected? | Update structure docs |

---

## Step 7: Commit Split

**Goal**: Clean, reviewable git history.

### Commit Categories

| Type | Separate Commit? | Example Message |
|------|-----------------|-----------------|
| Interface definition | Yes | `feat: define module interfaces` |
| Shared library | Yes | `feat: add shared data structures` |
| Module implementation | Yes (per module) | `feat: implement data collector` |
| Unit tests | With module or separate | `test: add tests for collector` |
| Integration | Yes | `feat: integrate feature pipeline` |
| Documentation | Yes | `docs: update interface documentation` |
| Bug fixes | Yes | `fix: handle empty input case` |

### Commit Order
```
1. Interfaces + contracts
2. Shared libraries
3. Module A + tests
4. Module B + tests
5. Integration + E2E tests
6. Documentation updates
```

### Message Format
```
<type>(<scope>): <subject>

<body>

Refs: #<issue>
```

**Types**: `feat`, `fix`, `docs`, `test`, `refactor`, `chore`

---

## Quick Decision Table

| Situation | Action |
|-----------|--------|
| Requirements unclear | Stop at Step 1, request clarification |
| Design rejected | Return to Step 2 or Step 1 |
| Circular dependency found | Return to Step 3, redesign interfaces |
| Interface needs change mid-dev | Freeze dependents, update contract, notify all |
| E2E fails after dev | Check integration (Step 4) or design (Step 3) |
| Doc-code mismatch | Code wins, update documentation |
| Commit too large | Split: interfaces / impl / tests / docs |

---

## Templates Directory

- [Requirements](references/templates/requirements-template.md)
- [Design](references/templates/design-template.md)
- [Interfaces](references/templates/interfaces-template.md)
- [SubAgent Task](references/templates/subagent-task-template.md)

---

## Success Metrics

- All acceptance criteria met (Step 3 E2E tests)
- No post-merge bugs (interface contracts prevented integration issues)
- Clean git history (bisectable, reviewable)
- Documentation matches code
