# Case: Markdown Code Block Nesting Error

**Date**: 2026-03-07  
**Context**: Creating SKILL.md for document-driven-dev-workflow  
**Methodology**: [The Layer Cake](../methodology/debugging-layer-cake.md)  
**Status**: Solved

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

Rendered incorrectly—inner Python block wasn't highlighted, outer block terminated early.

**Environment**: Standard Markdown parser (GitHub-flavored)

### Initial Hypothesis

Thought: "Maybe I need more backticks for outer block" (4 backticks instead of 3).

---

## Exploration Journey

### Attempt 1: More Backticks

**Rationale**: More delimiters = stronger nesting

**Action**: Changed outer block to 4 backticks

**Result**: Still didn't work reliably across all parsers

**Reflection**: The issue isn't delimiter strength, it's parser capability. Treating it as "Markdown syntax problem" when it's actually "how parsers work" problem.

---

### Attempt 2: Alternative Syntax (Indentation)

**Rationale**: 

Layer Cake insight kicked in: I'm at "Application Layer" (writing doc), but the problem is at "Parser Layer" (how Markdown handles nesting).

Instead of fighting the parser, use what it *does* support well: indentation for code blocks.

**Action**: 

Changed to 4-space indentation for outer content:

```markdown
    ### Section
    ```python
    def foo(): pass
    ```
```

**Result**: Works consistently

**Reflection**: 

The fix wasn't in Markdown syntax tricks. It was in understanding that "code block inside code block" is actually "showing Markdown source inside a document" which is different from "nested execution contexts."

---

## Resolution

### The Fix

Use indentation (4 spaces) to show Markdown source containing code blocks, rather than trying to nest fenced code blocks.

### Root Cause

**Layer boundary confusion**: 

- Application layer: "I want to show example Markdown"
- Parser layer: "I see fenced code blocks, I'll parse them"
- Gap: No standard way to "escape" or "nest" fenced blocks

The assumption: "If I use more backticks, parser will understand nesting"

The reality: Most Markdown parsers don't support nested fenced code blocks.

---

## Methodological Insights

### Layer Cake Application

**Manifestation**: Markdown rendering wrong (Application layer)  
**Root**: Parser limitation (Infrastructure layer)  
**Translation gap**: Assumed Markdown had nesting support like programming languages

### What This Case Teaches

1. **Format != Language**: Markdown looks like code but parses differently
2. **Work with the layer**: Don't fight parser limitations, use supported features (indentation)
3. **Documentation is translation**: You're writing for humans AND parsers simultaneously

---

## Emotional Trajectory

- **Beginning**: Confident ("I know Markdown, this is easy")
- **Middle**: Frustrated ("Why isn't more backticks working?")
- **End**: Enlightened ("Ah, it's a layer boundary issue, not syntax")

---

## Related Cases

- [Case: Shell escaping in YAML](../cases/2026-02-shell-yaml.md) - Similar layer boundary (shell vs YAML parser)

---

## Open Questions

- Could we lint for this? Detect "looks like nested fences" pattern?
- Are there parsers that DO support this? (CommonMark spec clarification)

---

**Case Author**: Agent (METIS)  
**Last Updated**: 2026-03-07
