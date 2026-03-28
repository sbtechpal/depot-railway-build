# Depot CI vs GitHub Actions: Technical Deep Dive

Here's a side-by-side comparison of how they fundamentally differ:

```text
┌─────────────────────────────────────────────────────────────────────────────┐
│                         ARCHITECTURAL COMPARISON                            │
├─────────────────────────────────────────────────────────────────────────────┤
│                            GITHUB ACTIONS vs DEPOT CI                       │
└─────────────────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────────────────┐
│                         ORCHESTRATION MODEL                                 │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│  GitHub Actions:                                                            │
│  - Event-driven (webhook-based)                                             │
│  - Stateless event listener                                                 │
│  - GitHub control plane triggers runner                                     │
│  - Runner polls for jobs (pull model)                                       │
│  - No built-in job orchestration                                            │
│                                                                             │
│  Depot CI:                                                                  │
│  - Programmable task scheduler                                              │
│  - Durable state machine (Switchyard)                                       │
│  - Orchestrator explicitly schedules tasks                                  │
│  - Tasks managed with state persistence                                     │
│  - Explicit dependency resolution                                           │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────────────────┐
│                         RUNNER/COMPUTE MODEL                                │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│  GitHub Actions:                                                            │
│  - Ephemeral runners per job                                                │
│  - Runner polls GitHub for jobs                                             │
│  - Listener waits up to 50 seconds for new jobs                             │
│  - Cold start for each new runner (40+ seconds)                             │
│  - Runner lifecycle managed by GitHub                                       │
│  - Tight coupling to GitHub API                                             │
│                                                                             │
│  Depot CI:                                                                  │
│  - Ephemeral sandboxes per job                                              │
│  - Orchestrator assigns job to sandbox                                      │
│  - Sandbox starts in 2-3 seconds                                           │
│  - Pre-warmed standby pools                                                 │
│  - Stopped EC2 → Running (2-3 sec)                                         │
│  - Provisioning system manages lifecycle                                    │
│  - Decoupled from frontends                                                 │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────────────────┐
│                         JOB EXECUTION FLOW                                   │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│  GITHUB ACTIONS (Event-Driven Pull Model):                                  │
│                                                                             │
│  1. Developer pushes code to GitHub                                         │
│     ↓                                                                       │
│  2. GitHub webhook fires → Runner Broker API                                │
│     ↓                                                                       │
│  3. GitHub control plane looks for available runner                         │
│     ↓                                                                       │
│  4. Runner polls GitHub: "Any jobs for me?"                                │
│     ↓                                                                       │
│  5. GitHub says: "Yes, here's your job"                                    │
│     ↓                                                                       │
│  6. Runner acquires job with acquirejob() API call                          │
│     ↓                                                                       │
│  7. Runner listener starts worker process                                   │
│     ↓                                                                       │
│  8. Worker executes job commands                                            │
│     ↓                                                                       │
│  9. Runner polls for more jobs (loop)                                       │
│     ↓                                                                       │
│  10. No more jobs → runner terminates                                       │
│                                                                             │
│  DEPOT CI (Programmable Push Model):                                        │
│                                                                             │
│  1. Developer pushes code or triggers manually                              │
│     ↓                                                                       │
│  2. Depot API receives workflow definition                                  │
│     ↓                                                                       │
│  3. Frontend translator converts YAML → Switchyard tasks                    │
│     ↓                                                                       │
│  4. Switchyard Orchestrator:                                               │
│     - Parses job DAG (dependency graph)                                     │
│     - Resolves job dependencies                                             │
│     - Creates explicit task schedule                                        │
│     ↓                                                                       │
│  5. Provisioning system:                                                    │
│     - Checks standby pools                                                  │
│     - Allocates compute resources                                           │
│     ↓                                                                       │
│  6. Sandbox boots from standby pool (2-3 sec)                               │
│     ↓                                                                       │
│  7. Orchestrator assigns specific job to sandbox                            │
│     ↓                                                                       │
│  8. Sandbox executes job (BuildKit running)                                 │
│     ↓                                                                       │
│  9. Orchestrator tracks job completion                                      │
│     ↓                                                                       │
│  10. Next jobs in dependency graph can start                                │
│     ↓                                                                       │
│  11. All jobs complete → sandbox terminates                                │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────────────────┐
│                    KEY ARCHITECTURAL DIFFERENCES                            │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│  1. TIGHTLY COUPLED vs MODULAR                                              │
│     ─────────────────────────────────────────                                │
│     GitHub Actions:                                                         │
│     └─ Runner is tightly coupled to GitHub API                             │
│     └─ Listener/Worker are GitHub-specific                                  │
│     └─ Can only run GitHub Actions workflows                               │
│                                                                             │
│     Depot CI:                                                               │
│     └─ Modular: Frontend ← Orchestrator → Compute                          │
│     └─ Frontend can be swapped (YAML today, others tomorrow)               │
│     └─ Orchestrator doesn't care about workflow format                     │
│     └─ Compute is generic task executor                                     │
│                                                                             │
│  2. STATELESS vs DURABLE                                                    │
│     ─────────────────────────────────────────                                │
│     GitHub Actions:                                                         │
│     └─ Listener is stateless                                               │
│     └─ Job state lives in GitHub database                                  │
│     └─ If listener crashes mid-job, runner starts fresh                    │
│     └─ No built-in recovery mechanism                                      │
│                                                                             │
│     Depot CI:                                                               │
│     └─ Switchyard maintains durable state                                  │
│     └─ Like AWS SWF or Temporal                                            │
│     └─ State persisted throughout job lifecycle                            │
│     └─ Can retry individual jobs without full re-run                       │
│     └─ Infrastructure failures don't lose progress                         │
│                                                                             │
│  3. POLLING/PUSH vs EXPLICIT SCHEDULING                                     │
│     ─────────────────────────────────────────                                │
│     GitHub Actions:                                                         │
│     └─ Runner asks GitHub: "Got any jobs?"                                │
│     └─ GitHub returns ONE job at a time                                    │
│     └─ Runner executes, then polls again                                   │
│     └─ No dependency resolution at runner level                            │
│     └─ GitHub decides when to send next job                                │
│                                                                             │
│     Depot CI:                                                               │
│     └─ Orchestrator explicitly schedules based on DAG                      │
│     └─ Knows all job dependencies upfront                                  │
│     └─ Parallel jobs can start immediately                                 │
│     └─ Orchestrator decides optimal scheduling                             │
│     └─ Can handle complex dependency graphs                                │
│                                                                             │
│  4. STARTUP TIME                                                            │
│     ─────────────────────────────────────────                                │
│     GitHub Actions:                                                         │
│     └─ 40+ seconds cold start per new runner                               │
│     └─ 10-45 seconds typical startup                                       │
│     └─ No standby pools                                                     │
│     └─ On-demand from AWS (slow)                                           │
│                                                                             │
│     Depot CI:                                                               │
│     └─ 2-3 seconds (standby pool)                                          │
│     └─ 10x-20x faster                                                      │
│     └─ Pre-warmed instances in stopped state                               │
│     └─ Scaling from stopped → running state                                │
│                                                                             │
│  5. JOB RENEWAL / HEARTBEAT                                                 │
│     ─────────────────────────────────────────                                │
│     GitHub Actions:                                                         │
│     └─ Listener must renew job lock every minute                           │
│     └─ 10-minute lock window                                               │
│     └─ Manual polling mechanism                                            │
│     └─ If renewal fails, job timeout                                       │
│                                                                             │
│     Depot CI:                                                               │
│     └─ Orchestrator manages state automatically                            │
│     └─ Distributed state machine handles timeouts                           │
│     └─ No manual polling required                                           │
│     └─ Implicit job monitoring                                             │
│                                                                             │
│  6. BILLING MODEL                                                           │
│     ─────────────────────────────────────────                                │
│     GitHub Actions:                                                         │
│     └─ Per-minute (rounded up)                                             │
│     └─ Even 31 seconds = 1 full minute                                     │
│     └─ No granular visibility                                              │
│                                                                             │
│     Depot CI:                                                               │
│     └─ Per-second billing                                                  │
│     └─ Exact usage tracked                                                 │
│     └─ More transparent costs                                              │
│                                                                             │
│  7. API ARCHITECTURE                                                        │
│     ─────────────────────────────────────────                                │
│     GitHub Actions (Current):                                               │
│     └─ GitHub Actions Broker API (recently migrated)                       │
│     └─ Long-polling with 50-second timeout                                │
│     └─ Session-based communication                                         │
│     └─ Multiple API endpoints (sessions, message, acquirejob, renewjob)    │
│                                                                             │
│     Depot CI:                                                               │
│     └─ Custom Switchyard orchestrator API                                  │
│     └─ Explicit task scheduling                                            │
│     └─ Durable state management                                            │
│     └─ Unified orchestrator                                                │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

## Technical Deep Dive: GitHub Actions Runner Architecture

To understand the difference, here's how GitHub Actions actually works under the hood:

### GitHub Actions Runner Lifecycle

#### Phase 1: Registration

Developer pushes code → GitHub webhook triggers → GitHub's control plane creates job → Runner Broker API is notified

#### Phase 2: Job Polling

Runner Listener polls: `GET /message?sessionId=...&status=Online`

- Server holds request open for up to 50 seconds
- If no job: returns 202 Accepted, listener polls again
- If job ready: returns RunnerJobRequest message

#### Phase 3: Job Acquisition

Runner calls: `POST /acquirejob` with jobMessageId

- Receives full job instructions (very large JSON)
- Listener extracts planId for lock renewal

#### Phase 4: Job Lock Renewal (Heartbeat)

Listener starts background task

- Every 1 minute: `POST /renewjob` with planId & jobId
- Server responds with lock expiration time (10 minutes)
- If renewal fails → job timeout

#### Phase 5: Job Execution

Listener starts Worker process → Worker receives job instructions → Worker executes each step sequentially → Worker reports status back

## Why This Matters: Key Technical Differences

| Aspect | GitHub Actions | Depot CI |
| :--- | :--- | :--- |
| Orchestration | Event-driven webhook | Programmable task scheduler |
| State Management | Stateless listener | Durable state machine |
| Job Polling | Pull model (runner asks GitHub) | Push model (orchestrator assigns) |
| Dependency Resolution | No built-in DAG | Explicit dependency graph (DAG) |
| Startup Time | 40+ seconds | 2-3 seconds |
| Compute Model | New EC2 per job | Pre-warmed standby pools |
| Recovery | None (manual retry) | Automatic (durable state) |
| Billing | Per-minute (rounded up) | Per-second (exact) |
| Frontend Coupling | Tightly coupled to GitHub | Modular (swappable frontends) |
| Scaling | GitHub manages | Orchestrator manages |

## The Problem Depot CI Solves

### GitHub Actions Limitations

- ❌ Stateless: can't resume interrupted jobs
- ❌ Polling model: slow job delivery
- ❌ No DAG: can't optimize parallel execution
- ❌ Cold starts: 40+ seconds per job
- ❌ Per-minute billing: wasted money on rounding
- ❌ Tightly coupled: can't swap workflow formats

### Depot CI Solutions

- ✅ Durable state: resumable job execution
- ✅ Push model: immediate job assignment
- ✅ Explicit DAG: optimal parallel scheduling
- ✅ Standby pools: 2-3 second starts
- ✅ Per-second billing: exact costs
- ✅ Modular: future-proof frontend support

## Architecture Diagram: GitHub Actions vs Depot CI

```text
┌─────────────────────────────────────────────────────────────────┐
│   GITHUB ACTIONS: Event-Driven, Stateless, Polling Model        │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  GitHub Push Event                                             │
│      ↓                                                         │
│  ┌──────────────────────────────┐                              │
│  │   GitHub Control Plane       │                              │
│  │   (stateless, event-driven)  │                              │
│  └──────────────────┬───────────┘                              │
│           │ Webhook                                            │
│           ↓                                                     │
│  ┌──────────────────────┐                                      │
│  │   Runner Listener    │                                      │
│  │   (polls for jobs)   │                                      │
│  │                       │                                      │
│  │   GET /message?...   │◄─── 50-second poll                  │
│  │   (wait for job)     │                                      │
│  └──────────────┬───────┘                                      │
│           │                                                     │
│           ↓                                                     │
│  ┌──────▼──────────┐                                           │
│  │ POST /acquirejob│                                           │
│  └──────┬──────────┘                                           │
│           │                                                     │
│           ↓                                                     │
│  ┌──────────────────▼───────────────────┐                      │
│  │  Runner Worker (executes steps)      │                      │
│  │  + Background renewal loop:          │                      │
│  │    Every 1 min: POST /renewjob       │                      │
│  └─────────────────────────────────────┘                      │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────┐
│   DEPOT CI: Programmable, Durable State, Push Model             │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  Developer/Webhook                                              │
│      ↓                                                         │
│  ┌──────────────────────────────┐                              │
│  │ Depot API (Control Plane)    │                              │
│  │ - Receives workflow          │                              │
│  │ - Validates auth             │                              │
│  └──────────────────┬───────────┘                              │
│           ↓                                                     │
│  ┌──────────────────────────────┐                              │
│  │ Frontend (YAML Translator)   │                              │
│  │ - Parse GitHub Actions YAML  │                              │
│  │ - Apply transformations      │                              │
│  └──────────────────┬───────────┘                              │
│           ↓                                                     │
│  ┌──────────────────────────────────────┐                     │
│  │      Switchyard Orchestrator         │                     │
│  │      (Durable State Machine)         │                     │
│  │ - Build job DAG                     │                     │
│  │ - Resolve dependencies              │                     │
│  │ - Schedule tasks                    │                     │
│  │ - Track state (persistent)          │                     │
│  └──────────────────┬────────────────────┘                   │
│           │ Direct assignment                                   │
│           ↓                                                     │
│  ┌──────────────────────────────┐                              │
│  │    Provisioning System       │                              │
│  │ - Check standby pools        │                              │
│  │ - Allocate compute           │                              │
│  └──────────────┬───────────────┘                              │
│           ↓                                                     │
│  ┌──────────────────────────────┐                              │
│  │ Standby Pool EC2 (stopped)   │                              │
│  │ Transitions: stopped → running                              │
│  │ Time: 2-3 seconds            │                              │
│  └──────────────┬───────────────┘                              │
│           ↓                                                     │
│  ┌──────────────────────────────┐                              │
│  │ Sandbox (BuildKit running)   │                              │
│  │ - Executes assigned job      │                              │
│  │ - No manual polling          │                              │
│  │ - No lock renewal loops      │                              │
│  │ - Automatic state tracking   │                              │
│  └──────────────────────────────┘                              │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

Does this clarify the fundamental technical differences? The key insight is that Depot CI is built as a proper distributed system with durable state management, while GitHub Actions is an event-driven polling system.
