# Depot & Depot CI: Summary

## What is Depot?

Depot is a modern developer platform built for the AI-augmented development era. It started by making container builds **40x faster** and is now building a complete software delivery platform.

### The Problem Depot Solves

The bottleneck in software development has shifted:

- **Old world**: Writing code was the bottleneck
- **New world**: Integrating code is the bottleneck

With AI coding agents like Claude Code and Cursor, a team of 10 engineers can now produce output like 100. Traditional CI systems (GitHub Actions, CircleCI, Buildkite) were designed for a world where humans batch up code, push it, and wait. A 15-minute pipeline was annoying but survivable.

**That world is gone.**

---

## What is Depot CI?

Depot CI is a **programmable CI engine** with performance as a first-class citizen. It's designed as a faster, more reliable alternative to traditional CI systems, built specifically for modern software engineering workflows.

### Current Status

| Aspect | Details |
|--------|---------|
| **Status** | Generally Available (GA) |
| **Pricing** | $0.0001/second (no minimums) |
| **Free Trial** | 7 days, full access, no credit card required |
| **Plans** | Start at $20/month with 2,000 build minutes included |

---

## Key Features

### GitHub Actions Compatible

Run your existing GitHub Actions workflows on Depot CI without modification:

```bash
depot ci migrate  # Copy workflows from .github/workflows to .depot/workflows
```

- Same YAML syntax
- No migration project required
- Run both systems in parallel during testing

### Performance-First Architecture

| Feature | GitHub Actions | Depot CI | Improvement |
|---------|---------------|----------|-------------|
| **Startup** | 40+ seconds cold start | 2-3 seconds standby pools | 10-20x faster |
| **State** | Stateless (crash = restart) | Durable (crash = resume) | Reliable recovery |
| **Scheduling** | Pull model (one job at a time) | Push model (DAG-aware) | Optimal parallelization |
| **Billing** | Per-minute (rounded up) | Per-second (exact) | Fair pricing |
| **Debugging** | Restart from beginning | Replay from any step + SSH | Faster iteration |
| **AI Features** | None | AI failure diagnosis + Agent loops | Built for AI development |

### AI-Native Features

#### AI Failure Diagnosis

When a job fails, Depot CI automatically analyzes the failure and displays:

- **What went wrong**: AI-generated explanation of the root cause
- **Suggested fix**: Actionable steps to resolve the issue

No more digging through thousands of lines of logs or guessing at the root cause.

#### Coding Agent Integration

Depot CI is built for AI coding agents (Claude Code, Cursor, etc.):

![The Agent Fix-CI Loop](depot-dev/agent-loop.png)

**Traditional CI**: `push → wait → guess → fix → push → wait → guess`

**Depot CI with agents**: `fix → run → fix → run → fix → green`

---

## Depot CI Architecture

Depot CI has a **three-part modular architecture**:

```
┌─────────────────────────────────────────────────────────────────┐
│                    DEPOT CI ARCHITECTURE                        │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  ┌──────────────────────────────────────────────────────────┐   │
│  │  FRONTEND LAYER                                           │   │
│  │  • GitHub Actions YAML Parser                            │   │
│  │  • Validates & converts workflows                        │   │
│  │  • Supports future formats (GitLab CI, etc.)             │   │
│  └────────────────────┬─────────────────────────────────────┘   │
│                       │                                         │
│  ┌────────────────────▼─────────────────────────────────────┐   │
│  │  ORCHESTRATOR LAYER (Switchyard)                          │   │
│  │  • Durable state machine                                  │   │
│  │  • Builds job dependency graphs (DAG)                     │   │
│  │  • Schedules tasks across compute fleet                  │   │
│  │  • Tracks state, handles failures & retries              │   │
│  └────────────────────┬─────────────────────────────────────┘   │
│                       │                                         │
│  ┌────────────────────▼─────────────────────────────────────┐   │
│  │  COMPUTE LAYER                                            │   │
│  │  • Standby pools (2-3 sec startup)                       │   │
│  │  • Sandboxes with BuildKit pre-installed                 │   │
│  │  • SSH debugging, metrics, logs                           │   │
│  │  • Per-second billing                                     │   │
│  └──────────────────────────────────────────────────────────┘   │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

### Frontend Layer

- Parses GitHub Actions YAML
- Validates and converts workflows
- **Extensible**: Future support for GitLab CI, Jenkins, etc.

### Orchestrator Layer (Switchyard)

The "brain" of Depot CI:

- **Workflow Parser**: Extracts jobs, steps, and dependencies
- **Dependency Resolution**: Builds a DAG (Directed Acyclic Graph) to identify parallelizable jobs
- **Durable State Machine**: Like AWS SWF or Temporal — state persists throughout job lifecycle
- **Task Scheduler**: Explicitly schedules tasks based on optimal ordering

### Compute Layer

- **Standby Pools**: Pre-warmed EC2 instances in stopped state
- **Fast Startup**: Stopped → Running in 2-3 seconds
- **Isolated Sandboxes**: Each job runs in a dedicated environment
- **SSH Access**: Debug directly into running sandboxes

---

## DAG Resolution: How Depot CI Schedules Jobs

DAG (Directed Acyclic Graph) resolution is a key performance advantage:

### GitHub Actions: Pull Model

```
Runner: "Got any jobs for me?"
GitHub: "Here's ONE job: test"
Runner: [runs test]
Runner: "Got any more?"
GitHub: "Here's ONE job: lint"
...
```

### Depot CI: Push Model

```
Switchyard: "I see the full workflow DAG."
           "test and lint can run in parallel → Start BOTH now!"
           "build waits for test → Schedule for after test"
           "deploy waits for lint AND build → Schedule for last"
```

### Performance Impact

| Workflow | GitHub Actions | Depot CI | Savings |
|----------|---------------|----------|---------|
| 4 jobs (2 parallel) | 7 minutes | 6 minutes | 14% |
| Complex workflows | More sequential | More parallel | Even greater |

---

## Key CLI Commands

```bash
# Run workflow against local changes
depot ci run --workflow .depot/workflows/ci.yml

# Scope to specific job for faster iteration
depot ci run --job test

# Check full run status
depot ci status

# Get logs for a failed job
depot ci logs <run-id> --job <job-name>

# SSH into running sandbox
depot ci ssh <run-id>

# Run with SSH pause after specific step
depot ci run --ssh-after-step 3

# Migrate from GitHub Actions
depot ci migrate
```

---

## Value Proposition

### Time Savings

- 10 builds/day × 4 min saved = 40 min/day
- 40 min/day × 5 days = 200 min/week
- **That's an extra morning every week**

### Cost Savings

- 80% reduction in CI compute costs
- Per-second billing means you only pay for what you actually use

### Developer Experience

- Fast builds mean more iterations
- More iterations mean better products
- Better products mean happier customers

---

## Getting Started

1. **Sign up**: [depot.dev/sign-up](https://depot.dev/sign-up) — 7-day free trial
2. **Install CLI**: `npm install -g @depot/cli`
3. **Migrate workflows**: `depot ci migrate`
4. **Start building**: `depot ci run`

---

## References

- [Depot CI Overview](https://depot.dev/docs/ci/overview)
- [Depot CI Metrics - AI Failure Diagnosis](https://depot.dev/docs/ci/observability/depot-ci-metrics)
- [Coding Agent Integration](https://depot.dev/docs/ci/how-to-guides/coding-agents)
- [Brand Assets](https://depot.dev/about/brand-assets)
- [Depot Blog](https://depot.dev/blog)

---

**Tagline**: *"Stop waiting for your builds. Start shipping."*
