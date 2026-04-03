# OpenClaw Local Performance Test Results

**Test Date:** 2026-04-02 22:59:50 - 2026-04-03 00:00:10
**Total Testing Time:** ~61 minutes

## Test Environment

- **Host:** WSL2 on Windows
- **Docker Version:** Docker version 28.4.0, build d8eb465
- **OpenClaw Commit:** 75b5a4c713
- **Test Type:** Local Docker Build (GitHub Actions baseline comparison)

## Test Cases

| Test | Description | Expected Cache |
|------|-------------|----------------|
| **Baseline** | No changes (cold build) | 100% |
| **Documentation** | README comment | 95% |
| **Source File** | New perf-test.ts in src/ | 75% |
| **UI Component** | New component in ui/ | 50% |
| **New Dependency** | Add @types/node dependency | 25% |
| **Major Changes** | Multiple changes | 10% |

## Results Summary

| Test Case | Time | vs Baseline | Notes |
|-----------|------|-------------|-------|
| **Baseline** | 13m 14s | — | Cold build, no cache |
| **Documentation** | 10m 7s | 23% faster | README comment only |
| **Source File** | 8m 58s | 32% faster | New source file |
| **UI Component** | 9m 23s | 29% faster | New UI component |
| **New Dependency** | 9m 53s | 25% faster | Added dependency |
| **Major Changes** | 8m 52s | 33% faster | Multiple changes |

### Statistics

- **Average build time:** 10m 4s
- **Fastest build:** 8m 52s (Major Changes)
- **Slowest build:** 13m 14s (Baseline)
- **Time range:** 8m 52s - 13m 14s

### Key Findings

1. **Cold build penalty:** Baseline took 13m 14s with no cache
2. **Layer caching benefit:** Subsequent builds were 23-33% faster
3. **Major Changes fastest:** Unexpectedly fastest due to aggressive Docker layer caching
4. **Consistent performance:** All non-baseline builds within 1m range (8m 52s - 10m 7s)

## Log Files

Detailed logs for each test case:
- `baseline.log` (66KB)
- `test-2-docs.log` (23KB)
- `test-3-source.log` (22KB)
- `test-4-ui.log` (23KB)
- `test-5-dependency.log` (23KB)
- `test-6-major.log` (23KB)

## Build Stage Analysis

Based on the logs, each build consists of:

| Stage | Approximate Time |
|-------|------------------|
| Pull base Node image | 45-60s |
| Install system packages | 30-45s |
| pnpm install (all deps) | 90-100s |
| Copy source files | 5-10s |
| TypeScript build | 120-180s |
| pnpm prune --prod | 140-180s |
| Copy production artifacts | 50-60s |
| Export image | 150-210s |

## Notes

- These tests represent **local Docker build** times
- GitHub Actions times may vary due to:
  - Runner performance differences
  - Network conditions
  - Cache state
  - Concurrent workflows

- Depot CI is expected to be **4-8x faster** than these local baseline times.

## Comparison with Depot CI

Once Depot CI tests are run, compare:

| Test | Local Docker | Depot CI (Expected) | Expected Speedup |
|------|--------------|---------------------|------------------|
| Baseline | 13m 14s | 2-3m | 4-6x faster |
| Docs | 10m 7s | 2-3m | 3-5x faster |
| Source | 8m 58s | 2-3m | 3-4x faster |
| UI | 9m 23s | 2-3m | 3-4x faster |
| Dependency | 9m 53s | 2-3m | 3-4x faster |
| Major | 8m 52s | 2-3m | 3-4x faster |

**Next Steps:**
1. Run same test cases on GitHub Actions
2. Run same test cases on Depot CI
3. Compare actual vs expected performance
4. Document final comparison
