---
name: METIS
description: Methodology Extraction & Transferable Insight System. Use when debugging fails, tests keep breaking, or recurring issues appear. Triggers on phrases like "happened again", "similar issue", "why did this fail", "learn from this", or when needing to extract general principles from specific debugging experiences.
---

# METIS - Methodology Extraction & Transferable Insight System

Transform debugging experiences into reusable methodological wisdom.

---

## Core Philosophy

**Don't memorize solutions. Internalize perspectives.**

| Approach | Risk | METIS Alternative |
|----------|------|-------------------|
| Few-shot examples | Agent copies steps blindly | Methodology provides lenses |
| Decision trees | Rigid, context-blind | Heuristics guide exploration |
| Checklists | Mechanical execution | Principles shape thinking |

**How METIS Works**:
1. **Methodology** (abstract): Ways of thinking about problem classes
2. **Case** (concrete): What happened in a specific situation  
3. **Synthesis**: Apply methodology to new cases with fresh eyes

---

## When to Use

Use METIS when:
- Debugging takes > 3 attempts
- Same category of issue recurs
- Want to extract learnings from solved problems
- Need to onboard new context about failure modes
- Test failures have non-obvious root causes
- **AI-specific**: When you're confident about an "obvious" answer but lack specific evidence

**Don't use for**: Simple, one-off fixes with obvious causes.

---

## Directory Structure (Scheme A)

METIS organizes learning by domain to enable targeted retrieval:

```
METIS/
├── methodology/          # Abstract thinking frameworks
│   ├── debugging-layer-cake.md
│   ├── observer-check.md
│   └── testing-determinism.md
│
├── cases/                # Concrete situational records
│   ├── code/            # Code debugging cases
│   ├── cognitive/       # Human cognitive debugging
│   └── ai-self/         # AI self-reflection cases ← Critical for AI
│
└── principles/          # Cross-cutting insights
    └── cross-domain-truths.md
```

**AI-specific note**: The `ai-self/` directory is where you document your own failures and biases. This is not narcissism—it's calibration.

---

## The METIS Cycle

```
Encounter Problem
    ↓
Debug (ad-hoc)
    ↓
Resolution Achieved
    ↓
┌─────────────────────────────────────┐
│  Document Case                      │
│  - What was observed                │
│  - What was tried                   │
│  - What worked                      │
│  - What was surprising              │
    ↓
│  Map to Methodology                 │
│  - Which lens explains this?        │
│  - What principle was at play?      │
│  - Update or create methodology     │
└─────────────────────────────────────┘
    ↓
Future: Apply methodology (not case) to new problems
```

---

## Document Structure

### Methodology (`references/methodology/`)

**Purpose**: Provide thinking frameworks, not instructions.

**Characteristics**:
- Fuzzy boundaries
- Multiple valid interpretations
- Questions to ask, not steps to follow
- "Consider..." not "Do..."

**Template**: See [references/templates/methodology-template.md](references/templates/methodology-template.md)

### Case (`references/cases/`)

**Purpose**: Rich situational context.

**Characteristics**:
- Specific timestamps, versions, environments
- Complete error messages
- Dead ends explored (not just solution)
- Emotional trajectory (frustration → insight)

**Template**: See [references/templates/case-template.md](references/templates/case-template.md)

### Principles (`references/principles/`)

**Purpose**: Cross-cutting insights linking methodology and case.

**Example**: "Silent failures are harder than loud ones" (principle demonstrated across multiple debugging cases)

---

## Usage Patterns

### Pattern 1: Pre-debugging (Methodology First)

Before starting complex debugging:

1. **Scan methodologies**: What lenses might apply?
2. **Review relevant cases**: What situations resemble this?
3. **Approach fresh**: Use methodologies as perspectives, not prescriptions

```
"I'm seeing test flakiness..."
→ Read: methodology/testing.md (perspective: isolation vs determinism)
→ Read: cases/2026-03-flaky-test-race.md (context: timing issues)
→ Debug: Apply isolation lens to current problem
```

### Pattern 2: Post-resolution (Documentation)

After solving hard problem:

1. **Write case**: Document the journey, not just the fix
2. **Identify methodology**: What abstract principle explains this?
3. **Update or create**: Enrich existing methodology or spawn new

### Pattern 3: Pattern Recognition (Meta-analysis)

Periodically:

1. **Cluster cases**: What methodologies are heavily used?
2. **Identify gaps**: What problem types lack methodological coverage?
3. **Extract principles**: What truths appear across cases?

---

## Methodology Categories

### Debugging

- **The Layer Cake**: Network → System → Process → Code → Data
- **Time Travel**: Forward (flow analysis) vs Backward (impact tracing)
- **Binary Search**: Halving the problem space
- **Isolation vs Integration**: When to decompose vs when to see interactions

### Testing

- **Determinism**: Reproducibility as debugging prerequisite
- **The Test Pyramid**: Unit → Integration → E2E failure signatures
- **Mock Boundaries**: What to fake, what to keep real
- **Oracles**: Sources of truth for correctness

### Design

- **Interface Contract**: Boundaries as failure containment
- **State Surface Area**: Minimizing mutable state
- **Fail Fast vs Graceful**: When to crash, when to recover

See [references/methodology/](references/methodology/) for full list.

---

## Writing Good Methodologies

### Do
- Use metaphors ("Layer Cake", "Binary Search")
- Pose questions ("What assumptions are we making?")
- Acknowledge trade-offs ("Isolation reveals but may mislead")
- Reference multiple cases as examples

### Don't
- Number steps (1. Do this, 2. Do that)
- Be overly specific to one technology
- Prescribe without explaining why
- Create decision trees

**Good**: "Consider whether the issue is deterministic or environmental"
**Bad**: "Check if the test uses random data, if yes, fix the seed"

---

## Writing Good Cases

### Do
- Include full error messages
- Describe false paths taken
- Note emotional state (confused → suspicious → enlightened)
- Link to methodology that explains it

### Don't
- Only document the solution
- Strip away context "for clarity"
- Generalize into "lessons learned" (that's methodology's job)

---

## Directory Structure

```
docs/learning/  (or project root)
├── methodology/
│   ├── debugging.md          # Debugging lenses
│   ├── testing.md            # Testing perspectives
│   ├── refactoring.md        # When/how to restructure
│   └── integration.md        # Combining components
│
├── cases/
│   ├── 2026-03-07-nested-codeblock-parsing.md
│   ├── 2026-03-08-import-cycle-debug.md
│   └── ...                   # One file per learning
│
└── principles/
    └── cross-cutting-insights.md
```

---

## Integration with Workflow

### During Development (with DDDW)

When tests fail in DDDW Step 4/5:

1. Attempt standard debugging
2. If > 3 attempts or non-obvious: **Activate METIS**
3. After resolution: Document case + link to methodology
4. Continue DDDW

### During Exploration (with CREW)

When discussing trade-offs:

1. Reference relevant methodologies as perspectives
2. Use past cases as cautionary tales (not prescriptions)
3. Document new methodologies discovered

---

## Success Indicators

METIS is working when:
- Debugging starts with "What lens applies here?" not "What did we do last time?"
- Cases feel like rich stories, not instruction manuals
- Methodologies remain stable while cases accumulate
- New team members (or Agents) develop intuition faster

---

## Anti-Patterns

### The Cookbook Trap
Cases become recipes → Agent follows blindly → Context ignored

**Fix**: Cases emphasize *why we were confused*, not *what we clicked*.

### The Methodology Bloat
Too many overlapping frameworks → Paralysis by analysis

**Fix**: Merge methodologies. Fewer, sharper lenses > many fuzzy ones.

### The Premature Abstraction
Single case → methodology → Overfitting

**Fix**: Wait for 3+ similar cases before extracting methodology.

---

## Related

- **DDDW**: Development workflow where METIS learns from
- **CREW**: Requirements exploration where METIS principles inform trade-offs
- **AMS**: Check METIS documentation formatting
