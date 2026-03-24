# Skills 使用指南 (For Agents)

本目录包含多个可复用的 AI 技能模块。作为 Agent，你应该根据用户请求自动识别并激活相应的技能。

**详细说明请查看 [NAV.md](./NAV.md)**

---

## 快速识别表

| 用户说... | 激活技能 | 优先级 |
|-----------|----------|--------|
| "帮我调试..."、"为什么报错..."、反复失败 | [ECTM](./evidence-chain-tracking/SKILL.md) | 🔴 高 |
| "我有个想法..."、"不确定怎么做..." | [CREW](./collaborative-requirements-exploration/SKILL.md) | 🔴 高 |
| "开始开发..."、"规划功能..."、"多 Agent..." | [DDDW](./document-driven-development/SKILL.md) | 🔴 高 |
| "性能问题..."、"CPU 高..."、"慢..." | [SHECR](./systematic-hypothesis-evidence-controlled-reasoning/SKILL.md) | 🔴 高 |
| "整理文档..."、"重构文档..." | [DMGR](./documentation-manager/SKILL.md) | 🟡 中 |
| "检查 Markdown..."、"格式问题..." | [AMS](./audit-markdown-syntax/SKILL.md) | 🟡 中 |
| "阅读代码..."、"理解项目..." | [code-reader](./code-reader/SKILL.md) | 🟡 中 |
| "分析xx机制..."、"理解状态机..."、"消息发送流程..." | [CMR](./code-mechanism-reader/SKILL.md) | 🟡 中 |
| "又发生了..."、"类似问题..."、"学到什么..." | [METIS](./methodology-extraction-transferable-insight/SKILL.md) | 🟢 低(事后) |
| "提交代码..."、多人协作仓库 | [FIRE](./fast-isolated-repository-execution/SKILL.md) | 🟡 中(行动前) |
| "保存调试上下文..."、"跨 Session 知识..." | [COBRA](./context-bridge/SKILL.md) | 🟡 中 |
| "我该用哪个 skill"、"你有什么技能"、不确定 | [skills-nav](./skills-navigator/SKILL.md) | 🟢 低(导航) |

---

## 决策速查

| 情况 | 行动 |
|------|------|
| 需求模糊 | 使用 CREW，不要直接进 DDDW |
| 调试 >3 次失败 | 激活 ECTM |
| 性能问题 | 直接使用 SHECR |
| 多人协作 | 代码行动前检查 FIRE |
| 文档整理 | DMGR + AMS 组合 |
| 编辑 Markdown | 完成后用 AMS 检查 |
| 调试成功但有收获 | 用 METIS 记录案例 |
| 需要深入理解某机制 | 使用 CMR（而非 code-reader） |
| 跨 Session 保留调试上下文 | 使用 COBRA |

---

**技能详情、组合模式、命名规范等请参考 [NAV.md](./NAV.md)**
