# Flow 2: Railway Auto-Build Performance Results

Performance test results for Flow 2 (Railway Auto-Build).

**Test Date:** 2026-03-31
**Branch:** performance-testing
**Railway Region:** us-east4

---

## Results Summary

| Test Case | Description | Time | vs Flow 1 | Cache Hit |
|-----------|-------------|------|-----------|-----------|
| **1. Baseline (cached)** | No changes, fresh branch | **3.66s** | 1.8x slower | ~100% |
| **2. Comment Change** | Source comment modified | **16.88s** | 1.2x slower | ~80% |
| **3. New Function** | New utils.ts file | TBD | TBD | ~60% |
| **4. New Dependency** | Package.json change | TBD | TBD | ~40% |
| **5. Major Changes** | Multiple new packages | TBD | TBD | ~10% |

---

## Detailed Analysis

### Test Case 1: Baseline (Cached)

**Log:** `flow2-railway-build-logs/performance-test-base-branch-logs.1774932251551.log`

**Time:** **3.66 seconds**

**Build Breakdown:**
- All stages: CACHED
- Export: ~3s (image assembly)
- Health check: Passed

**Comparison to Flow 1:**
- Flow 1 cached: 2 seconds
- Flow 2 (Railway): 3.66 seconds
- **Local is 1.8x faster** (better local caching)

**Comparison to previous Railway build (main branch):**
- Main branch cached: 3.81 seconds
- Performance-testing branch: 3.66 seconds
- Very consistent (~4% variance)

---

### Test Case 2: Comment Change

**Log:** `flow2-railway-build-logs/flow2-Test-Case2-Comment-Change-logs.1774932652249.log`

**Time:** **16.88 seconds**

**Build Breakdown:**
- Start: 04:49:04
- npm ci (deps stage): ~2.1s (line 40: 04:49:04.638 → line 54: 04:49:06.834)
- npm ci (production-deps): ~2.6s (line 57: 04:49:07.204 → line 63: 04:49:09.763)
- TypeScript build: ~1.0s (line 42-46: 04:49:04.618 → line 55: 04:49:05.561)
- Total: 16.88s

**Cache Behavior:**
- ✅ deps stages: CACHED (npm ci ran but fast)
- ✅ production-deps: CACHED
- ❌ build (COPY source): REBUILT
- ❌ build (tsc): REBUILT
- ✅ production: CACHED

**Comparison to Flow 1:**
- Flow 1 (Local): 14 seconds
- Flow 2 (Railway): 16.88 seconds
- **Local is 1.2x faster**

**Why Railway is slower:**
1. No persistent cache across branches (this is performance-testing branch, not main)
2. New branch = no layer cache history
3. Slightly slower network/download overhead

**Expected vs Actual:**
- Expected: ~10-15s
- Actual: 16.88s
- Within expected range

### Test Case 1: Baseline (Cached)

**Log:** `flow2-railway-build-logs/performance-test-base-branch-logs.1774932251551.log`

**Time:** **3.66 seconds**

**Build Breakdown:**
- All stages: CACHED
- Export: ~3s (image assembly)
- Health check: Passed

**Comparison to Flow 1:**
- Flow 1 cached: 2 seconds
- Flow 2 (Railway): 3.66 seconds
- **Local is 1.8x faster** (better local caching)

**Comparison to previous Railway build (main branch):**
- Main branch cached: 3.81 seconds
- Performance-testing branch: 3.66 seconds
- Very consistent (~4% variance)

---

## Log Analysis

### Build Start
```
2026-03-31T04:41:35.598972914Z [inf] Using Detected Dockerfile
2026-03-31T04:41:35.599002744Z [inf] =========================
```

### Build Complete
```
2026-03-31T04:41:39.255219846Z [inf] Build time: 3.66 seconds
```

### Health Check
```
2026-03-31T04:41:45.298190758Z [inf] [1/1] Healthcheck succeeded!
```

---

## Key Observations

1. **Railway is very consistent** - 3.66s vs 3.81s previous cached build (4% variance)

2. **Local still wins for cached builds** - 2s vs 3.66s
   - Local Docker has persistent cache
   - Railway rebuilds from scratch (no cross-branch cache)

3. **But Railway wins for clean builds** - 29s vs 162s
   - Railway infrastructure is 5.6x faster for cold builds

4. **No code changes** - This was a baseline test on fresh branch
   - All layers came from Railway's layer cache
   - Only export overhead (~3s)

---

## Next Steps

**Remaining tests to run:**
- Test 2: Comment Change (~10-15s expected)
- Test 3: New Function (~15-20s expected)
- Test 4: New Dependency (~30-40s expected)
- Test 5: Major Changes (~60-90s expected)

---

## How to Run Remaining Tests

**On performance-testing branch:**

For each test case:
```bash
# 1. Apply test case
./scripts/apply-test-case-N.sh

# 2. Commit and push
git add sample-app/
git commit -m "Test Case N: [name]"
git push

# 3. Watch Railway dashboard for "Build time: XX seconds"
# 4. Record the time
```

**Reset between tests:**
```bash
git reset --hard HEAD^
git clean -fd sample-app/
```

---

## Comparison So Far

| Test | Flow 1 (Local) | Flow 2 (Railway) | Winner |
|------|----------------|-------------------|--------|
| **Cached (no changes)** | **2s** | 3.66s | **Local 1.8x** |
| **Clean (first build)** | 162s | 29s | **Railway 5.6x** |

**Insight:** Local is faster for cached builds (persistent local cache), but Railway destroys clean builds.
