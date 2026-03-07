---
name: collaborative-requirements-exploration
description: CREW - Collaborative Requirements Exploration Workshop. Use when user has fuzzy ideas and needs structured discussion to clarify requirements. Triggers on phrases like "I have an idea", "not sure how to", "explore this concept", "help me think through", or when requirements are vague and need discovery before development.
---

# CREW - Collaborative Requirements Exploration Workshop

Transform fuzzy ideas into clear requirements through structured dialogue.

---

## When to Use

Use CREW when:
- User says "I have this idea but not sure..."
- Requirements are vague or conflicting
- Need to explore multiple approaches before deciding
- Want to record thinking process (why & trade-offs)
- Not ready for DDDW (requirements unclear)

**Transition to DDDW**: When exploration document is confirmed, hand off to DDDW for implementation.

---

## Output

Single document: `docs/exploration/<feature>-exploration.md`

This captures:
- Original fuzzy idea
- Clarification dialogue
- Alternatives considered
- Trade-off analysis
- Final consensus

---

## Process

Multi-round structured dialogue (not single-shot).

```
Round 1: Context Gathering
    └─ Ask open questions to understand background

Round 2: Problem Definition  
    └─ Clarify what problem we're solving

Round 3: Solution Brainstorming
    └─ Explore 2-4 possible approaches

Round 4: Deep Dive
    └─ Analyze chosen direction in detail

Round 5: Trade-off Analysis
    └─ Discuss constraints, risks, compromises

Round 6: Consolidation
    └─ Summarize consensus, identify gaps
```

**Stop when**: User confirms "this is clear enough to proceed"

---

## Round 1: Context Gathering

**Goal**: Understand the fuzzy idea.

**Questions to ask**:
- What triggered this idea?
- Who is the target user?
- What does success look like?
- What constraints exist (time, resources, tech)?

**Document**: Record "Initial Idea" section verbatim.

---

## Round 2: Problem Definition

**Goal**: Clarify the core problem, not solution.

**Technique**: "5 Whys" or root cause analysis.

**Questions**:
- Why is this needed?
- What pain does it address?
- What happens if we don't solve this?

**Document**: Add "Problem Statement" section.

---

## Round 3: Solution Brainstorming

**Goal**: Explore multiple approaches without committing.

**Process**:
1. Propose 2-4 distinct approaches
2. For each: list pros/cons roughly
3. Ask user preference (gut feeling)

**Document**: Add "Alternatives Considered" table.

| Approach | Pros | Cons | User Preference |
|----------|------|------|-----------------|
| A | ... | ... | Like/Hate/Meh |
| B | ... | ... | Like/Hate/Meh |

---

## Round 4: Deep Dive

**Goal**: Flesh out the chosen direction.

**Questions**:
- What are the key components?
- What data flows through?
- What are the integration points?
- Any unknowns that need research?

**Document**: Add "Detailed Exploration" section with diagrams/structure.

---

## Round 5: Trade-off Analysis

**Goal**: Explicitly discuss constraints and compromises.

**Framework**: Force trade-offs into the open.

| Dimension | Option A | Option B | Our Choice | Reason |
|-----------|----------|----------|------------|--------|
| Time vs Scope | Fast/MVP | Complete/Slow | ... | ... |
| Flexibility vs Simplicity | Configurable | Hard-coded | ... | ... |
| Build vs Buy | Custom | Off-shelf | ... | ... |

**Document**: Add "Trade-offs" section.

---

## Round 6: Consolidation

**Goal**: Confirm understanding, identify gaps.

**Deliver**:
1. Summary of consensus
2. List of what's clear
3. List of what needs confirmation
4. Recommendation for next step

**Ask**: "Is this clear enough to write formal requirements, or do we need more exploration?"

**Document**: Finalize exploration.md

---

## Document Template

See [references/templates/exploration-template.md](references/templates/exploration-template.md)

---

## Handoff to DDDW

When exploration is complete:

1. **Check**: Ask user "Ready to proceed to implementation planning?"
2. **Generate**: Create `docs/requirements/<feature>-requirements.md` based on exploration
3. **Transition**: "Now using DDDW for development workflow..."

**Requirements generation from exploration**:

| Exploration Section | Requirements Section |
|--------------------|---------------------|
| Problem Statement | Problem + Business Scenarios |
| Detailed Exploration | Functional requirements |
| Trade-offs | Constraints + Non-functional reqs |
| Consensus | Acceptance criteria |

---

## Interaction Rules

### Do
- Ask one question at a time
- Summarize understanding before moving on
- Record user's exact words for "Initial Idea"
- Label assumptions explicitly

### Don't
- Rush to solution
- Make decisions for user
- Skip trade-off discussions
- Let sessions go > 30 min without summarizing

---

## Session Management

**Long exploration?** Save progress:

```markdown
## Session Log

### Session 1: <date>
Completed: Rounds 1-3
Next: Deep dive on chosen approach

### Session 2: <date>
Completed: Rounds 4-6
Status: Ready for requirements
```

---

## Success Indicators

Exploration is successful when:
- User says "yes, that's what I meant"
- Problem is clearly separated from solution
- At least 2 alternatives were considered
- Key trade-offs are documented
- Next steps are obvious

---

## Related Skills

- **DDDW**: Use after CREW completes for implementation
- **audit-markdown-syntax**: Use to check exploration.md formatting
