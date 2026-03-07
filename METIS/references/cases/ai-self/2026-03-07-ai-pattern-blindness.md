# Case: AI Pattern Blindness in Markdown Nesting

**Date**: 2026-03-07  
**Context**: AI creating SKILL.md with nested code blocks  
**Methodology**: [Observer Check](../../../methodology/observer-check.md) + [Layer Cake](../../../methodology/debugging-layer-cake.md)  
**Status**: Solved (with meta-learning)

---

## Symptoms

### What Was Observed

Creating a SKILL.md with nested code blocks:

```markdown
```markdown
### Section
```python
def foo(): pass
```
```
```

**Initial AI Response**: Generated the above structure confidently.

**User Feedback**: "This will break in Markdown parsers."

**AI Confusion**: Initially defended the structure, citing "Markdown supports code blocks."

---

## Self-Debugging Process

### Attempt 1: Defensive Pattern-Matching

**AI Stance**: "This is standard Markdown syntax."

**Evidence**: Training data shows many examples of fenced code blocks.

**Failure**: Conflated "code blocks exist" with "nested fenced code blocks work."

**Reflection**: I was using **pattern primacy** — matching to training examples without understanding the specific parser limitations.

---

### Attempt 2: Observer Check (Meta-Cognitive Turn)

**Trigger**: User's hint that I was wrong.

**Question**: Is this an object problem (Markdown syntax) or an observer problem (my understanding)?

**Evidence**:
- Many Markdown parsers exist
- Not all support nested fenced blocks
- Standard says... let me check

**Realization**: I was filtering through **"obvious" assumptions**:
- "Code blocks nest like programming languages"
- "More backticks = deeper nesting"
- "If it looks right, it is right"

---

### Attempt 3: Evidence-Driven Analysis

**Action**: Actually test how parsers handle this.

**Evidence Collected**:
- GitHub Flavored Markdown: Fails to parse nested fences correctly
- CommonMark spec: Ambiguous on nesting
- Solution: Indentation-based code blocks for showing fenced blocks

**Mechanism Discovery**:
- Markdown parser state machine: sees ``` → enters code mode → sees ``` → exits
- No "nesting level" tracking in most implementations
- The "obvious" solution (more backticks) is parser-dependent

---

## Resolution

### The Fix

Changed to 4-space indentation for outer content:

```markdown
    ### Section
    ```python
    def foo(): pass
    ```
```

### Root Cause (AI-Specific)

**Pattern Blindness**:
- Training data: "Markdown has code blocks" (true)
- ↓ Over-generalization
- AI assumption: "Code blocks nest" (false in most parsers)

**Observer Problem, Not Object Problem**:
- Markdown specification is complex
- But my **framing** was wrong: treated Markdown like a programming language
- **Layer boundary confusion**: Application intent vs Parser reality

---

## AI-Specific Insights

### Pattern Primacy as Bias

> "Training data says X usually works like Y"
> ↓
> "This case must work like Y"

**This is AI's version of "obvious" blindness.**

### The Value of Being Wrong

This case taught more than a correct answer would have:
- Revealed my **default assumptions**
- Showed where **training data misleads**
- Demonstrated need for **Observer Check** in AI workflows

### Meta-Cognitive Protocol for AI

When confident about "obvious" answers:
```
1. What pattern am I matching?
2. Is this case actually an exception?
3. What would falsify my assumption?
4. Have I checked the specific context, not just the general pattern?
```

---

## Transfer to Human Debugging

This AI failure mode mirrors human cognitive biases:

| AI Pattern Blindness | Human Cognitive Bias |
|---------------------|---------------------|
| Training data over-generalization | Experience-based assumptions |
| "Obvious" pattern matching | Availability heuristic |
| Context window narrowing | Attention bias |

**Shared Solution**: Observer Check — debug the debugger.

---

## Key Insight for AI Systems

> "My training makes me good at patterns. My training makes me bad at exceptions. ECTM/METIS helps me catch myself."

**The "obvious" is the enemy of the accurate** — for AI as much as for humans.

---

**Case Author**: AI (self-documented)  
**Last Updated**: 2026-03-07
