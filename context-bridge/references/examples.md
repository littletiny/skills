# System Log Doc Examples

Real-world examples (sanitized) showing effective system logs.

## Example 1: Internal Queue Service

```markdown
# System: Async Job Queue (JobRunner)

## 30-Second Summary
JobRunner processes background jobs from Redis queues. Workers poll queues,
execute jobs, and report status. Supports priority queues, retries with
exponential backoff, and dead-letter handling for failed jobs.

## Architecture Layers

| Layer | Concept | Key Files | Notes |
|-------|---------|-----------|-------|
| API | REST API for job submission | `api/server.py` | Auth via API key, rate limit 100/min |
| Queue | Redis priority queues | `queue/manager.py` | 3 queues: high/medium/low |
| Worker | Job execution workers | `worker/runner.py` | Pool size = CPU cores × 2 |
| Storage | Job state persistence | `storage/job_store.py` | PostgreSQL, job history 30 days |
| External | Webhook notifications | `notifier/webhook.py` | Timeout 30s, 3 retries |

## Critical Paths

### Happy Path: Job Submission → Completion
1. `api/server.py:submit_job()` - Validate and enqueue
2. `queue/manager.py:enqueue()` - Write to Redis with priority
3. `worker/runner.py:poll_and_run()` - Worker picks up job
4. `worker/executor.py:execute()` - Run job logic
5. `storage/job_store.py:mark_complete()` - Persist result
6. `notifier/webhook.py:notify()` - Send webhook (async)

### Error Path: Job Failure → Retry → DLQ
1. `executor.py` raises exception
2. `runner.py:handle_error()` - Capture stack trace
3. `job_store.py:increment_retry()` - Update retry count
4. If retries < max: `queue/manager.py:requeue()` with delay
5. If retries >= max: `queue/manager.py:move_to_dlq()`

## Known Traps

| Symptom | Likely Root Cause | Quick Verify | Fix Pattern |
|---------|-------------------|--------------|-------------|
| Jobs stuck "pending" | Worker pool exhausted | `redis-cli LLEN queue:high` | Scale workers or check for blocking jobs |
| Webhook delivery fails silently | Timeout not logged as error | Check `webhook_logs` table status=timeout | Increase timeout or add circuit breaker |
| Retry count resets to 0 | Race condition on concurrent updates | Check logs for "retry_count=0" after failure | Add optimistic locking |
| High memory in workers | Job result stored in memory after completion | `ps aux | grep worker` RSS growth | Ensure `result` object deleted after webhook |
| Duplicate job execution | Worker crash between completion and ACK | Check `job_logs` for duplicate `started_at` | Make jobs idempotent |

## Configuration

| Config Key | Location | Default | Behavior Change |
|------------|----------|---------|-----------------|
| `WORKER_POOL_SIZE` | env | `cpu_count * 2` | Higher = more concurrency, more memory |
| `RETRY_MAX_ATTEMPTS` | env | 3 | Affects DLQ timing |
| `RETRY_BACKOFF_BASE` | env | 2 | Seconds, exponential: 2, 4, 8... |
| `WEBHOOK_TIMEOUT` | env | 30 | Increase for slow receivers |
| `QUEUE_VISIBILITY_TIMEOUT` | env | 300 | Job considered failed if not ACK'd |

## Debug Shortcuts

```bash
# Check queue depths
redis-cli KEYS "queue:*" | xargs -I {} sh -c 'echo {}: $(redis-cli LLEN {})'

# Find stuck jobs (pending > 5 min)
psql -c "SELECT id, created_at, queue FROM jobs WHERE status='pending' AND created_at < NOW() - INTERVAL '5 minutes'"

# Worker process status
ps aux | grep "jobrunner worker" | grep -v grep

# Recent failures with retries
tail -f /var/log/jobrunner/worker.log | grep -E "(ERROR|retry_count)"

# DLQ inspection
redis-cli LRANGE queue:dlq 0 10
```

## Extension Points

| Extension | How to Add | Examples |
|-----------|------------|----------|
| Custom job type | Subclass `BaseJob` in `jobs/` | `EmailJob`, `ReportJob` |
| Middleware | Add to `worker/middleware.py` | LoggingMiddleware, MetricsMiddleware |
| Queue backend | Implement `QueueBackend` interface | Currently only Redis |

## Uncertain / TODO

- [ ] How does visibility timeout interact with long-running jobs? (Seems to work but mechanism unclear)
- [ ] What happens if Redis connection drops mid-job? (Not tested)
- [ ] Webhook retry backoff is linear, not exponential - intentional?
```

---

## Example 2: Debug Session Transfer

```markdown
# Debug Context: Database Connection Pool Exhaustion

## Problem Statement
Production API intermittently returns 500 errors with "connection timeout"
from database layer, occurring ~5 times per hour during peak load.

## Verified Facts ✅

| Fact | Evidence | Date |
|------|----------|------|
| Connection pool size is 20 | `config/database.yml` line 15 | 2026-03-12 |
| Active connections during incident = 20 | RDS CloudWatch `DatabaseConnections` | 2026-03-12 |
| No slow queries in RDS logs | `logs/rds/slowquery.log` filtered by timestamp | 2026-03-12 |
| API response time spikes BEFORE connection errors | APM trace shows 5s latency before error | 2026-03-12 |
| No connection leaks in application code | Static analysis via `sqlconn-check` tool | 2026-03-12 |

## Excluded Paths ❌

| Path | Reason Excluded | Evidence |
|------|-----------------|----------|
| Database server overloaded | CPU < 30% during incidents | CloudWatch metrics |
| Query performance issue | No slow queries, avg query time 5ms | RDS logs |
| Application code not releasing connections | Leak checker shows 0 unclosed connections | `sqlconn-check` report |
| Network latency to DB | TCP handshake < 1ms, no packet loss | `ping`, `mtr` |

## Active Hypotheses ❓

1. **Connection pool too small for concurrent request load**
   - Confidence: Medium
   - Test: Increase pool size to 50, monitor for 1 hour
   - If true: Need to calculate proper pool size or add connection pooling at load balancer
   - Concern: May mask underlying issue of requests holding connections too long

2. **Requests holding connections longer than necessary**
   - Confidence: Medium-High
   - Test: Add connection duration logging, identify slow transactions
   - If true: Refactor to release connection before slow operations (external API calls)
   - Evidence: APM shows 5s latency before error, suggesting requests hold connections during slow operations

3. **Connection pool not properly configured with timeout**
   - Confidence: Low
   - Test: Check if checkout timeout < query timeout
   - If true: Should see different error pattern (checkout timeout vs query timeout)

## Environment Snapshot

```bash
# Application
Ruby: 3.2.0
Rails: 7.0.4
database.yml pool: 20
database.yml timeout: 5000 (5s)

# Database
PostgreSQL: 14.5
RDS instance: db.r5.xlarge
max_connections: 100 (AWS default)

# Load
Requests/min during incident: ~200
Avg request duration: 150ms
P99 request duration: 2.5s
```

## Context Locations

| Type | Location | Relevance |
|------|----------|-----------|
| Application logs | `/var/log/app/production.log` | Search for "ActiveRecord::ConnectionTimeoutError" |
| Database logs | RDS CloudWatch Logs | Check for connection limit messages |
| APM traces | Datadog Trace List | Filter by error type, look for latency patterns |
| Config | `config/database.yml` | Pool size, timeout settings |
| Code | `app/controllers/api_controller.rb` | Entry point for API requests |

## Next Steps (Recommended)

1. **Add connection duration logging** to identify which requests hold connections longest
   - Modify `application_controller.rb` to log connection checkout/checkin timestamps
   - Deploy to staging, run load test
   - Expected outcome: Identify if connections held during external API calls

2. **If (1) confirms long-held connections:**
   - Refactor to use `ActiveRecord::Base.connection_pool.with_connection` blocks
   - Ensure connections released before external HTTP calls

3. **If (1) shows normal connection patterns:**
   - Increase pool size to 50 as temporary mitigation
   - Calculate proper pool size: (requests/sec × avg request duration) + buffer

## Questions for New Session

- How to properly instrument connection checkout duration in Rails?
- What's the correct formula for connection pool sizing given our load pattern?
- Are there any known issues with Rails 7 + PostgreSQL adapter connection pooling?
```

---

## Example 3: Third-Party API Integration

```markdown
# Interface: Payment Provider API (Stripe)

## Overview
Stripe API integration for payment processing. Using API version 2023-10-16.
Webhook handling for async events. Client library: `stripe-ruby` v10.x.

## Endpoint/Method Map

| Endpoint/Method | Purpose | Auth Required | Rate Limit | Notes |
|-----------------|---------|---------------|------------|-------|
| `POST /v1/payment_intents` | Create payment | Yes | 100/sec | Idempotent with `idempotency_key` |
| `GET /v1/payment_intents/:id` | Retrieve payment | Yes | 100/sec | Use for status polling |
| `POST /v1/refunds` | Refund payment | Yes | 100/sec | Must use original PaymentIntent |
| Webhook `payment_intent.succeeded` | Success notification | Signature verify | N/A | Primary success path |
| Webhook `payment_intent.payment_failed` | Failure notification | Signature verify | N/A | Check `last_payment_error` |

## Request/Response Patterns

### Create Payment Intent

**Request:**
```http
POST /v1/payment_intents
Authorization: Bearer sk_live_...
Idempotency-Key: [UUID]
Content-Type: application/x-www-form-urlencoded

amount=2000&currency=usd&customer=cus_...
```

**Response (Success):**
```json
{
  "id": "pi_123...",
  "status": "requires_confirmation",
  "client_secret": "pi_123..._secret_..."
}
```

**Response (Card Declined):**
```json
{
  "error": {
    "code": "card_declined",
    "decline_code": "insufficient_funds"
  }
}
```

## Error Cases

| Error Code | Meaning | Retry? | Handling |
|------------|---------|--------|----------|
| `card_declined` | Bank declined | No | Show user message, suggest different card |
| `expired_card` | Card expired | No | Prompt for new card details |
| `processing_error` | Stripe error | Yes (1 retry) | Log, retry once, then show generic error |
| `rate_limit` | Too many requests | Yes (exponential) | Backoff and retry |
| `idempotency_key_in_use` | Concurrent request | Yes (wait 1s) | Wait and retry with same key |

## Client Behavior

| Client | Version | Known Issues | Workarounds |
|--------|---------|--------------|-------------|
| stripe-ruby | 10.3.0 | Retries don't include idempotency key | Must set `Stripe.max_network_retries = 0` and handle manually |
| stripe-ruby | 10.x | Webhook signature check fails on Ruby 3.2 | Upgrade to 10.5.0+ |

## Authentication

- Secret keys (`sk_live_`, `sk_test_`) for server-side API calls
- Publishable keys (`pk_live_`, `pk_test_`) for client-side only
- Webhook secrets (`whsec_...`) for webhook signature verification
- **Critical**: Never log full secret keys; Stripe redacts in dashboard but logs may leak

## Idempotency

- Always set `Idempotency-Key` header for `POST` requests
- Keys should be unique per operation (UUID recommended)
- Same key + same params = same response (even if first request failed)
- Keys expire after 24 hours

## Webhook Handling

**Verification (MUST DO):**
```ruby
event = Stripe::Webhook.construct_event(
  payload, 
  sig_header, 
  ENV['STRIPE_WEBHOOK_SECRET']
)
```

**Event Ordering:**
- Webhooks may arrive out of order
- Use `created` timestamp or API fetch for canonical state
- Handle duplicate webhooks (idempotent processing)

**Failure Handling:**
- Return non-200 to trigger Stripe retry (webhooks retried for 3 days)
- Log all webhook processing attempts

## Known Traps

| Symptom | Root Cause | Fix |
|---------|------------|-----|
| Duplicate payments charged | Idempotency key not set or changed on retry | Ensure same key used for all retries |
| Webhook signature invalid | Wrong webhook secret or payload modified | Verify raw payload before JSON parse |
| Payment stuck "processing" | Not handling `processing` status | Poll API after 1 min if status is `processing` |
| Refund fails "charge already refunded" | Race condition, webhook in flight | Check current status before refund attempt |
```

---

## Quality Markers

Effective system logs share these traits:

**✅ Specific locations**
- `file.py:function()` not "the handler"
- Line numbers for critical paths

**✅ Evidence, not speculation**
- "CPU < 30% per CloudWatch" not "server seems fine"
- Commands that produce verifiable output

**✅ Actionable shortcuts**
- Copy-pasteable commands
- Filter patterns that work

---

## Example 3: Troubleshooting Entry (Agent Framework)

```markdown
---
type: trap
severity: high
status: verified
created: 2026-03-16
---

## 症状
Kafka consumer group 频繁 rebalancing，消费延迟持续增加

## 原因
默认 `max.poll.interval.ms` (5分钟) 小于消息处理时间，
consumer 被 coordinator 判定为 dead，触发 rebalance

## 锚点
- Code: `src/services/kafka/consumer.py:poll()`
- Log: `grep "rebalance started" /var/log/kafka/consumer.log`
- Command: `kafka-consumer-groups.sh --bootstrap-server localhost:9092 --describe --group my-group`
- Doc: https://kafka.apache.org/documentation/#max.poll.interval.ms

## 规避
增加 `max.poll.interval.ms` 到处理时间的 2-3 倍：
```python
consumer_config = {
    'max.poll.interval.ms': 600000,  # 10 min
    'max.poll.records': 100,          # 同时减少批处理量
}
```

## 排查步骤
1. 检查 consumer lag: `kafka-consumer-groups.sh --describe`
2. 查看 rebalance 频率: `grep "rebalance" consumer.log | wc -l`
3. 确认处理时间: 检查日志中 poll 到 commit 的时间差
4. 验证修复: 观察 5 分钟内是否还有 rebalance 日志
```

**✅ Explicit uncertainty**
- "TODO: mechanism unclear" better than confident wrong explanation

**✅ Symptom-to-cause mapping**
- Direct link between observed behavior and root mechanism

**❌ Anti-patterns seen in poor logs**
- Narrative of discovery ("first we tried X, then Y...")
- Copy-pasted code blocks without context
- Speculation without evidence
- Outdated information not marked as such
