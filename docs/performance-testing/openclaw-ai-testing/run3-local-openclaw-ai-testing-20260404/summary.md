# Local Build Run 3 - OpenClaw Performance Test Summary

**Date:** 2026-04-04
**OpenClaw Commit:** `f0c970fb43` (fix: skip sandbox skill copy junk)
**Host:** WSL2 on Windows
**Docker:** 28.4.0
**Build System:** Local Docker Buildx (default builder)

---

## Results Overview

| # | Test Case | Description | Expected Cache | Build Time | Cache Hit | Status |
|---|-----------|-------------|---------------|------------|-----------|--------|
| 1 | baseline | Cold build (populates cache) | N/A (cold) | 15m 30s (930s) | 0/40 (0%) | PASS |
| 2 | test-2-docs | README comment | ~95% | 12m 0s (720s) | 15/40 (38%) | PASS |
| 3 | test-3-source | New file in src/ | ~75% | 11m 56s (716s) | 15/40 (38%) | PASS |
| 4 | test-4-ui | New UI component | ~50% | 9m 59s (599s) | 15/40 (38%) | PASS |
| 5 | test-5-dependency | Add left-pad dependency | ~25% | ~10m 57s (~657s) | 9/40 (23%) | PASS |
| 6 | test-6-major | Multi-file + dependency | ~10% | ~8m 46s (~526s) | 15/40 (38%) | PASS |

---

## Local vs GitHub Actions vs Depot Comparison

| Test Case | Local Docker | GitHub Actions | Depot CI | Local vs GHA | Local vs Depot | Depot vs GHA |
|-----------|-------------|----------------|----------|-------------|----------------|--------------|
| baseline (cold) | 15m 30s | 3m 44s | 2m 28s | 4.1x slower | 6.3x slower | 34% faster |
| test-2-docs | 12m 0s | 3m 56s | 3m 2s | 3.1x slower | 4.0x slower | 23% faster |
| test-3-source | 11m 56s | 3m 21s | 1m 53s | 3.6x slower | 6.3x slower | 44% faster |
| test-4-ui | 9m 59s | 3m 50s | 2m 31s | 2.6x slower | 4.0x slower | 34% faster |
| test-5-dependency | ~10m 57s | 3m 59s | 2m 13s | 2.7x slower | 4.9x slower | 44% faster |
| test-6-major | ~8m 46s | 3m 52s | 1m 55s | 2.3x slower | 4.6x slower | 50% faster |
| **Average** | **~11m 28s** | **~3m 47s** | **~2m 20s** | **3.0x slower** | **5.0x slower** | **38% faster** |

---

## Key Findings

### All 6 builds passed
Every test case completed successfully on local Docker with the `f0c970fb43` commit.

### Local builds are 3-6x slower than CI
The WSL2 environment is significantly slower than both GitHub Actions and Depot CI:
- **3.0x slower** than GitHub Actions on average
- **5.0x slower** than Depot CI on average

The biggest gap is the cold baseline: local took 15m 30s vs Depot's 2m 28s (6.3x slower).

### pnpm install dominates build time
`pnpm install` is consistently the longest single step at **188-246 seconds** per build. Despite Docker layer caching for other steps, pnpm re-downloads packages with zero reuse (`resolved 0, reused 0`) on every non-cached run. This accounts for 25-35% of total build time.

### Image export/unpack is the second bottleneck
Exporting and unpacking the image takes **131-273 seconds**, with the cold baseline worst at 273s. This is an I/O bottleneck on the local WSL2 filesystem.

### Cache differentiation matches expectations
Unlike GitHub Actions (where all builds clustered in a narrow range), local builds show real differentiation:
- **Baseline (cold):** 15m 30s -- no cache at all
- **Cached builds (tests 2-4, 6):** 8m 46s - 12m 0s -- 15 steps cached (38% hit rate)
- **Dependency change (test 5):** ~10m 57s -- only 9 steps cached (23% hit rate) due to lockfile invalidation

The `COPY . .` instruction is the cache boundary, same pattern seen on Depot CI.

### Network issues on local
Test 2 (docs) encountered two network warnings:
- `ECONNRESET` retry when downloading `@esbuild/freebsd-arm64` (recovered)
- Slow download warning for `@snazzah/davey-darwin-arm64` (below 50 KiB/s)

No errors on any other tests.

---

## Bottleneck Breakdown (Average Across Tests)

| Phase | Avg Time | % of Total |
|-------|----------|-----------|
| pnpm install | ~212s | 31% |
| Image export/unpack | ~193s | 28% |
| Build compilation steps | ~75s | 11% |
| Base image + setup | ~60s | 9% |
| Other (copy, assembly) | ~146s | 21% |

---

## Architecture Notes

- **Builder:** Local Docker Buildx default instance (no remote builders)
- **CPU:** WSL2 allocated cores (shared with Windows host)
- **Storage:** WSL2 virtual disk (not NVMe)
- **Cache:** Docker BuildKit local layer cache
- **Network:** Through Windows host networking stack
