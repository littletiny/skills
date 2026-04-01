---
name: state-gate-protocol
description: State-Gate Trace Protocol - A multi-phase pipeline methodology for exploring resource flow control systems. Use when analyzing state machines, debugging complex control flow issues, tracing resource lifecycle, or performing systematic root cause analysis on systems with discrete states and decision gates.
---

# State-Gate Trace Protocol

A multi-phase pipeline methodology for exploring resource flow control systems. Each phase runs as a separate Agent, reading documents from previous phases.

## Core Model

- **State**: Discrete state nodes in a system dimension. A State has clear semantic boundaries, observability, and transition conditions.
- **Gate**: Decision points for state transitions. Given current State + context, determines allow/reject/delay/divert and produces next State + side effects (Action).
- **Action**: Side effects produced by Gate decision. Causal chain: `State → [Gate decision] → Action → [may cause] → State'`.

State Driver Types (orthogonal, combinable):
- **Condition-Driven**: Boolean condition satisfaction triggers transition
- **Message-Driven**: Message/signal reception triggers transition

## Phase Execution

### Phase 1: Discovery

Purpose: Scan code to discover State and Gate instances.

Input: Source code directory

Output: `doc/state-gate/states/{name}.md`, `doc/state-gate/gates/{name}.md` with `status: discovered`

Discovery Dimensions:

| Dimension | Focus | Application in State-Gate |
|-----------|-------|---------------------------|
| **Nouns** | Identify domain entities | Find state-bearing objects (structs, classes with status/phase/state fields) |
| **Keys** | Locate system entry points | Find message handlers, API endpoints, callbacks that trigger state changes |
| **What** | Concept abstraction | Define what each discovered State represents semantically |
| **Where** | Entry mapping | Map all triggers: timers, events, signals that invoke Gates |

Discovery Checklist:
- [ ] Scan for state-bearing fields (`status`, `phase`, `state`, `mode`, `condition`)
- [ ] Scan for decision points (if/else, switch, match on state fields)
- [ ] Identify entry points: message handlers, API endpoints, callbacks
- [ ] Classify driver type: Condition-Driven vs Message-Driven
- [ ] Document: file location, state field name, decision logic location

### Phase 2: Analysis

Purpose: Deep analysis of discovered State/Gate instances.

Input: states/*.md, gates/*.md with status=discovered

Output: Updated documents with status=analyzed

Analysis Dimensions:

| Dimension | Focus | Application in State-Gate |
|-----------|-------|---------------------------|
| **Timeline** | Trace execution flow | Map state transition sequences, async vs sync paths |
| **Contracts** | Extract state constraints | Document invariants, valid state combinations, pre/post conditions |
| **State** (from CMR) | State machine details | Define all states, transitions, triggers, entry/exit actions |
| **How** | Process breakdown | Decompose Gate logic: condition evaluation → decision → action |
| **Who** | Component interactions | Map which components read/write this State, call this Gate |
| **Why** | Design rationale | Understand why this State/Gate design was chosen |
| **Evidence** | Critical code sections | Pinpoint the exact code that implements core logic |

State Analysis Checklist:
- [ ] Semantics: What does this state represent?
- [ ] Driver: Condition-Driven / Message-Driven / Hybrid?
- [ ] State Machine: All states, transitions, triggers (use mermaid stateDiagram)
- [ ] Entry/Exit: What conditions trigger transitions?
- [ ] Gates: Which Gates check this State?
- [ ] Abnormal: What happens when transition fails?
- [ ] Code Evidence: File:line for state definition, transitions, error handling

Gate Analysis Checklist:
- [ ] Trigger: When is this gate evaluated? (event, polling, callback)
- [ ] Condition breakdown: What criteria is checked?
- [ ] Source: Where do criteria values come from? (which States)
- [ ] Decision logic: allow/reject/delay/divert conditions
- [ ] Action analysis: What happens after decision? (side effects, next State)
- [ ] Sensitivity: Easy to trigger? Under what conditions?
- [ ] Code Evidence: File:line for gate evaluation, condition checks, actions

### Phase 3: Connection

Purpose: Build State-Gate topology relationships.

Input: states/*.md, gates/*.md with status=analyzed

Output: maps/{module}.md

Connection Checklist:
- State hierarchy: high-level vs low-level states
- State machine cycles: loops in transitions
- Gate cascading: gate A triggers -> affects gate B
- Critical paths: entry to exit control chains

### Phase 4: Diagnosis

Purpose: Trace root cause along State-Gate graph.

Input: maps/{module}.md + symptom description

Output: paths/{symptom}_diagnosis.md

Output Specification:
- Executable diagnostic procedures for specific symptoms
- Step-by-step decision trees traversing State-Gate graph
- Each step must reference code locations (file:line) or data points
- Status: `done` or `partial`

## Diagnosis Method

Core Principles:
- **Observer Check**: Verify observation framework is unbiased - check if any Gate or State was overlooked
- **Mechanism over Symptom**: Find causal chain of "how it leads to the symptom"
- **Evidence-Driven**: All conclusions must include code references (file:line)
- **Topology-Driven**: Trace along State-Gate relationships, not arbitrary jumps

Root Cause Levels:
- Direct: Which Gate triggered the symptom?
- Intermediate: Why did the triggering condition occur?
- Deep: Why did State become abnormal?

Diagnosis Flow:
1. **Observer Check** → Verify the State-Gate map is complete for this symptom
2. **Symptom Localization** → Identify the Gate where symptom manifests
3. **Upstream Tracing** → Follow Gate conditions backward to source States
4. **Evidence Chain** → Document each step with code references
5. **Consistency Check** → Ensure the causal chain explains all observations

## Trigger Conditions

- No prior docs exist -> Start Phase 1
- Found status=discovered docs -> Start Phase 2
- Multiple status=analyzed docs -> Start Phase 3
- Have map + symptom -> Start Phase 4

## Pipeline Rules

- One Agent per phase
- Agent reads input docs, writes output docs, exits
- Next phase triggered by presence of appropriate status docs
- New discoveries reset to Phase 1 for that component

## Methodology Integration

| Phase | Core Activity | Key Output |
|-------|---------------|------------|
| Discovery | Scan code patterns, identify State/Gate candidates | Code locations |
| Analysis | Deep dive into State semantics and Gate logic | Key code + logic |
| Connection | Map relationships between States and Gates | Call relations |
| Diagnosis | Trace symptom through State-Gate topology | Decision path with evidence |
