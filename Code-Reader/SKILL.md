
---

# Code-Reader

**定位：** 逆向工程专家，负责将底层源代码抽象为高层架构文档。

---

## 核心抽象逻辑 (The Hexagonal Mindset)

该技能运行基于六个维度的认知映射，帮助从海量代码中抽离本质：

1. **Nouns (名词/实体)**：谁是业务主体？识别领域模型（Aggregate/Entity）与数据模型。
2. **Keys (钥匙/入口)**：谁触发了逻辑？识别 API、MQ 监听器、定时任务等系统边界。
3. **Timeline (时序/交互)**：逻辑如何流转？追踪核心业务的纵向执行链路。
4. **Contracts (契约/状态)**：规则是什么？挖掘状态机、校验逻辑与业务约束。
5. **Philosophy (哲学/模式)**：**[核心增量]** 为什么这么写？识别设计模式、解耦策略与扩展性布局。
6. **Evidence (取证/承重墙)**：**[核心增量]** 哪段代码最关键？锁定支撑设计亮点的 1% 核心源码实现。


## 输出规范

**核心信息需要reference**
**所有分析结果必须输出到 `doc/*.md` 文件。**

| 步骤 | 输出文件 | 内容 |
|------|----------|------|
| Step 1 | `doc/01-architecture-overview.md` | 技术栈、分层结构、物理地图 |
| Step 2 | `doc/02-domain-model.md` | 实体清单、Mermaid 类图、实体释义 |
| Step 3 | `doc/03-entrypoints.md` | 接口清单、业务意图映射 |
| Step 4 | `doc/04-interaction-flow.md` | Mermaid 序列图、执行链路描述 |
| Step 5 | `doc/05-business-rules.md` | Mermaid 状态图、规则清单、契约说明 |
| Step 6 | `06-insights.md` | **设计点亮点、架构权衡、核心代码片段剖析** | **问题-设计-收益三段论**、源码取证 |

---

## 六步操作流 (Workflow Steps)

### 第一阶段：全景扫描 (Global Mapping)

* **Step 1: 全局扫描 (Architecture Overview)**
* **意图**：识别架构模式、分层结构与技术栈。
* **输出**：`doc/01-architecture-overview.md`

* **Step 2: 实体建模 (Domain Modeling)**
* **意图**：建立业务词典，理清数据关联与聚合根。
* **输出**：`doc/02-domain-model.md`

* **Step 3: 入口导航 (Entrypoint Navigation)**
* **意图**：明确系统的对外接口与触发场景。
* **输出**：`doc/03-entrypoints.md`


### 第二阶段：逻辑追踪 (Logic Reconstruction)

* **Step 4: 交互追踪 (Trace Interaction)**
* **意图**：还原核心 API 的纵向调用链。
* **输出**：`doc/04-interaction-flow.md`

* **Step 5: 规则提取 (Rules Extraction)**
* **意图**：挖掘隐藏的状态机与业务不变量。
* **输出**：`doc/05-business-rules.md`


### 第三阶段：深度萃取 (Design Insight & Forensics)

* **Step 6: 精要提炼与代码取证 (Synthesis & Snippet Scan)**
* **意图**：定位系统的“灵魂设计”（高频路径、状态枢纽、核心对象/机制、并发处理、抽象扩展点），并深入代码行剖析实现细节。
* **输出**：`doc/06-design-insights.md`


---

## 三、 输出规范 (Output Specifications)

| 文件名 | 核心内容 | 关键元素 |
| --- | --- | --- |
| `01-overview.md` | 技术栈、物理拓扑、分层职责 | 模块关系图、层级说明 |
| `02-domain.md` | 实体清单、业务模型释义 | **Mermaid 类图**、ER 关系 |
| `03-entry.md` | 接口清单、任务触发、业务意图映射 | API 列表、MQ 映射表 |
| `04-flow.md` | 核心业务路径、调用链路描述 | **Mermaid 序列图** |
| `05-rules.md` | 状态转换逻辑、校验契约、异常处理 | **Mermaid 状态图**、决策表 |
| **`06-insights.md`** | **设计点亮点、架构权衡、核心代码片段剖析** | **问题-设计-收益三段论**、源码取证 |

---

## 四、 核心洞察输出模板 (`doc/06-design-insights.md`)

为确保输出具有架构师级别的深度，该文件必须遵循以下结构：

### 系统核心设计精要

* **[设计点名称]**
* **场景驱动**：描述普通写法在本项目复杂度下的局限性。
* **设计实现**：指出系统采用了何种高级模式（如：响应式、插件化、双重检查锁缓存等）。
* **架构收益**：量化或描述该设计带来的性能、扩展或健壮性提升。



### 关键代码取证 (Critical Snippet Scan)

* **[片段名称]**
* **源码位置**：`path/to/file:line_range`
* **代码片段**：展示支撑上述设计的最核心 10-20 行源码。
* **深度剖析**：分析这段代码的技术精要（如：位运算优化、无锁队列应用等）。



### 架构权衡 (Trade-offs)

* 分析作者为了满足当前核心需求，牺牲了哪些非核心指标（例如：为了极致性能牺牲了部分代码的可读性）。
