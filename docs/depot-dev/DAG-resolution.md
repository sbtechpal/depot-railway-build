# DAG Resolution in Depot CI

## What is a DAG?

A **DAG** (Directed Acyclic Graph) is a mathematical structure used to represent dependencies between jobs in CI/CD workflows.

- **Directed**: Relationships have a direction (A depends on B)
- **Acyclic**: No circular dependencies (A → B → C → A would create an infinite loop)
- **Graph**: A visual representation of nodes (jobs) and edges (dependencies)

## How DAG Resolution Works

### 1. Parse Workflow YAML

Depot CI reads your GitHub Actions workflow and extracts job definitions:

```yaml
jobs:
  test:
    runs-on: ubuntu-latest
    # No dependencies

  lint:
    runs-on: ubuntu-latest
    # No dependencies

  build:
    runs-on: ubuntu-latest
    needs: [test]
    # Depends on 'test'

  deploy:
    runs-on: ubuntu-latest
    needs: [lint, build]
    # Depends on BOTH 'lint' AND 'build'
```

### 2. Build Dependency Graph

Depot CI constructs a visual representation of all dependencies:

```text
        ┌─────────┐
        │  test   │
        └────┬────┘
             │
             ▼
        ┌─────────┐     ┌─────────┐
        │  build  │────▶│ deploy  │
        └─────────┘     ▲         │
                        │         │
                 ┌──────┴────────┤
                 │                │
           ┌─────┴─────┐    ┌─────┴─────┐
           │   lint   │    │           │
           └───────────┘    │           │
                             │           │
                        [Can run in parallel]
```

### 3. Identify Parallelizable Jobs

The DAG resolution algorithm analyzes the graph to find jobs with no dependencies between them:

- `test` and `lint` have **no dependencies** on each other → **Can run in parallel**
- `build` must wait for `test` → **Must run after test**
- `deploy` must wait for BOTH `lint` AND `build` → **Must run last**

### 4. Schedule Jobs Optimally

With the complete DAG, Switchyard (Depot CI's orchestrator) can:

1. **Start parallel jobs immediately**: `test` and `lint` begin at the same time
2. **Chain dependent jobs**: As soon as `test` completes, `build` starts
3. **Wait for all dependencies**: `deploy` only starts when BOTH `lint` AND `build` complete

## GitHub Actions vs Depot CI

### GitHub Actions: Pull Model (One Job at a Time)

```text
Runner: "Got any jobs for me?"
GitHub: "Here's ONE job: test"
Runner: [runs test]
Runner: "Got any more?"
GitHub: "Here's ONE job: lint"
Runner: [runs lint]
Runner: "Got any more?"
GitHub: "Here's ONE job: build"
...
```

**Problem**: The runner has no awareness of upcoming jobs. It can't plan ahead or optimize.

### Depot CI: Push Model (DAG-Aware Scheduling)

```text
Switchyard: "I see the full workflow DAG."
           "test and lint can run in parallel → Start BOTH now!"
           "build waits for test → Schedule for after test"
           "deploy waits for lint AND build → Schedule for last"
```

**Advantage**: Complete workflow awareness enables optimal scheduling from the start.

## Performance Impact

### Example Workflow

```yaml
jobs:
  test:   # 2 minutes
  lint:   # 1 minute
  build:  # 3 minutes (needs: test)
  deploy: # 1 minute (needs: lint, build)
```

### GitHub Actions Execution (Sequential Polling)

| Job | Start | Duration | Timeline |
|-----|-------|----------|----------|
| test | 0:00 | 2 min | `▓▓░░░░░░░` |
| lint | 0:02 | 1 min | `░░▓░░░░░░` |
| build | 0:03 | 3 min | `░░░▓▓▓░░░` |
| deploy | 0:06 | 1 min | `░░░░░░▓░` |
| **Total** | | | **7 minutes** |

### Depot CI Execution (DAG-Optimized)

| Job | Start | Duration | Timeline |
|-----|-------|----------|----------|
| test | 0:00 | 2 min | `▓▓░░░░░░░` |
| lint | 0:00 | 1 min | `▓░░░░░░░░` |
| build | 0:02 | 3 min | `░░▓▓▓░░░░` |
| deploy | 0:05 | 1 min | `░░░░░▓░░░` |
| **Total** | | | **6 minutes** |

**Savings**: 1 minute (14% faster) on this simple workflow. Complex workflows with more parallel jobs see even greater improvements.

## Key Benefits of DAG Resolution

| Benefit | Description |
|---------|-------------|
| **Parallelization** | Automatically identifies and runs independent jobs simultaneously |
| **Optimal Ordering** | Calculates the fastest path to completion |
| **Resource Efficiency** | Maximizes compute utilization by running jobs in parallel |
| **Predictability** | Knows the entire execution plan upfront |
| **Resilience** | Can retry failed jobs without re-running the entire workflow |

## Real-World Example

```yaml
jobs:
  unit-test:
    runs-on: ubuntu-latest

  integration-test:
    runs-on: ubuntu-latest

  lint:
    runs-on: ubuntu-latest

  security-scan:
    runs-on: ubuntu-latest

  build-backend:
    needs: [unit-test, integration-test]
    runs-on: ubuntu-latest

  build-frontend:
    needs: [lint]
    runs-on: ubuntu-latest

  deploy-staging:
    needs: [build-backend, build-frontend, security-scan]
    runs-on: ubuntu-latest
```

### DAG Visualization

```text
                    ┌──────────────────┐
                    │  Parallel Start  │
                    └────────┬─────────┘
                             │
        ┌────────────┬────────┼────────┬────────────┐
        ▼            ▼        ▼        ▼            ▼
   ┌────────┐  ┌────────┐ ┌──────┐ ┌──────┐    ┌──────────┐
   │unit-test│  │int-test│ │ lint │ │security│   │          │
   └───┬────┘  └───┬────┘ └───┬──┘ └──────┘    │          │
       │           │          │               │          │
       └─────┬─────┘          │               │          │
             ▼                │               │          │
        ┌─────────┐           │               │          │
        │build-   │           │               │          │
        │backend  │           │               │          │
        └────┬────┘           │               │          │
             │                │               │          │
             └────────┬───────┴───────────────┘          │
                      ▼                                  │
                ┌─────────────┐                          │
                │ build-      │                          │
                │ frontend    │                          │
                └──────┬──────┘                          │
                       │                                 │
                       └────────────┬────────────────────┘
                                    ▼
                             ┌──────────────┐
                             │deploy-staging│
                             └──────────────┘
```

With DAG resolution, Depot CI can:
1. Start 4 jobs in parallel (unit-test, integration-test, lint, security-scan)
2. Start build-backend as soon as both tests complete
3. Start build-frontend as soon as lint completes
4. Start deploy-staging only when ALL dependencies are satisfied

## Conclusion

DAG resolution is a fundamental advantage of Depot CI's architecture. By parsing the entire workflow upfront and building a complete dependency graph, Switchyard can:

- Run more jobs in parallel
- Complete workflows faster
- Use compute resources more efficiently
- Provide better visibility into workflow execution

This is part of why Depot CI is significantly faster than traditional CI systems that use pull-based, one-job-at-a-time scheduling.
