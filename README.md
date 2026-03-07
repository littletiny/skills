# Skills 导航

本目录包含一系列可复用的 AI 技能模块，每个技能都是自包含的目录，包含完整的指令、示例和参考资料。

## 技能列表

| 技能 | 名称 | 用途 | 触发关键词 |
|------|------|------|-----------|
| [ECTM](./ECTM/) | **ECTM** | 结构化调试方法论，证据链追踪与机制驱动的问题定位 | "调试"、"问题定位"、"根因分析"、反复失败 |
| [CREW](./CREW/) | **CREW** | 协作式需求探索工作坊，将模糊想法转化为清晰需求 | "我有个想法"、"不确定怎么做"、"探索这个概念" |
| [DDDW](./DDDW/) | **DDDW** | 文档驱动开发工作流，7步结构化开发流程 | "开始开发"、"规划功能"、"多 Agent 协作" |
| [DMGR](./DMGR/) | **DMGR** | 文档维护与管理，重构后的文档结构维护 | 更新文档、创建新文档、迁移旧文档 |
| [FIRE](./FIRE/) | **FIRE** | 多人协作 Git 提交规范 | 多人协作仓库、提交代码前 |
| [METIS](./METIS/) | **METIS** | 方法论提取与可迁移洞察系统 | "又发生了"、"类似问题"、"从中学到什么" |
| [systematic-hypothesis-evidence-controlled-reasoning](./systematic-hypothesis-evidence-controlled-reasoning/) | **SHECR** | 系统性性能诊断工具 | 性能问题、CPU 瓶颈、热点分析 |
| [audit-markdown-syntax](./audit-markdown-syntax/) | **AMS** | Markdown 语法检查与修复 | 编辑 Markdown、提交前检查 |
| [Code-Reader](./Code-Reader/) | **Code-Reader** | 代码逆向工程，从源码生成架构文档 | 阅读代码、理解项目、生成文档 |
| [skills-nav](./skills-nav/) | **Skills-Nav** | Skills 导航器，帮助找到合适的 skill | "我该用哪个 skill"、"你有什么技能"、不确定用什么 |

## 技能分类

### 🐛 调试与诊断
- **[ECTM](./ECTM/)** - 复杂问题调试，强调观察者检查与证据链追踪
- **[systematic-hypothesis-evidence-controlled-reasoning](./systematic-hypothesis-evidence-controlled-reasoning/)** - 性能问题诊断，系统性假设验证方法论

### 📝 开发与协作
- **[DDDW](./DDDW/)** - 文档驱动开发，7步从需求到代码
- **[CREW](./CREW/)** - 需求探索工作坊，澄清模糊想法
- **[FIRE](./FIRE/)** - Git 多人协作规范

### 📚 文档与知识
- **[DMGR](./DMGR/)** - 文档结构维护指南
- **[audit-markdown-syntax](./audit-markdown-syntax/)** - Markdown 语法检查
- **[Code-Reader](./Code-Reader/)** - 代码阅读与架构文档生成
- **[METIS](./METIS/)** - 经验萃取与方法论沉淀

### 🧭 导航与查询
- **[skills-nav](./skills-nav/)** - Skills 导航器，智能推荐合适的 skill

## 使用方式

每个技能目录包含：

- **`SKILL.md`** - 技能主文档，包含完整的使用指南和工作流程
- **`references/`** - 参考资料、模板和案例
- 其他辅助文件

### 快速使用

1. **识别场景**：根据当前任务类型选择对应的技能
2. **阅读 SKILL.md**：了解该技能的工作流程和输出规范
3. **执行流程**：按照 SKILL.md 中的步骤执行

### 技能组合示例

| 场景 | 推荐技能组合 |
|------|-------------|
| 从零开发新功能 | CREW → DDDW → FIRE |
| 排查复杂 Bug | ECTM → METIS(事后总结) |
| 接手新项目 | Code-Reader → METIS |
| 性能优化 | systematic-hypothesis-evidence-controlled-reasoning → DDDW → FIRE |
| 文档整理 | DMGR → AMS |

## 目录结构

```
skills/
├── ECTM/                     # ECTM 调试方法论
│   ├── SKILL.md
│   └── references/
├── CREW/                     # 需求探索工作坊
│   ├── SKILL.md
│   └── references/
├── DDDW/                     # DDDW 开发工作流
│   ├── SKILL.md
│   └── references/
├── DMGR/                     # 文档管理
│   ├── SKILL.md
│   └── references/
├── FIRE/                     # Git 协作规范
│   └── SKILL.md
├── METIS/                    # 经验萃取
│   ├── SKILL.md
│   └── references/
├── systematic-hypothesis-evidence-controlled-reasoning/  # SHECR 性能诊断
│   ├── SKILL.md
│   └── references/
├── AMS/                      # AMS Markdown 检查
│   └── SKILL.md
├── Code-Reader/              # Code-Reader 代码阅读
│   └── SKILL.md
├── skills-nav/               # Skills 导航器
│   └── SKILL.md
├── README.md                 # 本文件
└── AGENTS.md                 # Agent 使用指南
```

## 贡献指南

添加新技能时：

1. 创建独立的技能目录
2. 编写完整的 `SKILL.md` 文件
3. 更新本 README 的导航表格
4. 更新 `AGENTS.md` 的技能清单
