# System Log Doc Templates

Complete templates for different system types.

## Table of Contents

1. [Service/System Template](#servicesystem-template)
2. [Library/Module Template](#librarymodule-template)
3. [Debug Session Transfer Template](#debug-session-transfer-template)
4. [API/Interface Template](#apiinterface-template)
5. [Infrastructure/Config Template](#infrastructureconfig-template)

---

## Service/System Template

For microservices, daemons, or complex subsystems.

```markdown
# System: [Service Name]

## 30-Second Summary
[2-3 sentences describing: purpose, key responsibility, primary interfaces]

## Architecture Layers

| Layer | Concept | Key Files | Notes |
|-------|---------|-----------|-------|
| API | [REST/gRPC/... interface] | [entry point file] | [auth, rate limits] |
| Business Logic | [Core workflows] | [main service files] | [key invariants] |
| Data | [Storage layer] | [repository/DAO files] | [caching strategy] |
| External | [3rd party deps] | [client files] | [failure modes] |

## Critical Paths

### Happy Path: [Operation Name]
1. [Entry point: file:function]
2. [Processing step]
3. [Exit/Result]

### Error Path: [Error Scenario]
1. [Where error originates]
2. [How it propagates]
3. [Final handling]

## Known Traps

| Symptom | Likely Root Cause | Quick Verify | Fix Pattern |
|---------|-------------------|--------------|-------------|
| [Error message/symptom] | [Mechanism explanation] | [command/check] | [approach] |
| [Performance issue] | [Bottleneck location] | [metric/command] | [approach] |

## Configuration

| Config Key | Location | Default | Behavior Change |
|------------|----------|---------|-----------------|
| [key] | [file/env] | [value] | [what happens if changed] |

## Debug Shortcuts

```bash
# Check health/status
curl [endpoint] | jq .

# View recent errors
tail -f [log location] | grep [pattern]

# Check config
cat [config file] | grep [key]
```

## Extension Points

| Extension | How to Add | Examples |
|-----------|------------|----------|
| [Plugin/middleware] | [registration pattern] | [existing examples] |

## Uncertain / TODO

- [ ] [Behavior observed but not fully understood]
- [ ] [Edge case not yet tested]
- [ ] [Question about design decision]

## Related

- [Link to related system logs]
- [Link to architecture docs]
```

---

## Library/Module Template

For internal libraries, utility modules, or shared components.

```markdown
# Module: [Module Name]

## Purpose
[What this module does, when to use it]

## Public Interface

| Function/Class | Purpose | Key Params | Returns | Notes |
|----------------|---------|------------|---------|-------|
| `[name]` | [what it does] | [critical params] | [return value] | [gotchas] |

## Internal Architecture

```
[Simple ASCII diagram or file structure]
```

## Usage Patterns

### Pattern 1: [Common Use Case]
```python
# Minimal working example
```

### Pattern 2: [Advanced/Edge Case]
```python
# Example with error handling
```

## Hidden Complexity

| Surface Simplicity | Underlying Complexity | Why It Matters |
|-------------------|----------------------|----------------|
| [Simple API call] | [What's actually happening] | [When it breaks] |

## Testing Notes

- [How to mock]
- [Test fixtures location]
- [Common test failures]

## Changelog (Key Behavioral Changes)

| Version | Change | Impact |
|---------|--------|--------|
| [vX.Y.Z] | [What changed] | [How usage changes] |
```

---

## Debug Session Transfer Template

For passing incomplete debug context to a new session.

```markdown
# Debug Context: [Issue Identifier]

## Problem Statement
[One sentence symptom]

## Verified Facts ✅

| Fact | Evidence | Date |
|------|----------|------|
| [What we know] | [Log/config/code ref] | [YYYY-MM-DD] |

## Excluded Paths ❌

| Path | Reason Excluded | Evidence |
|------|-----------------|----------|
| [Hypothesis tested] | [Why it's not the cause] | [Test/observation] |

## Active Hypotheses ❓

1. **[Hypothesis 1]**
   - Confidence: [High/Medium/Low]
   - Test: [How to verify]
   - If true: [Implications]

2. **[Hypothesis 2]**
   - Confidence: [High/Medium/Low]
   - Test: [How to verify]
   - If true: [Implications]

## Environment Snapshot

```bash
# Key versions
[tool] --version: [output]
[dependency]: [version]

# Relevant file states
[file]: [checksum/last modified]
```

## Context Locations

| Type | Location | Relevance |
|------|----------|-----------|
| Logs | [path] | [what to look for] |
| Config | [path] | [key sections] |
| Code | [path:function] | [where issue likely is] |

## Next Steps (Recommended)

1. [Specific action with expected outcome]
2. [Alternative if first fails]

## Questions for New Session

- [What we need to figure out]
- [Information gaps]
```

---

## API/Interface Template

For external APIs, protocols, or interface boundaries.

```markdown
# Interface: [API/Protocol Name]

## Overview
[What this interface provides, version, deprecation status]

## Endpoint/Method Map

| Endpoint/Method | Purpose | Auth Required | Rate Limit | Notes |
|-----------------|---------|---------------|------------|-------|
| `[GET /path]` | [what it does] | [Yes/No] | [limit] | [quirks] |

## Request/Response Patterns

### [Operation Name]

**Request:**
```http
[Method] [Path]
Headers: [key headers]
Body: [structure]
```

**Response:**
```http
Status: [code]
Body: [structure]
```

**Error Cases:**
| Status | Meaning | Retry? | Notes |
|--------|---------|--------|-------|
| [4xx/5xx] | [meaning] | [Yes/No] | [handling] |

## Client Behavior

| Client | Version | Known Issues | Workarounds |
|--------|---------|--------------|-------------|
| [client lib] | [version] | [issues] | [workarounds] |

## Authentication

[How auth works, token refresh, common failures]

## Rate Limiting & Quotas

| Resource | Limit | Reset | Behavior When Exceeded |
|----------|-------|-------|------------------------|
| [endpoint] | [limit] | [window] | [what happens] |
```

---

## Infrastructure/Config Template

For deployment, CI/CD, or infrastructure systems.

```markdown
# Infrastructure: [System Name]

## Components

| Component | Type | Location | Purpose |
|-----------|------|----------|---------|
| [name] | [EC2/K8s/Lambda...] | [region/zone] | [role] |

## Networking

```
[ASCII diagram: LB → Service → DB]
```

| Connection | Protocol | Port | Security |
|------------|----------|------|----------|
| [A → B] | [protocol] | [port] | [mechanism] |

## Deployment Flow

1. [Trigger]
2. [Build step]
3. [Deploy step]
4. [Verification]

## Common Operations

### [Operation Name]
```bash
# Command sequence
```

### Rollback
```bash
# Emergency rollback steps
```

## Monitoring & Alerts

| Metric | Source | Threshold | Meaning |
|--------|--------|-----------|---------|
| [metric] | [source] | [threshold] | [what it indicates] |

## Secrets & Credentials

| Secret | Location | Rotation | Last Verified |
|--------|----------|----------|---------------|
| [name] | [vault/file] | [frequency] | [date] |

## Known Incidents

| Date | Issue | Root Cause | Resolution | Prevention |
|------|-------|------------|------------|------------|
| [date] | [what happened] | [why] | [how fixed] | [mitigation] |
```

---

## Troubleshooting Template (Agent Framework)

For `troubleshooting/*.md` files compatible with agent-framework-design.

```markdown
---
type: trap                      # trap | debt | hypothesis
severity: high                  # high | medium | low
status: verified               # verified | pending | outdated
created: 2026-03-16
last_verified: 2026-03-16      # optional: when last confirmed
---

## 症状
[一句话描述可观察的问题表现]

## 原因
[底层机制解释 —— 为什么发生，不是发生了什么]

## 锚点
- Code: `[file]:[line]` or `[file]:[function]`
- Log: `grep "[pattern]" [logfile]`
- Command: `[command]` → `[expected output]`
- Doc: [link to relevant documentation]

## 规避
[如何绕过或修复，包含具体代码/配置变更]

## 排查步骤
1. [检查某处 —— 命令或方法]
2. [验证某条件 —— 预期结果]
3. [确认根因 —— 最终验证]

## Related
- [Link to related troubleshooting entries if any]
```

---

## Template Selection Guide

| System Type | Recommended Template | Notes |
|-------------|----------------------|-------|
| HTTP service | Service/System | Include API table in Architecture |
| Background worker | Service/System | Focus on queue/processing logic |
| Internal library | Library/Module | Emphasize public interface |
| Third-party API | API/Interface | Document quirks and workarounds |
| CI/CD pipeline | Infrastructure/Config | Include rollback procedures |
| Database | Service/System | Focus on schema, query patterns |
| Complex debug | Debug Session Transfer | Keep minimal, focus on facts |

## Quick Start: Minimal Viable Doc

If time-constrained, include only:

1. **30-Second Summary** (what is this)
2. **Architecture Layers** (where things are)
3. **One Known Trap** (save future debugging time)

Expand later as needed.
