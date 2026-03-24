# Skills 导航手册

本文档包含所有技能的详细说明。如需快速查找，请参考 [AGENTS.md](./AGENTS.md) 的识别表和决策速查。

---

## ECTM - 调试与问题定位

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

## CREW - 需求探索

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

## DDDW - 文档驱动开发

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

## SHECR - 性能诊断

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

## DMGR - 文档管理

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

## AMS - Markdown 检查

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

## code-reader - 代码阅读

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

## CMR - 机制逆向分析

**全称**: Code Mechanism Reader

**定位**: 代码机制逆向分析专家，将特定功能模块的底层实现抽象为机制分析文档

**何时使用**:
- 深入理解某个核心机制（如消息发送、连接池、断路器）
- 排查状态流转异常、异步时序问题
- 需要向他人解释某机制的工作原理
- 遗留系统关键模块缺乏文档

**与 code-reader 的区别**:
| | code-reader | CMR |
|---|---|---|
| **视角** | 全景 - 整个系统 | 深度 - 单个机制 |
| **粒度** | 架构级 | 实现级 |
| **输出** | 6份架构文档 | 1份机制文档 |
| **场景** | 接手新项目 | 深入理解特定功能 |

**核心分析维度 (5W1H)**:
- **What** - 概念抽象、术语定义
- **Where** - 入口定位（API、回调、事件）
- **How** - 流程拆解（同步/异步路径）
- **State** - 状态机（状态定义、转换规则）
- **Who** - 组件交互（职责、协作协议）
- **Why** - 设计权衡（决策原因、性能考量）

**输出**: `doc/mechanism-{mechanism-name}.md`

**按需分析原则**:
- 简单机制：概述 + 概念模型 + 实现精要
- 流程型机制：概述 + 入口 + 数据流 + 实现精要
- 状态型机制：概述 + 概念模型 + 状态机 + 组件架构

---

## METIS - 经验萃取

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

## COBRA - 跨会话知识桥接

**全称**: **CO**ntext **O**rchestrated **B**ridge **R**esource **A**rchive

**何时使用**:
- 调试复杂系统多次，需要保存上下文
- 系统有非显而易见的机制
- 上下文重建成本高
- 需要引导新 Session

**核心概念**:
- **C**ontext — 保存调试上下文，非系统化文档
- **O**rchestrated — 经过提炼、有组织的知识（非原始笔记）
- **B**ridge — 桥接不同 Session 的连续性
- **R**esource — 可复用的知识资源
- **A**rchive — 持久化存档，随时间累积

**文档类型**:
| 类型 | 场景 | 输出位置 |
|------|------|----------|
| Type A | 长期系统知识 | `docs/system-log/<system>.md` |
| Type B | Session 转移 | `memory/debug-context-<issue>.md` |
| Type C | 故障排查条目 | `<module>/troubleshooting/<symptom>.md` |

**核心原则**: 保存事实（带锚点），而非调试过程的叙事。

---

## FIRE - Git 协作规范

**何时使用**:
- 多人协作的 Git 仓库
- 提交或推送代码前

**核心原则**:
- 只提交自己改动的代码
- 无冲突时自动执行，无需询问
- 有冲突时停下来处理

---

## skills-nav - Skills 导航器

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
code-reader - 阅读代码生成架构文档（全景）
    ↓
CMR - 深入分析核心机制（深度）
    ↓
METIS - 记录项目特定的认知模式
```

### 模式 D: 深入分析核心机制
```
CMR - 分析状态机、数据流、组件交互
    ↓
ECTM（如有 Bug）- 问题定位
    ↓
METIS - 萃取机制理解方法论
```

### 模式 E: 性能优化
```
systematic-hypothesis-evidence-controlled-reasoning - 诊断瓶颈
    ↓
DDDW - 规划优化方案
    ↓
FIRE - 提交优化代码
```

---

## 版本管理

**所有技能文档不显式标注版本号**（如 v1.0, v2.0）。

原因：
- Git 已经记录了完整的历史变更
- 文件内标注版本会导致冗余和混乱
- 查看历史：`git log --oneline <file>`
- 查看差异：`git diff <commit> <file>`

**修改原则**：
- 直接修改现有文档，保留核心结构
- 重大变更在 Git commit message 中说明
- 删除废弃内容而非标记为 deprecated

---

## 技能命名规范

### 缩写风格偏好

**首字母缩写（如 COBRA）**：每个字母对应一个**完整含义的词**，形成有意义的单词。

| 技能 | 缩写 | 字母含义 |
|------|------|----------|
| **COBRA** | Context Orchestrated Bridge Resource Archive | C=Context, O=Orchestrated, B=Bridge, R=Resource, A=Archive |

**命名原则**:
1. **优先形成有意义的单词**（如 COBRA、METIS、CREW）
2. **每个字母必须有独立含义**，不是随意凑的
3. **含义要准确反映技能核心价值**，不只是功能描述
4. **保持与技能输出类型一致**（Bridge/Archive/Resource 暗示文档类型）

**反例**（避免）:
- ❌ 随机字母：`KIMI` = Knowledge Information Management Interface（牵强）
- ❌ 重复功能词：`CODE` = COntext DEbugging（两个词拼不出新含义）
- ❌ 过于抽象：`TOOL` = Tracking Of Operational Logs（太平淡）

---

**记住**: 技能是工具，不是枷锁。根据具体情况灵活组合使用。
