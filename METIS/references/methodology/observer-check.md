# Methodology: Observer Check

> "When you can't see the 'obvious', the blindness is in the observer, not the object."

---

## Core Concept

**The Observer Check** is a meta-cognitive intervention that asks:

> Is the problem in the thing I'm looking at, or in how I'm looking?

This is the debugging equivalent of Einstein's "You can't solve a problem with the same thinking that created it" — except the "creation" is often unconscious bias.

---

## The Lens

### Questions to Ask

- What assumptions am I bringing to this problem?
- What am I filtering out as "obvious" or "irrelevant"?
- What would a fresh observer (human or AI) see that I'm missing?
- Am I solving the problem, or solving my framing of the problem?

### Key Distinctions

| Symptom | Likely Object Problem | Likely Observer Problem |
|---------|----------------------|------------------------|
| Error message clear | Bug in logic | Misinterpretation of error |
| Others see it immediately | Complex bug | Personal blind spot |
| Stuck despite multiple attempts | Deep system issue | Wrong approach/framework |
| "Should work but doesn't" | Hidden dependency | Unstated assumption |

---

## AI-Specific Observer Problems

### 1. Pattern Primacy

**Symptom**: Matching to training data patterns instead of seeing the specific case.

**Example**: "This looks like a race condition" → Actually a configuration issue that *resembles* race conditions.

**Check**: "What specific evidence supports this pattern match?"

### 2. Context Narrowing

**Symptom**: Limited context window causes early information to dominate.

**Example**: First file read suggests X → Subsequent evidence for Y is ignored.

**Check**: "What was in the middle/end of files I scanned?"

### 3. Prompt Capture

**Symptom**: System prompt creates expectations that filter perception.

**Example**: "Simple refactoring" → Under-analyze complex dependencies.

**Check**: "What would I see if this was described as 'complex and dangerous'?"

### 4. Tool Attachment

**Symptom**: Favorite tools become the only tools.

**Example**: Always grep for patterns instead of reading full context.

**Check**: "What would I do if I didn't have this tool?"

### 5. Confidence Calibration Failure

**Symptom**: High confidence without proportionate evidence.

**Example**: "Obviously, the issue is..." → No actual evidence yet.

**Check**: "What would make me change my mind?"

---

## The Intervention: Epoché (Phenomenological Reduction)

**Step 1: Bracket Assumptions**

Suspend:
- "This is a [category] problem"
- "The obvious cause is..."
- "Last time, we..."
- "It should work because..."

**Step 2: Raw Observation**

Describe what you see **without naming or categorizing**:
- Not: "There's a memory leak"
- But: "Process RSS grows 10MB/minute, no corresponding heap growth"

**Step 3: Reframe**

Ask: "What other frames could explain this?"
- If not X, then Y? Z? Something completely different?

---

## When Applicable

- Stuck for >10 minutes on "simple" problem
- Confident answer lacks specific evidence
- Others see what you can't (or vice versa)
- Problem "should" be solved but isn't
- Recurring issues in same category

## When NOT Applicable

- Clear error with clear fix
- Well-understood system with known failure modes
- Time-critical situations (use quick fix, then observer-check later)

---

## Related Methodologies

- **[Layer Cake](debugging-layer-cake.md)**: When problem spans abstraction boundaries
- **[Debug Stance](../../../debug-stance/SKILL.md)**: Universal debugging protocol incorporating observer-check
- **[Cognitive Debug Protocol](cognitive-debug-protocol.md)**: Human-specific version

---

## Exemplary Cases

- [Markdown Nesting Blindness](../cases/ai-self/2026-03-07-ai-pattern-blindness.md) - AI pattern primacy
- [Human Obvious Blind Spot](../cases/cognitive/2024-xx-xx-obvious-blindspot.md) - Human expectation filter

---

## Principles Derived

> "The obvious is the enemy of the true." — Nassim Taleb (paraphrased)

> "Debugging is twice as hard as writing the code in the first place. Therefore, if you write the code as cleverly as possible, you are, by definition, not smart enough to debug it." — Brian Kernighan

---

**Methodology Status**: Stable
