---
name: context-bridge
description: Create COBRA (Context Orchestrated Bridge Resource Archive) documents for complex systems to preserve institutional knowledge across AI sessions. Use when (1) debugging a complex system repeatedly across multiple sessions, (2) the system has non-obvious mechanisms not covered by official docs, (3) context reconstruction costs are high, (4) needing to bootstrap a new session with distilled system knowledge.
triggers:
  - "context bridge"
  - "COBRA"
  - "system notes"
  - "document system"
  - "knowledge transfer"
  - "system knowledge"
  - "preserve context"
---

# COBRA: Context Orchestrated Bridge Resource Archive



Create lightweight, referenceable system knowledge documents for cross-session AI debugging.

## Purpose

When debugging complex systems:
- Rebuilding context each session wastes time and tokens
- Official docs miss implementation details and edge cases
- Session context gets polluted with failed attempts
- New sessions need "fresh eyes" but also core facts

COBRA bridges this gap: a distilled, structured archive that preserves essential system knowledge without the baggage of failed debugging attempts.

---

## When to Use

| Scenario | Use This Skill | Don't Use |
|----------|----------------|-----------|
| 3rd+ time debugging same system | ✅ | |
| Rebuilding cognitive context takes >10 min | ✅ | |
| Mechanisms implicit in code, not docs | ✅ | |
| One-time debug, won't revisit | | ✅ |
| Official docs already comprehensive | | ✅ |
| System changes frequently | | ✅ |

> **COBRA = Context Orchestrated Bridge Resource Archive**
> - **C**ontext — 保存调试上下文
> - **O**rchestrated — 经过提炼、有组织的知识
> - **B**ridge — 桥接不同 Session 的连续性
> - **R**esource — 可复用的知识资源
> - **A**rchive — 持久化存档，随时间累积

---

## What to Document: Decision Framework

Not everything deserves a COBRA document. Use this framework to decide what to capture:

### The 3-Test Rule

Before documenting, ask:

1. **Reconstruction Test**: Will I need to spend >5 minutes figuring this out again?
2. **Surprise Test**: Did this behavior surprise me despite reading the docs?
3. **Stability Test**: Is this likely to remain true for >1 month?

**Score 2/3 or higher → Document it**

### Information Hierarchy

| Priority | What to Capture | What to Skip |
|----------|-----------------|--------------|
| **P0** | Non-obvious mechanisms, implicit constraints, critical paths with exact file locations | |
| **P1** | Symptom-to-cause mappings, configuration quirks, version-specific behaviors | |
| **P2** | Useful commands, common operations, debug shortcuts | |
| **Skip** | | Basic setup (if well-documented), code snippets (>20 lines), emotional narrative |

### Recognition Triggers

Document when you encounter:
- **Counter-intuitive behavior**: System does X, but you expected Y
- **Hidden dependencies**: A relies on B in a non-obvious way
- **Time bombs**: Things that work now but will break under specific conditions
- **Magic values**: Hardcoded numbers or strings with special meaning
- **Layer violations**: Code at layer N reaching into layer N-2

---

## The Extraction Process

Don't just dump information. Follow this cognitive process:

### Step 1: Isolate Facts from Speculation

```
Raw debugging notes:
"We tried increasing the timeout but it didn't help. 
Maybe it's a connection pool issue? The error says 
'connection refused' so probably the DB is down."

Extracted facts:
- Error message: "connection refused"
- Increasing timeout had no effect
- Connection pool hypothesis: UNVERIFIED ❓
- DB status hypothesis: UNVERIFIED ❓
```

### Step 2: Identify the Abstraction Level

Ask: **What layer does this knowledge belong to?**

| Layer | Examples |
|-------|----------|
| Architecture | System boundaries, data flow, major components |
| Mechanism | How feature X actually works under the hood |
| Implementation | Specific functions, config keys, file paths |
| Runtime | Logs, metrics, debug commands |

**Rule**: Document at the highest stable layer. Don't hardcode file paths if the mechanism is what matters.

### Step 3: Compress to Essence

Before writing, compress:

```
Verbose: "When we looked at the logs we saw that the service was 
          throwing errors because it couldn't connect to the database 
          which was caused by the connection pool being exhausted..."

Compressed: "Connection pool exhaustion → 'connection refused' errors. 
             Check: netstat -an | grep :5432 | wc -l"
```

**Heuristic**: If it takes >30 seconds to read, it's not compressed enough.

### Step 4: Verify Anchors

Every fact needs an anchor:
- **Code anchor**: File path + function name
- **Log anchor**: Log location + grep pattern
- **Command anchor**: Exact command to reproduce/verify
- **Doc anchor**: Link to official doc (if exists)

**Without anchors, knowledge is unreliable.**

---

## Document Types & Templates

### Type A: Service/System Log

For long-term system knowledge.

**Template**:
```markdown
# System: [Name]

## 30-Second Summary
[What this does, 2-3 sentences. Focus on purpose, not implementation.]

## Architecture Layers
| Layer | Concept | Code Location | Why It Matters |
|-------|---------|---------------|----------------|
| L1 | [API/Interface] | [file/path] | [Entry point for X] |
| L2 | [Core Logic] | [file/path] | [Where Y happens] |
| L3 | [Storage/External] | [file/path] | [Data flow Z] |

## Critical Paths

### Happy Path: [Operation]
1. `[file:function]` - [What happens]
2. `[file:function]` - [What happens]
3. `[file:function]` - [Result]

### Error Path: [Scenario]
1. [Where error originates]
2. [How it propagates]
3. [Final observable symptom]

## Known Traps

| Symptom | Root Cause (Mechanism) | Quick Verify | Fix Pattern |
|---------|------------------------|--------------|-------------|
| [Observable] | [Why it happens] | [Command/log check] | [Approach] |

## Configuration

| Key | Location | Default | Change Behavior |
|-----|----------|---------|-----------------|
| [config] | [file/env] | [value] | [Effect] |

## Debug Shortcuts

```bash
# Check health/status
[command with expected output]

# View relevant logs
tail -f [log] | grep [pattern]

# Verify state
[diagnostic command]
```

## Uncertain / TODO
- [ ] [What we don't fully understand, with evidence]
```

---

### Type B: Debug Session Transfer

**使用场景**: Context 即将过长/compact 时，快速保存调试线索，让新 session 能无缝续上。

**原则**: 不需要复杂提炼，记录下就够了。新 session 会自己读这份文档。

**Template**:
```markdown
# Debug Context: [Issue/Component]

## Problem Statement
[一句话描述当前症状]

## Verified Facts ✅
| Fact | Evidence | Anchor |
|------|----------|--------|
| [已确认的事实] | [Log/config/code] | [Location] |

## Excluded Paths ❌
| Path | Why Excluded | Evidence |
|------|--------------|----------|
| [已排除的假设] | [Test result] | [Observation] |

## Active Hypotheses ❓
1. **[当前怀疑方向]**
   - Confidence: [High/Medium/Low]
   - Test: [How to verify]
   - If true: [Implications]

## Environment State
- [关键文件状态]
- [Relevant configs]
- [Versions]

## Next Steps
1. [明确的下一步行动]
```

---

### Type C: Troubleshooting for Agent Framework

For generating agent-framework-design compatible troubleshooting entries. Creates files in `troubleshooting/` subdirectory, referenced by `navigation.md`.

**Output Location**: `<target-dir>/troubleshooting/<symptom-keywords>.md`

**Template**:
```markdown
---
type: trap                      # trap | debt | hypothesis
severity: high                  # high | medium | low
status: verified               # verified | pending | outdated
created: 2026-03-16
---

## 症状
可观察的问题表现（一句话描述）

## 原因
底层机制解释 —— 为什么发生，不是发生了什么

## 锚点
- Code: `file.ts:15` (函数名或关键行)
- Log: `grep "pattern" /var/log/app.log`
- Command: `验证命令及预期输出`
- Doc: 相关官方文档链接

## 规避
如何绕过或修复，包含具体代码/配置变更

## 排查步骤
1. [检查某处]
2. [验证某条件]
3. [确认根因]
```

**命名规范**:
- 文件名: `{症状关键词}.md`，如 `concurrent-state.md`, `offset-commit-failure.md`
- 使用 kebab-case，避免空格
- 关键词选择: 最直观的症状描述

**Integration with navigation.md**:
```yaml
name: user-service
type: module

troubleshooting:
  concurrent-state: troubleshooting/concurrent-state.md
  n-plus-one-query: troubleshooting/n-plus-one-query.md
```

**Post-Generation（必须执行）**:
1. 生成 troubleshooting 文件后，**立即检查/创建当前目录的 `navigation.md`**
2. 在 `navigation.md` 中添加 `troubleshooting:` 字段，指向新生成的文件
3. 如果不存在 navigation.md，创建一个基本的：
   ```yaml
   name: <module-name>
   type: module
   
   troubleshooting:
     <symptom-key>: troubleshooting/<file>.md
   ```

---

## Document Location Strategy

| Context | Location | Rationale |
|---------|----------|-----------|
| Service/System COBRA (Type A) | `docs/system-log/<system>.md` | Version controlled with code |
| Cross-project COBRA | `~/.openclaw/workspace/system-logs/<system>.md` | Global access |
| Debug session transfer (Type B) | `memory/debug-context-<issue>.md` | Immediate session reference |
| Troubleshooting (Type C) | `<module-dir>/troubleshooting/<symptom>.md` | Agent-framework compatible |

### Type B 生命周期管理

**创建**: Context 即将 compact 时快速保存
**消费**: 新 session 启动时读取，继续调试
**清理**: 问题解决后，将关键发现迁移到 Type C（troubleshooting），然后删除 Type B 文件

```bash
# 问题解决后
cp memory/debug-context-kafka.md src/services/kafka/troubleshooting/rebalancing-loop.md
# → 按 Type C 格式整理，更新 navigation.md
rm memory/debug-context-kafka.md
```

### Troubleshooting 目录结构

```
src/services/user/
├── agents.md              # 可选：局部规则
├── navigation.md          # 显式引用 troubleshooting
├── UserService.ts         # 业务代码
└── troubleshooting/       # system-notes Type C 输出
    ├── concurrent-state.md
    └── n-plus-one-query.md
```

**workflow**: 
1. 当在模块目录工作时，生成 troubleshooting 到 `./troubleshooting/`
2. 同步更新 `navigation.md` 的 `troubleshooting:` 字段
3. 其他 Agent 通过 navigation.md 发现并引用

---

## Quality Standards

### DO Include
- **Mechanism explanations**: Why it behaves this way (not just what)
- **Exact anchors**: File:line or log pattern or command
- **Verified behaviors**: With evidence of verification
- **Symptom → root cause → verify**: Complete diagnostic chain
- **Uncertainty markers**: Explicit TODOs for unverified items

### DON'T Include
- ❌ Failed debugging attempts (the journey, not the destination)
- ❌ Hypotheses without verification or pending status
- ❌ Emotional trajectory ("we were frustrated when...")
- ❌ Narrative of discovery process
- ❌ Copy-pasted code blocks >20 lines (link instead)
- ❌ Speculation presented as fact

---

## Usage in New Sessions

When starting fresh session:

1. **Read the doc first**: Load system-log before deep debugging
2. **Verify anchors**: Check if referenced code locations still exist
3. **Check uncertainty markers**: See if TODOs have been resolved
4. **Update as needed**: Add new traps discovered, mark outdated sections

**Template for bootstrapping**:
```
I'm debugging [system]. Please read [path/to/system-log.md] 
to understand the architecture before proceeding.

Current issue: [symptom]
```

---

## Anti-Patterns

| Pattern | Problem | Fix |
|---------|---------|-----|
| **Narrative style** | Hard to scan, mixes fact with story | Use structured tables/lists |
| **Over-documentation** | Docs rot, maintenance burden | Only document what passes 3-Test Rule |
| **Speculation creep** | Unverified info misleads | Explicit uncertainty markers |
| **Anchor drift** | Referenced code moves, doc becomes wrong | Include search patterns, not just line numbers |
| **Abstraction confusion** | Mixing mechanism with implementation | Use Architecture → Mechanism → Implementation hierarchy |

---

## Complete Templates

See [references/templates.md](references/templates.md) for:
- Service/System template (full version)
- Debug Session Transfer template (full version)
- Library/Module template
- API/Interface template
- Infrastructure/Config template

## Examples

See [references/examples.md](references/examples.md) for real-world examples showing effective system logs.

---

## Related Skills

- **skill-creator**: System logs can become references for domain-specific skills
