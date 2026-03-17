# Knowledge Base Manager (KBM)

Manage project context across Agent Sessions using living documents.

---

## When to Use

Use KBM when:
- Starting a new Session (recover context)
- Ending a Session (record progress)
- Task status changes
- Bugs discovered
- Decisions made
- Requirements change

---

## Commands

### 1. bootstrap

**Purpose**: Recover project context at Session start

**Input**:
```yaml
command: bootstrap
project_path: ./
session_info:
  agent_name: "SubAgent-1"
  session_type: "development"
  focus_area: "module-a"
```

**Output**:
```markdown
# Session Bootstrap Report

## Project Overview
- Name: <project>
- Phase: DDDW Step X
- Progress: XX%

## Last Session
- Time: <timestamp>
- Completed: [...]
- Pending: [...]

## Active Tasks
| Task | Status | Blocker |
|------|--------|---------|

## Known Issues
- #BUG-001: ...

## Suggested Next Steps
1. ...
```

---

### 2. checkpoint

**Purpose**: Record Session progress at Session end

**Input**:
```yaml
command: checkpoint
session_id: "session-4"
duration_minutes: 45
progress:
  completed_tasks: [...]
  pending_tasks: [...]
  new_issues: [...]
decisions: [...]
blockers: [...]
```

**Output**:
```yaml
status: recorded
updated_docs:
  - docs/00-meta/session-log.md
  - docs/00-meta/task-status-board.md
```

---

### 3. update-task

**Purpose**: Update task status

**Input**:
```yaml
command: update-task
task_id: "W2-1"
changes:
  status: done
  progress: "100%"
  notes: "All tests pass"
```

**Output**:
```yaml
status: updated
task: "W2-1"
previous: in_progress
current: done
```

---

### 4. report-bug

**Purpose**: Log bug

**Input**:
```yaml
command: report-bug
bug:
  title: "..."
  severity: high
  component: "..."
  description: "..."
```

**Output**:
```yaml
bug_id: BUG-003
status: recorded
```

---

### 5. record-decision

**Purpose**: Log architecture decision (ADR)

**Input**:
```yaml
command: record-decision
decision:
  title: "Use X instead of Y"
  context: "..."
  decision: "..."
  consequences:
    positive: [...]
    negative: [...]
```

**Output**:
```yaml
adr_id: ADR-004
status: recorded
```

---

### 6. log-change

**Purpose**: Log requirement/design change

**Input**:
```yaml
command: log-change
change:
  type: requirement
  description: "Add feature Z"
  reason: "User request"
  impact:
    docs: [...]
    code: [...]
```

**Output**:
```yaml
change_id: CHG-005
status: recorded
```

---

### 7. query

**Purpose**: Query knowledge base

**Input**:
```yaml
command: query
query: "active bugs"
# or
query_type: blocked_tasks
```

**Output**:
```markdown
# Query Results

## Blocked Tasks (2)
| Task | Reason | Duration |
|------|--------|----------|
```

---

## Knowledge Base Structure

```
docs/00-meta/
├── project-index.md          # Navigation hub
├── session-log.md            # Session records
├── task-status-board.md      # Task status
├── decision-log.md           # ADR records
├── bug-registry.md           # Bug tracking
└── change-log.md             # Change history
```

---

## Integration with DDDW

| DDDW Step | KBM Command | Purpose |
|-----------|-------------|---------|
| Step 3 | update-task | Init task board |
| Step 4 Start | bootstrap | Recover context |
| Step 4 During | report-bug, update-task | Track progress |
| Step 4 End | checkpoint | Record state |
| Step 5 | query | Check bug status |

---

## Best Practices

1. **Always bootstrap** at Session start
2. **Always checkpoint** at Session end
3. **Immediate logging** for bugs and decisions
4. **Regular queries** to check status
5. **Commit KB changes** with code

---

## Example Workflow

```
[New Session]
    ↓
kbm bootstrap
    ↓
[Development]
    ↓
kbm report-bug (if bug found)
kbm update-task (if task done)
    ↓
[Session End]
    ↓
kbm checkpoint
    ↓
[New Session]
    ↓
kbm bootstrap (recovers all context)
```

---

## Success Metrics

- Context recovery time: < 2 minutes
- Information loss rate: < 5%
- Bug rediscovery rate: < 5%
