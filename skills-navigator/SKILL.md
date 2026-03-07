---
name: skills-navigator
description: SN - Skills Navigator. Query and navigate available skills in this project. Use when user needs help finding the right skill for their task, unsure which skill to use, or wants to explore available capabilities. Reads AGENTS.md to get up-to-date skill information.
---

# Skills Navigator

帮助用户找到当前项目下最合适的 skill。

## 何时使用

- 用户不确定应该使用哪个 skill
- 需要浏览所有可用的 skills
- 根据任务类型推荐 skill
- 查询特定 skill 的详细信息

## 工作原理

1. **读取** `AGENTS.md` 获取项目下的所有 skill 信息
2. **解析** 用户的任务描述
3. **匹配** 最合适的 skill(s)
4. **推荐** 并提供使用入口

## 使用方式

### 方式一：直接询问

```
用户：我该用哪个 skill 来调试这个问题？
```

→ 读取 AGENTS.md，根据关键词匹配推荐 ECTM

### 方式二：浏览所有 skills

```
用户：列出所有可用的 skills
```

→ 读取 AGENTS.md，展示所有技能的快速识别表

### 方式三：场景匹配

```
用户：我要开始一个新项目，需要做什么？
```

→ 分析场景，推荐 skill 组合（如 Code-Reader → DDDW）

## 匹配逻辑

| 用户输入包含... | 推荐 Skill | 理由 |
|----------------|-----------|------|
| 调试、bug、报错、失败 | ECTM | AGENTS.md: "用户说...'帮我调试...' → ECTM" |
| 性能、cpu、慢、瓶颈 | SHECR-perf-hunter | AGENTS.md: "性能问题... → SHECR" |
| 想法、需求、不确定 | CREW | AGENTS.md: "'我有个想法...' → CREW" |
| 开发、功能、实现 | DDDW | AGENTS.md: "'开始开发...' → DDDW" |
| 文档、整理、重构 | DMGR | AGENTS.md: "整理文档... → DMGR" |
| markdown、格式、检查 | audit-markdown-syntax | AGENTS.md: "检查 Markdown... → AMS" |
| 读代码、理解项目 | Code-Reader | AGENTS.md: "阅读代码... → Code-Reader" |
| 提交、git、协作 | FIRE | AGENTS.md: "提交代码... → FIRE" |
| 总结、学到、类似问题 | METIS | AGENTS.md: "'又发生了...' → METIS" |

## 输出格式

### 单 Skill 推荐

```markdown
根据您的描述，推荐使用 **[skill-name](path/to/SKILL.md)**

**匹配原因**: [关键词匹配解释]

**快速入口**:
- 阅读完整指南: [SKILL.md](path/to/SKILL.md)
- 核心原则: [一句话总结]
- 典型输出: [输出文件]

**下一步**: [建议的操作]
```

### 多 Skill 组合推荐

```markdown
您的场景需要以下 skills 组合:

1. **[skill-1](path/to/SKILL.md)** - [用途]
2. **[skill-2](path/to/SKILL.md)** - [用途]

**执行顺序**: [顺序说明]
```

## 示例对话

### 示例 1: 调试问题

```
用户：我的程序崩溃了，怎么排查？

我：我来帮您找到合适的 skill。

根据您的描述，推荐使用 **ECTM**

**匹配原因**: 关键词 "崩溃"、"排查" 匹配调试场景

**快速入口**:
- 阅读完整指南: [ECTM/SKILL.md](../ECTM/SKILL.md)
- 核心原则: 结构化调试，证据链追踪，忽略显而易见的答案
- 典型输出: `debug/[问题描述].md`

**下一步**: 我建议在 ECTM 的指导下创建调试文档，系统性地收集证据。
```

### 示例 2: 不确定从哪开始

```
用户：我想做一个新功能，但不太确定需求

我：根据您的描述，推荐以下 skills 组合:

1. **CREW** - 澄清模糊需求，探索可行方案
   - 输出: `docs/exploration/<feature>-exploration.md`

2. **DDDW** - 文档驱动开发实现
   - 在 CREW 完成后使用

**执行顺序**: 先 CREW 探索需求，确认后再进入 DDDW 开发。
```

### 示例 3: 浏览所有 skills

```
用户：你都有什么技能？

我：以下是本项目中可用的 skills（来自 AGENTS.md）:

| Skill | 触发场景 | 用途 |
|-------|---------|------|
| ECTM | 调试复杂问题 | 结构化调试方法论 |
| CREW | 需求模糊 | 协作式需求探索 |
| DDDW | 开始开发 | 文档驱动开发流程 |
| SHECR | 性能问题 | 性能诊断分析 |
| ... | ... | ... |

您想了解哪个 skill 的详细信息？
```

## 注意事项

1. **总是读取 AGENTS.md**: 不要依赖内部知识，每次查询前读取 `../AGENTS.md` 获取最新信息
2. **保持简洁**: 直接给出推荐，不要罗列所有不相关的 skills
3. **提供入口**: 始终提供 SKILL.md 的链接，方便用户深入了解
4. **组合推荐**: 复杂场景可能需要多个 skills 组合使用
