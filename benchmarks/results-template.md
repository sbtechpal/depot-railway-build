# Benchmark Results Template

**Project**: Depot CI + Railway Integration Demo
**Date Run**: YYYY-MM-DD
**Runner**: [Your Name]
**Environment**: [Your OS, Hardware specs]

---

## Executive Summary

[Brief summary of findings — 2-3 sentences]

---

## Flow 1: Local Build → Railway Deploy

### Description
Build locally on your machine, then deploy via Railway CLI.

### Results

| Iteration | Dependencies | TypeScript | Docker | Deploy | **Total** |
|-----------|-------------|------------|--------|--------|-----------|
| 1 | --s | --s | --s | --s | **--s** |
| 2 | --s | --s | --s | --s | **--s** |
| 3 | --s | --s | --s | --s | **--s** |
| **Average** | **--s** | **--s** | **--s** | --s | **--s** |

### Observations
- Build times are [consistent/variable]
- Docker build takes [percentage]% of total time
- No costs incurred

---

## Flow 2: Git Push → Railway Auto-Build

### Description
Push to GitHub, Railway automatically builds and deploys.

### Results

| Iteration | Queue | Build | Deploy | **Total** | **Cost** |
|-----------|-------|-------|--------|-----------|----------|
| 1 | --s | --s | --s | **--s** | ~$0.05 |
| 2 | --s | --s | --s | **--s** | ~$0.05 |
| 3 | --s | --s | --s | **--s** | ~$0.05 |
| **Average** | **--s** | **--s** | **--s** | **--s** | **~$0.05** |

### Observations
- Railway builds take [longer/shorter] than expected
- Queue time is [significant/minimal]
- Build process [uses a lot of/conserves] Railway credits

### Cost Impact
- 100 builds/month would cost: ~$5
- This [would/would not] consume entire monthly credit
- Annual cost per developer: ~$60

---

## Flow 3: GitHub Actions → Railway (Simulated)

### Description
Simulate GitHub Actions workflow locally.

### Results

| Iteration | Checkout | Setup | Deps | Tests | Build | Deploy | **Total** |
|-----------|----------|-------|------|-------|-------|--------|-----------|
| 1 | --s | --s | --s | --s | --s | --s | **--s** |
| 2 | --s | --s | --s | --s | --s | --s | **--s** |
| 3 | --s | --s | --s | --s | --s | --s | **--s** |
| **Average** | **--s** | **--s** | **--s** | **--s** | **--s** | **--s** | **--s** |

### Observations
- GitHub Actions provides [benefits you observed]
- Workflow is [faster/slower] than expected
- Cost is [reasonable/expensive] for our use case

---

## Comparison Summary

### Time Comparison

| Flow | Average Time | Relative Speed |
|------|--------------|----------------|
| **Flow 1** (Local) | **--s** | Fastest |
| **Flow 2** (Railway) | **--s** | Slowest |
| **Flow 3** (GitHub) | **--s** | Middle |

### Cost Comparison

| Flow | Per Build | Monthly (100 builds) | Annual |
|------|-----------|----------------------|--------|
| **Flow 1** | $0.00 | $0 | $0 |
| **Flow 2** | ~$0.05 | ~$5 | ~$60 |
| **Flow 3** | ~$0.01 | ~$1 | ~$12 |

### Recommendations

Based on these benchmarks, I recommend:

- [ ] **For quick testing**: Flow 1 (fastest, free)
- [ ] **For solo dev**: Flow 2 (if deploy frequency is low)
- [ ] **For team**: Flow 3 (balance of features and cost)

---

## Next Steps

### When Depot CI is Available

- [ ] Get Depot account at depot.dev
- [ ] Configure Depot CLI
- [ ] Re-run `benchmark-flows.sh`
- [ ] Add Flow 4 results
- [ ] Compare Depot CI vs baselines

### Expected Depot CI Performance

Based on Depot claims, expect:
- **5-10x faster** than Flow 2
- **80% cost savings** vs Flow 2
- **Similar cost** to Flow 3, but much faster

---

## Appendix

### System Information

**OS**: [macOS 14 / Ubuntu 22.04 / Windows 11]
**CPU**: [M1 Pro / Intel i7 / AMD Ryzen]
**RAM**: [16GB / 32GB]
**Docker**: [Docker Desktop 24.x]
**Node**: [v20.x]

### Environment Variables

```bash
NODE_VERSION=18.x
DOCKER_VERSION=24.x
```

### Notes

[Any additional observations or issues encountered]

---

**Results File**: `benchmarks/results/benchmark_YYYYMMDD_HHMMSS.csv`

**End of Report**
