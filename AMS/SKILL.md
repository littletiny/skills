---
name: audit-markdown-syntax
description: Check and fix Markdown syntax errors, especially code block nesting issues, broken links, and formatting problems. Use when editing Markdown files to validate syntax correctness before committing.
---

# Audit Markdown Syntax (AMS)

Validate Markdown syntax and fix common errors.

---

## Quick Check

Before committing Markdown changes, verify:

- [ ] No nested code blocks with same delimiter
- [ ] All links properly closed
- [ ] Table formatting correct
- [ ] Header levels sequential

---

## Common Errors

### Error 1: Nested Code Blocks

**Problem**: Code block inside code block with same delimiter

```markdown
```markdown
### Section
```python
def foo(): pass
```
```
```

**Why it fails**: Markdown parser cannot distinguish outer/inner block.

**Fix Options**:

**Option A**: Use 4-space indentation for outer content
```markdown
    ### Section
    ```python
    def foo(): pass
    ```
```

**Option B**: Use different delimiter count
```markdown
````markdown
```python
def foo(): pass
```
````
```

---

### Error 2: Broken Links

**Problem**: Link syntax incomplete
```markdown
[text](url          <- missing closing )
[text](             <- empty URL
[text               <- missing ](url)
```

**Fix**: Complete the link syntax
```markdown
[text](url)
[text](path/to/file.md)
[text](../relative/path)
```

---

### Error 3: Unclosed Code Blocks

**Problem**: Missing closing backticks
```markdown
```python
def foo():
    pass
<!-- Missing ``` -->
```

**Fix**: Add closing delimiter
```markdown
```python
def foo():
    pass
```
```

---

### Error 4: Table Formatting

**Problem**: Inconsistent column count
```markdown
| A | B |
|---|---|---|
| 1 | 2 | 3 |
```

**Fix**: Match column count
```markdown
| A | B | C |
|---|---|---|
| 1 | 2 | 3 |
```

---

## Check Workflow

When asked to check Markdown:

1. **Read file** with `ReadFile` tool
2. **Scan for patterns**:
   - Count opening/closing code block delimiters
   - Check link syntax completeness
   - Verify table alignment
   - Check header level jumps
3. **Report issues** with line numbers
4. **Suggest fixes** with corrected code

---

## Validation Checklist

| Check | Pattern | Fix |
|-------|---------|-----|
| Code block nesting | ``` inside ``` | Use indentation or ```` |
| Broken links | `[text](` without `)` | Add closing `)` |
| Empty links | `[text]()` | Add URL or remove link |
| Unclosed blocks | Odd number of ``` | Add closing delimiter |
| Table columns | Mismatched \| count | Align columns |
| Headers | Skipping levels (# to ###) | Add intermediate level |

---

## Prevention Tips

- Use indentation for showing code block examples
- Close code blocks immediately after content
- Verify links with regex: `\[([^\]]+)\]\(([^)]+)\)`
- Keep tables simple, avoid complex nesting
