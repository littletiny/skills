---
name: ectm-debugger
description: Evidence-Chain Tracking & Mechanism-Driven Debugging (ECTM) methodology for systematic root cause analysis. Use when debugging complex issues, conducting post-mortems, or maintaining structured debug documentation in debug/*.md files. Provides a "dual-table driven" approach (Problem Evolution Table + Path Assessment Table) with mechanism-first code auditing and global consistency checks to ensure logically traceable, falsifiable, and reproducible debugging conclusions.
---

# ECTM 溯源工程 (Evidence-Chain Tracking & Mechanism-Driven Debugging)

结构化调试方法论，通过维护动态调试文档实现逻辑收敛，确保根因定位的准确性和可复现性。

## 核心原则

- **逻辑可溯源**：所有结论必须附带证据引用
- **结论可证伪**：每个假设必须有验证方法和预期指纹
- **过程可复刻**：完整记录在 `debug/*.md` 文档中

## 标准工作流

### Step 1: 问题定义演进 (Problem Evolution)

在文档顶部记录原始现象（$V_1$），随着证据补充持续更新问题描述。**必须引用关键证据**（日志行号、监控采样点、堆栈链接）。

### Step 2: 假设空间构建 (Hypothesis Expansion)

根据已知的领域知识枚举所有可能路径，扩展到整个问题相关领域思考
枚举所有可能路径，初始化《路径追踪评估表》。每个假设路径应基于当前问题版本。**最少需要找到3个路径，避免搜索范围太小**

### Step 3: 机制评估与剪枝 (Mechanism Audit)

深入代码细节前，先分析模块的**设计意图、运行机制及副作用**。将机制评估结论记录在评估表中。若机制与证据矛盾，直接剪枝。

### Step 4: 循证深挖 (Evidence-Driven Deep Dive)

针对高置信度路径进行代码阅读。推导"逻辑指纹"，从历史监控中提取证据匹配。**所有代码分析结论必须附带代码段引用或文件行号。**

### Step 5: 全局审计 (Global Consistency Audit)

最终定论前，回溯所有历史信息，评估现有结论是否能解释所有疑点。若存在无法解释的孤证，强制重置流程，更新问题定义。

## 文档规范

在 `debug/[问题描述].md` 维护调试过程。使用下方的「调试文档模板」作为起始模板。**信息更新的过程中需要保留历史信息，尤其是各种被推翻/推理的结论以及作证信息，这很关键。**

### 双表结构

1. **问题演进表 (Table A)**：记录问题定义的版本迭代
2. **路径追踪与机制评估表 (Table B)**：记录假设、机制评估、预期指纹和验证状态

### 代码引用规范

- 格式：`文件名:行号` 或 `文件名:行号-行号`
- 示例：`OrderService.java:142` 或 `OrderService.java:142-156`

## 使用示例

```
用户：帮我调试一个接口超时问题

我：按 ECTM 方法，我将为您在 debug/ 目录下创建结构化分析文档。

[创建 debug/api-timeout.md，填写 Table A V1、初始化 Table B 假设空间]

用户：我找到一条关键日志

我：很好。让我更新问题演进表，并评估现有假设...
[更新 Table A 到 V2，引用关键日志；在 Table B 中更新机制评估和验证状态]
```

---

## 附录：调试文档模板

创建新的调试文档时，复制以下内容作为起始模板：

````markdown
# Debug Trace: [简短的问题描述]

- **状态**: [进行中 / 已关闭 / 待审计]

---

## 一、问题演进表

| 版本 | 描述 | 关键证据引用 (Logs/Metrics) |
| :--- | :--- | :--- |
| V1 | [原始现象描述] | [证据链接/日志行号] |
| V2 | [更新后的描述] | [新证据链接/日志行号] |

---

## 二、路径追踪与机制评估表

| 疑点 | 假设 | 机制与副作用评估 | 预期指纹 | 状态 |
| :--- | :--- | :--- | :--- | :--- |
| xxx失效 | [假设1] | **机制**: [机制描述]<br>**副作用**: [副作用描述] | [预期观察到的现象] | [待验证/已证伪/确认] |
| xxx内存不足 | [假设2] | **机制**: [机制描述]<br>**副作用**: [副作用描述] | [预期观察到的现象] | [待验证/已证伪/确认] |

---

## 三、深度审计记录

### 记录 1

- **代码段引用**: `文件名:行号`
- **调用链**: generic_file_read_iter -> filemap_read -> filemap_get_pages -> filemap_update_page
- **机制发现**: [发现的代码机制]
- **推论**: [基于机制的推论]

---

## 四、全局审计 (Global Audit)

- [ ] 是否解释了所有报错现象？
- [ ] 证据链是否闭环？
- [ ] 是否存在无法解释的孤证？

**结论**: [最终结论]

---

## 附录

### 关键日志片段

```
[在此处粘贴关键日志]
```
````
