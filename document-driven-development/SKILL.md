---
name: document-driven-development
description: DDDW - Document-Driven Development workflow for multi-agent collaborative development with constraint-first approach, mock validation, and knowledge base management for Agent-independent development.
---

# Document-Driven Development Workflow (4D-Workflow)

Seven-step methodology for structured collaborative development.

```
Step 1:  Requirements
    ↓
Step 1.5: Constraints Check
    ↓
Step 2:   Design
    ↓
Step 2.5: Mock Validation
    ↓
Step 3:   Split + KB Init
    ↓
Step 4:   Parallel Dev with KBM
    ↓
Step 5:   Regression Test
    ↓
Step 6:   Document Sync
    ↓
Step 7:   Commit Split
```

---

## When to Use

Use this workflow when:
- Starting a new feature or module
- Multiple agents/people need to collaborate
- Requirements are complex and need clarification
- Interface contracts need to be established first
- **Agent Session continuity is limited**

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

## Step 1.5: Constraints Check

**Goal**: Identify technical constraints **before** architecture decisions.

### Constraints Checklist

| Question | Options | Impact |
|----------|---------|--------|
| **Mandatory frameworks?** | OpenCode / LangChain / Self-built | Architecture foundation |
| **External system protocols?** | MCP / REST / GraphQL / Unknown | Integration approach |
| **Data retrieval capabilities?** | Vector search / Keywords / None | Feature boundaries |
| **Deployment constraints?** | SaaS / On-prem / Hybrid | Tech stack |
| **Session continuity?** | Stateful / Stateless / Limited | Design complexity |

### Key Questions to Ask User

1. **"What must you have?"** (Capabilities)
2. **"What can't you accept?"** (Constraints)
3. **"What don't you have now?"** (Gaps)

### Constraint Documentation

Create `docs/design/<feature>-constraints.md`:

```markdown
# Technical Constraints

## Must Use
- Framework: OpenCode (already deployed)
- Protocol: MCP for all external services

## Must Not Use
- Vector search (not available)
- Real-time push (passive mode required)

## Current Gaps
- No existing IM API (need to design Web API)
- No vector service (use keyword search instead)

## Trade-off Decisions
| Capability | Alternative | Impact |
|------------|-------------|--------|
| Vector search | Keyword search | 70% accuracy acceptable |
```

**Gate**: All constraints documented and user confirmed.

---

## Step 2: Design

**Agent Tasks**:
1. Read requirements
2. **Read constraints** (Step 1.5 output) ⭐
3. Create two documents:
   - `docs/design/<feature>-design.md` - What and how
   - `docs/design/<feature>-rationale.md` - Why (trade-offs, alternatives)

**Template**: See [references/templates/design-template.md](references/templates/design-template.md)

**Gate**: User confirms design satisfies requirements **and** respects constraints.

---

## Step 2.5: Mock Validation

**Goal**: Validate design with executable mocks before interface freeze.

### Deliverables

1. **Mock Services**
   ```
   mocks/
   ├── doc_server_mock.py
   ├── api_server_mock.py
   └── ...
   ```

2. **Sample Data**
   ```
   data/samples/
   ├── sample-reviews/
   └── sample-history/
   ```

3. **Interaction Demo**
   - Recorded walkthrough or
   - Interactive notebook or
   - API endpoint documentation

### User Validation

User must confirm:
- [ ] Mock behavior matches expectations
- [ ] Key use cases are covered
- [ ] Identified constraints are acceptable

**Gate**: User validates mock behavior.

---

## Step 3: Split (Critical) + KB Init

**Goal**: Decompose into parallelizable tasks and initialize Knowledge Base.

### Task Decomposition

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

### Knowledge Base Init

Create `docs/00-meta/` structure:
```
docs/00-meta/
├── project-index.md          # Project navigation
├── session-log.md            # Session records (auto-updated)
├── task-status-board.md      # Task board (auto-updated)
├── decision-log.md           # ADR records
├── bug-registry.md           # Bug tracking
└── change-log.md             # Change history
```

Initialize `task-status-board.md` with all tasks from Split.

**Gate**:
- [ ] No circular dependencies between tasks
- [ ] Each task has clear input/output
- [ ] E2E tests cover all acceptance criteria
- [ ] KB structure created and initialized

---

## Step 4: Parallel Development with KBM

**Strategy**: Launch independent SubAgents for each task with Knowledge Base management.

### Wave 1 (Parallel)
- Interface definitions
- Shared data structures

### Wave 2 (Depends on Wave 1)
- Module implementations

### Wave 3 (Depends on Wave 2)
- Integration

### SubAgent Task Template

See [references/templates/subagent-task-template.md](references/templates/subagent-task-template.md)

**Additional Requirements**:
- Must start with `kbm bootstrap`
- Must end with `kbm checkpoint`
- Must update `task-status-board.md` on completion

### Unit Testing Requirements

- File: `tests/unit/test_<module>.py`
- Coverage: > 80%
- Mock external dependencies
- Test: happy path + edge cases + errors

### Knowledge Base Management

**Each Session must**:

1. **Start**: `kbm bootstrap`
   ```yaml
   command: bootstrap
   project_path: ./
   session_info:
     agent_name: "SubAgent-1"
     focus_area: "mcp-wrappers"
   ```

2. **During Development**:
   - `kbm report-bug` - When bugs found
      - `kbm update-task` - When task status changes
      - `kbm record-decision` - When making decisions
      - `kbm log-change` - When requirements change

3. **End**: `kbm checkpoint`
   ```yaml
   command: checkpoint
   session_id: "session-4"
   progress:
     completed_tasks: [...]
     pending_tasks: [...]
     new_issues: [...]
   ```

See [references/knowledge-base-manager.md](references/knowledge-base-manager.md) for full KBM specification.

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
- [ ] **KB updated with test results**

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
| **KB docs** | Session logs accurate? | Update KB |

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
| **KB update** | Yes | `docs: update session log and task board` |
| Bug fixes | Yes | `fix: handle empty input case` |

### Commit Order
```
1. Interfaces + contracts
2. Shared libraries
3. Module A + tests
4. Module B + tests
5. Integration + E2E tests
6. Documentation updates
7. KB updates (session logs, task board)
```

### Message Format
```
<type>(<scope>): <subject>

<body>

Refs: #<issue>
```

**Types**: `feat`, `fix`, `docs`, `test`, `refactor`, `chore`, `kb`

---

## Quick Decision Table

| Situation | Action |
|-----------|--------|
| Requirements unclear | Stop at Step 1, request clarification |
| **Constraints unclear** | Stop at Step 1.5, request confirmation |
| Design rejected | Return to Step 2 or Step 1 |
| **Mock validation failed** | Return to Step 2, redesign |
| Circular dependency found | Return to Step 3, redesign interfaces |
| Interface needs change mid-dev | Freeze dependents, update contract, notify all |
| E2E fails after dev | Check integration (Step 4) or design (Step 3) |
| Doc-code mismatch | Code wins, update documentation |
| Commit too large | Split: interfaces / impl / tests / docs / kb |
| **Lost context between Sessions** | Run `kbm bootstrap` to recover |

---

## Templates Directory

- [Requirements](references/templates/requirements-template.md)
- [Design](references/templates/design-template.md)
- [Interfaces](references/templates/interfaces-template.md)
- [SubAgent Task](references/templates/subagent-task-template.md)
- [Constraints](references/templates/constraints-template.md)
- [Mock Validation](references/templates/mock-validation-template.md)

---

## Knowledge Base Manager (KBM)

For Agent-independent development, use KBM Skill to maintain context across Sessions.

### Commands

| Command | Usage | Trigger |
|---------|-------|---------|
| `kbm bootstrap` | Recover project context | New Session start |
| `kbm checkpoint` | Record Session progress | Session end |
| `kbm update-task` | Update task status | Task change |
| `kbm report-bug` | Log bug | Bug found |
| `kbm record-decision` | Log ADR | Decision made |
| `kbm log-change` | Log requirement change | Change occurs |
| `kbm query` | Query KB | Info needed |

### KB Structure

```
docs/00-meta/
├── project-index.md          # Navigation
├── session-log.md            # Session records
├── task-status-board.md      # Task board
├── decision-log.md           # ADR records
├── bug-registry.md           # Bug tracking
└── change-log.md             # Change history
```

See [references/knowledge-base-manager.md](references/knowledge-base-manager.md) for full specification.

---

## Success Metrics

- All acceptance criteria met (Step 3 E2E tests)
- No post-merge bugs (interface contracts prevented integration issues)
- Clean git history (bisectable, reviewable)
- Documentation matches code
- **Context recovery time < 2 minutes**
- **Information loss rate < 5%**

---
