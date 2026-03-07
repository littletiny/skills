# Skills 使用指南 (For Agents)

本目录包含多个可复用的 AI 技能模块。作为 Agent，你应该根据用户请求自动识别并激活相应的技能。

## 快速识别表

| 用户说... | 激活技能 | 优先级 |
|-----------|----------|--------|
| "帮我调试..."、"为什么报错..."、反复失败 | [ECTM](./ECTM/SKILL.md) | 🔴 高 |
| "我有个想法..."、"不确定怎么做..." | [CREW](./CREW/SKILL.md) | 🔴 高 |
| "开始开发..."、"规划功能..."、"多 Agent..." | [DDDW](./DDDW/SKILL.md) | 🔴 高 |
| "性能问题..."、"CPU 高..."、"慢..." | [SHECR](./SHECR/SKILL.md) | 🔴 高 |
| "整理文档..."、"重构文档..." | [DMGR](./DMGR/SKILL.md) | 🟡 中 |
| "检查 Markdown..."、"格式问题..." | [AMS](./AMS/SKILL.md) | 🟡 中 |
| "阅读代码..."、"理解项目..." | [Code-Reader](./Code-Reader/SKILL.md) | 🟡 中 |
| "又发生了..."、"类似问题..."、"学到什么..." | [METIS](./METIS/SKILL.md) | 🟢 低(事后) |
| "提交代码..."、多人协作仓库 | [FIRE](./FIRE/SKILL.md) | 🟡 中(行动前) |
| "我该用哪个 skill"、"你有什么技能"、不确定 | [skills-nav](./skills-nav/SKILL.md) | 🟢 低(导航) |

## 技能详情

### 1. ECTM - 调试与问题定位

**全称**: Evidence-Chain Tracking & Mechanism-Driven Debugging

**何时使用**:
- 调试复杂问题，尤其是"显而易见"却找不到的问题
- 需要系统性的根因分析
- 问题反复出现，需要结构化追踪

**核心原则**:
- 观察者检查：先调试调试器本身
- 证据链追踪：所有结论必须有证据引用
- 反直觉假设：必须包含与"显而易见"相反的假设

**输出**: `debug/[问题描述].md` - 双表结构（问题演进表 + 路径追踪评估表）

**AI 特别提醒**: 作为 AI，你容易被训练数据的"显而易见"模式所困。ECTM 要求你：**忽略显而易见的答案，寻找被遮蔽的证据链。**

---

### 2. CREW - 需求探索

**全称**: Collaborative Requirements Exploration Workshop

**何时使用**:
- 用户有模糊想法，需要结构化讨论澄清
- 需求不明确，需要探索多个方案
- 还未准备好进入 DDDW 开发阶段

**工作流程**: 6 轮结构化对话
1. Context Gathering - 背景收集
2. Problem Definition - 问题定义
3. Solution Brainstorming - 方案头脑风暴
4. Deep Dive - 深入探讨
5. Trade-off Analysis - 权衡分析
6. Consolidation - 总结确认

**输出**: `docs/exploration/<feature>-exploration.md`

**过渡到 DDDW**: 当探索完成并获得用户确认后，生成 `docs/requirements/<feature>-requirements.md` 并切换到 DDDW。

---

### 3. DDDW - 文档驱动开发

**全称**: Document-Driven Development Workflow (4D-Workflow)

**何时使用**:
- 开始新功能或模块开发
- 多 Agent/多人协作开发
- 需要建立接口契约

**7 步流程**:
1. **Requirements** - 用户编写需求文档
2. **Design** - Agent 创建设计 + 原理文档
3. **Split** - 分解为并行任务 + 接口契约
4. **Parallel Dev** - SubAgents 并行开发
5. **Regression Test** - 集成 + E2E 验证
6. **Document Sync** - 确保文档与代码一致
7. **Commit Split** - 清晰的 Git 历史

**关键输出**:
- `docs/requirements/<feature>-requirements.md`
- `docs/design/<feature>-design.md`
- `docs/design/<feature>-rationale.md`
- `docs/design/<feature>-interfaces.md`

---

### 4. SHECR - 性能诊断

**全称**: Systematic Hypothesis Evidence Controlled Reasoning

**何时使用**:
- 性能问题分析
- CPU 瓶颈定位
- 热点函数追踪

**五原则**:
- **S**ystematic: 系统级→时间级→实体级→函数级→模式级
- **H**ypothesis: 假设驱动，根据符号语义构建搜索空间
- **E**vidence: 证据优先，数据说话
- **C**ontrolled: 受控收敛，X0 级问题追踪到根因
- **R**easoning: 因果追踪，第一推动力分析

**诊断标记**:
- `<X0>`: Critical（阻塞级）- 必须追踪到根因
- `<X1>`: Major（重要级）- 当前阶段处理
- `<X2>`: Minor（提示级）- 辅助推理线索
- `<XA>`: Action（操作建议）- 基于证据的具体行动

---

### 5. DMGR - 文档管理

**全称**: Documentation Manager

**何时使用**:
- 重构后更新文档结构
- 创建新文档
- 迁移旧文档到新结构

**文档结构**:
```
docs/
├── task/           # 任务生命周期
├── module/         # 功能模块 (what/how/why)
├── system/         # 系统级文档
├── discussion/     # 讨论记录
└── meta/           # 元数据和导航
```

**关键规则**:
- Task 文件: `<type>-<id>-<brief-title>.md`
- ADR 文件: `adr-XXX-short-title.md`
- Discussion: `YYYY-MM-DD-topic-name.md`

---

### 6. AMS - Markdown 检查

**全称**: Audit Markdown Syntax

**何时使用**:
- 编辑 Markdown 文件后
- 提交前验证
- 格式问题排查

**常见错误检查**:
- 嵌套代码块（相同分隔符）
- 未闭合的链接
- 未闭合的代码块
- 表格列数不匹配
- 标题层级跳跃

**修复选项**:
- 使用 4 空格缩进显示代码块示例
- 使用不同数量的反引号（` ``` ` vs ` ```` `）

---

### 7. Code-Reader - 代码阅读

**定位**: 逆向工程专家，将源码抽象为架构文档

**何时使用**:
- 阅读新项目代码
- 生成架构文档
- 理解系统核心设计

**六步操作流**:
1. **Architecture Overview** - 全局扫描 → `doc/01-architecture-overview.md`
2. **Domain Modeling** - 实体建模 → `doc/02-domain-model.md`
3. **Entrypoint Navigation** - 入口导航 → `doc/03-entrypoints.md`
4. **Trace Interaction** - 交互追踪 → `doc/04-interaction-flow.md`
5. **Rules Extraction** - 规则提取 → `doc/05-business-rules.md`
6. **Synthesis & Snippet Scan** - 精要提炼 → `doc/06-design-insights.md`

**核心抽象维度**:
- Nouns (名词/实体) - 领域模型
- Keys (钥匙/入口) - 系统边界
- Timeline (时序/交互) - 执行链路
- Contracts (契约/状态) - 业务规则
- Philosophy (哲学/模式) - 设计模式
- Evidence (取证/承重墙) - 核心源码

---

### 8. METIS - 经验萃取

**全称**: Methodology Extraction & Transferable Insight System

**何时使用**:
- 调试失败多次后
- 同类问题反复出现
- 需要从解决过程中提取方法论

**核心理念**: "Don't memorize solutions. Internalize perspectives."

**METIS 循环**:
```
遇到问题 → 调试解决 → 记录案例 → 映射到方法论 → 未来应用方法论
```

**目录结构**:
```
METIS/
├── methodology/    # 抽象思维框架
├── cases/          # 具体案例记录
│   ├── code/
│   ├── cognitive/
│   └── ai-self/    # AI 自我反思（关键）
└── principles/     # 跨领域洞察
```

**特别注意**: `ai-self/` 目录记录你自己的失败和偏见，这是校准而非自恋。

---

### 9. FIRE - Git 协作规范

**何时使用**:
- 多人协作的 Git 仓库
- 提交或推送代码前

**核心原则**:
- 只提交自己改动的代码
- 无冲突时自动执行，无需询问
- 有冲突时停下来处理

---

### 10. skills-nav - Skills 导航器

**何时使用**:
- 用户不确定该用哪个 skill
- 需要浏览所有可用 skills
- 根据任务推荐合适的 skill(s)

**工作原理**:
1. 读取 `AGENTS.md` 获取最新 skill 信息
2. 解析用户任务描述
3. 匹配并推荐最合适的 skill(s)

**输出**: 推荐 skill + 快速入口链接

---

## 技能组合模式

### 模式 A: 从零开发新功能
```
CREW (澄清需求) 
    ↓ 生成 requirements.md
DDDW (开发实现)
    ↓
FIRE (提交代码)
```

### 模式 B: 排查复杂 Bug
```
ECTM - 结构化调试
    ↓ 解决后
METIS - 萃取方法论供未来使用
```

### 模式 C: 接手新项目
```
Code-Reader - 阅读代码生成架构文档
    ↓
METIS - 记录项目特定的认知模式
```

### 模式 D: 性能优化
```
SHECR - 诊断瓶颈
    ↓
DDDW - 规划优化方案
    ↓
FIRE - 提交优化代码
```

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

---

**记住**: 技能是工具，不是枷锁。根据具体情况灵活组合使用。
