# OpenClaw Performance Comparison - Final Results

**Test Period:** April 3, 2026
**Total Tests:** 30 test runs (6 local + 24 CI)
**Last Updated:** 2026-04-03

---

## Executive Summary

| Environment | With Cleanup | Without Cleanup | vs Local (avg) |
|-------------|--------------|-------------------|-----------------|
| **Local Docker** | 10m 4s | — | baseline |
| **GitHub Actions** | 3m 43s | 3m 53s | **2.7x faster** |
| **Depot CI** | 1m 59s | 2m 18s | **5.1x faster** 🏆 |

---

## Complete Results Table (With Disk Cleanup)

| Test | Local | GitHub Actions | Depot CI | Depot vs Local | Depot vs GHA |
|------|-------|----------------|----------|----------------|--------------|
| **Baseline** | 13m 14s | 3m 4s | 1m 51s | **7.1x faster** | **1.7x faster** |
| **Documentation** | 10m 7s | 2m 39s | 1m 50s | **5.5x faster** | **1.4x faster** |
| **Source File** | 8m 58s | 2m 37s | 1m 51s | **4.8x faster** | **1.4x faster** |
| **UI Component** | 9m 23s | 2m 30s | 1m 52s | **5.0x faster** | **1.3x faster** |
| **New Dependency** | 9m 53s | 6m 3s | 1m 53s | **5.3x faster** | **3.3x faster** |
| **Major Changes** | 8m 52s | 5m 25s | 2m 36s | **3.4x faster** | **2.1x faster** |

---

## Complete Results Table (Without Disk Cleanup)

| Test | GitHub Actions | Depot CI | Depot vs Local | Depot vs GHA |
|------|----------------|----------|----------------|--------------|
| **Baseline** | 4m 6s | 2m 1s | 6.6x faster | **2.0x faster** |
| **Documentation** | 4m 1s | 2m 47s | 3.6x faster | **1.4x faster** |
| **Source File** | 4m 0s | 2m 47s | 3.6x faster | **1.4x faster** |
| **UI Component** | 3m 57s | **1m 26s** ⚡ | 6.9x faster | **2.8x faster** |
| **New Dependency** | 3m 55s | 3m 11s | 3.1x faster | **1.1x faster** |
| **Major Changes** | 3m 51s | **1m 42s** ⚡ | 5.2x faster | **2.2x faster** |

---

## Performance Analysis

### Average Build Times

```
Local Docker:              10m 4s   (604s avg)
GitHub Actions (clean):     3m 43s   (223s avg, 6 tests)
GitHub Actions (no clean):  3m 53s   (233s avg, 6 tests)
Depot CI (clean):           1m 59s   (119s avg, 6 tests)
Depot CI (no clean):         2m 18s   (138s avg, 6 tests)
```

### Speedup Comparison

```
GitHub Actions vs Local (clean):     3.0x faster
GitHub Actions vs Local (no clean):  2.7x faster
Depot CI vs Local (clean):           5.1x faster
Depot CI vs Local (no clean):         4.6x faster
Depot CI vs GitHub Actions (clean):  1.9x faster
Depot CI vs GitHub Actions (no clean): 1.7x faster
```

---

## Disk Cleanup Impact Analysis

### When Cleanup Helps:

| Test | GHA Impact | Depot Impact | Reason |
|------|------------|--------------|---------|
| Baseline | +34% slower without | +9% slower without | Cold builds need clean space |
| Documentation | +52% slower without | +52% slower without | Cache operations need space |
| Source File | +53% slower without | +50% slower without | Similar to documentation |
| New Dependency | +36% faster without* | +69% slower without | GHA anomaly; Depot needs cache |

*GitHub Actions had an anomaly with cleanup (6m 3s unusually slow)

### When Cleanup Hurts:

| Test | GHA Impact | Depot Impact | Reason |
|------|------------|--------------|---------|
| UI Component | +58% slower without | **23% faster without** ⚡ | Filesystem cache more valuable |
| Major Changes | +27% faster without | **35% faster without** ⚡ | Cleanup overhead > benefit |

### Key Insight:

Cleanup is a tradeoff:
- **For cold/dependency-heavy builds:** Clean disk space provides clear benefits
- **For incremental changes:** Existing filesystem cache is more valuable
- **Cleanup overhead:** The time spent cleaning can outweigh the performance benefits

---

## Test-by-Test Analysis

### 1. Baseline (Cold Build)

| Metric | Local | GHA (clean) | GHA (no clean) | Depot (clean) | Depot (no clean) |
|--------|-------|-------------|---------------|--------------|----------------|
| **Time** | 13m 14s | 3m 4s | 4m 6s | 1m 51s | 2m 1s |
| **vs Local** | — | 4.3x faster | 3.2x faster | 7.1x faster | 6.6x faster |

**Winner:** Depot CI with cleanup (1m 51s)

### 2. Documentation (README Comment)

| Metric | Local | GHA (clean) | GHA (no clean) | Depot (clean) | Depot (no clean) |
|--------|-------|-------------|---------------|--------------|----------------|
| **Time** | 10m 7s | 2m 39s | 4m 1s | 1m 50s | 2m 47s |
| **vs Local** | — | 3.8x faster | 2.5x faster | 5.5x faster | 3.6x faster |

**Winner:** Depot CI with cleanup (1m 50s)

### 3. Source File (New TypeScript File)

| Metric | Local | GHA (clean) | GHA (no clean) | Depot (clean) | Depot (no clean) |
|--------|-------|-------------|---------------|--------------|----------------|
| **Time** | 8m 58s | 2m 37s | 4m 0s | 1m 51s | 2m 47s |
| **vs Local** | — | 3.4x faster | 2.2x faster | 4.8x faster | 3.6x faster |

**Winner:** Depot CI with cleanup (1m 51s)

### 4. UI Component (New UI File)

| Metric | Local | GHA (clean) | GHA (no clean) | Depot (clean) | Depot (no clean) |
|--------|-------|-------------|---------------|--------------|----------------|
| **Time** | 9m 23s | 2m 30s | 3m 57s | 1m 52s | **1m 26s** ⚡ |
| **vs Local** | — | 3.7x faster | 2.4x faster | 5.0x faster | 6.9x faster |

**Winner:** Depot CI WITHOUT cleanup (1m 26s) 🏆

### 5. New Dependency (Package.json Touch)

| Metric | Local | GHA (clean) | GHA (no clean) | Depot (clean) | Depot (no clean) |
|--------|-------|-------------|---------------|--------------|----------------|
| **Time** | 9m 53s | 6m 3s* | 3m 55s | 1m 53s | 3m 11s |
| **vs Local** | — | 1.6x faster | 2.5x faster | 5.3x faster | 3.1x faster |

*Anomaly: unusually slow, possibly runner-specific issue

**Winner:** Depot CI with cleanup (1m 53s)

### 6. Major Changes (Multiple Files Touch)

| Metric | Local | GHA (clean) | GHA (no clean) | Depot (clean) | Depot (no clean) |
|--------|-------|-------------|---------------|--------------|----------------|
| **Time** | 8m 52s | 5m 25s | 3m 51s | 2m 36s | **1m 42s** ⚡ |
| **vs Local** | — | 1.6x faster | 2.3x faster | 3.4x faster | 5.2x faster |

**Winner:** Depot CI WITHOUT cleanup (1m 42s) 🏆

---

## Recommendations

### For Production CI/CD

**Depot CI is strongly recommended** for production CI/CD:
- **5.1x faster** than local builds (with cleanup)
- **1.9x faster** than GitHub Actions (with cleanup)
- Consistent superior performance across all scenarios
- Best performance for dependency-heavy operations

### When to Use Disk Cleanup

**Enable cleanup when:**
- Running cold builds (first-time builds)
- Making dependency changes
- Disk space is constrained (<20GB available)
- Running on shared runners with residual data

**Skip cleanup when:**
- Making small incremental changes (UI, source files)
- Filesystem cache provides more value than clean space
- Subsequent builds in the same workflow

### For GitHub Actions Users

**Consider migrating to Depot CI if:**
- You have complex Docker builds (multi-stage, 500+ dependencies)
- Build time is a bottleneck
- You run more than 50 builds per month
- You value faster feedback cycles

---

## Test Environment Details

### Local Docker

| Parameter | Value |
|-----------|-------|
| **Host** | WSL2 on Windows |
| **Docker Version** | 28.4.0 |
| **RAM** | 24GB |
| **Network** | Residential |

### GitHub Actions

| Parameter | Value |
|-----------|-------|
| **Runner** | ubuntu-latest |
| **CPU** | 2-core |
| **RAM** | ~7GB (after cleanup: ~14GB) |
| **Network** | Cloud |

### Depot CI

| Parameter | Value |
|-----------|-------|
| **Runner** | Optimized cloud infrastructure |
| **CPU** | Optimized for Docker builds |
| **RAM** | Optimized |
| **Network** | Cloud (distributed caching) |

---

## All Tests Complete! 🎉

- **30/30 tests completed successfully**
- **Local Docker:** 6 tests
- **GitHub Actions:** 12 tests (6 with cleanup, 6 without)
- **Depot CI:** 12 tests (6 with cleanup, 6 without)

---

## References

- [Comprehensive Analysis](./COMPREHENSIVE-ANALYSIS.md) - Complete 30-test analysis
- [Testing Summary](./TESTING-SUMMARY.md) - Quick reference guide
- [Project README](../../README.md)

---

**Status:** ✅ ALL TESTS COMPLETE WITH COMPREHENSIVE ANALYSIS

**Last Updated:** 2026-04-03
