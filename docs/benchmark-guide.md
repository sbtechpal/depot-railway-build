# Benchmark Guide: Flows 1, 2, and 3

This guide explains how to benchmark the first three deployment flows to establish baseline performance metrics before implementing Depot CI.

---

## Overview

This benchmark measures **Flows 1, 2, and 3** without Depot CI:

| Flow | Process | What Gets Measured |
|------|---------|-------------------|
| **Flow 1** | Local Build → Railway Deploy | Local build time + deploy time |
| **Flow 2** | Git Push → Railway Auto-Build | End-to-end Railway build time |
| **Flow 3** | GitHub Actions → Railway | Simulated CI workflow time |

**Flow 4 (Depot CI)** is measured later when you have a Depot account.

---

## Prerequisites

### Required

- Node.js 18+ and npm
- Docker (for Flow 1)
- Git
- Bash shell (or compatible terminal)

### Optional (for Flow 3)
- Railway CLI (`npm install -g @railway/cli`)

### For Flow 2 Full Benchmark
- Railway project with autobuild enabled
- Railway credits available (~$0.05 per build)

---

## Quick Start

```bash
# Make script executable
chmod +x scripts/benchmark-flows.sh

# Run all benchmarks
./scripts/benchmark-flows.sh
```

The script will:
1. Benchmark Flow 1 (3 iterations)
2. Ask if you want to run Flow 2 (costs credits)
3. Benchmark Flow 3 (3 iterations)
4. Save all results to CSV file

---

## Understanding Each Flow

### Flow 1: Local Build → Railway Deploy

**What it does:**
```
1. Clean previous build
2. npm install (dependencies)
3. npm run build (TypeScript)
4. docker build
5. Measure total time
```

**What you'll see:**
```
Iteration 1/3
  Dependencies: 45s
  TypeScript: 28s
  Docker build: 95s
  Flow 1 Total: 168s
```

**Use this for:** Quick local iteration, debugging

---

### Flow 2: Git Push → Railway Auto-Build

**What it does:**
```
1. Make trivial change
2. Commit to git
3. Push to GitHub
4. Railway detects push and builds
5. You record time from Railway dashboard
```

**⚠️ WARNING**: This consumes Railway credits!

**Cost per build:** ~$0.05
**100 builds:** ~$5 (entire monthly credit)

**What you'll need to do:**
- Watch Railway dashboard during build
- Note the total build time
- The script will estimate 180s (3 minutes)

**Expected timing:**
- Queue: 0-30s
- Dependencies: 45-90s
- Build: 90-180s
- Deploy: 20-40s
- **Total: 180-300s**

**Use this for:** Zero config, low deployment frequency

---

### Flow 3: GitHub Actions → Railway (Simulated)

**What it does:**
```
1. Checkout (simulated)
2. Setup Node (simulated)
3. npm ci (dependencies)
4. Run tests
5. Build application
6. Deploy to Railway (if CLI configured)
```

**What you'll see:**
```
Iteration 1/3
  Checkout: 2s
  Setup: 1s
  Dependencies: 47s
  Tests: 22s
  Build: 31s
  Deploy: 5s
  Flow 3 Total: 108s
```

**Use this for:** Teams needing CI, build history

---

## Results Output

### CSV File Format

Results are saved to: `benchmarks/results/benchmark_YYYYMMDD_HHMMSS.csv`

```csv
flow,iteration,stage,duration,timestamp
flow1,1,dependencies,45,1712345678
flow1,1,typescript,28,1712345723
flow1,1,docker,95,1712345818
flow1,1,total,168,1712345818
...
```

### Interpreting Results

**Flow 1 (Local → Railway)**
- Fastest option for individuals
- Uses your machine's compute
- No cloud costs

**Flow 2 (Railway Auto-Build)**
- Most convenient
- Most expensive (uses Railway credits)
- Slowest option

**Flow 3 (GitHub Actions → Railway)**
- Good balance for teams
- Free CI minutes
- Better than Flow 2 for cost

---

## Expected Baseline Results

### Timing Comparison

| Flow | Dependencies | TypeScript | Docker | Deploy | **Total** |
|------|-------------|------------|--------|--------|-----------|
| **Flow 1** | 30-60s | 15-30s | 60-120s | 20-40s | **125-250s** |
| **Flow 2** | 45-90s | 30-45s | 90-180s | 20-40s | **185-355s** |
| **Flow 3** | 45-60s | 20-30s | 60-120s | 20-40s | **145-250s** |

### Cost Comparison

| Flow | Compute Cost | Monthly (100 builds) |
|------|--------------|---------------------|
| **Flow 1** | $0.00 | $0 |
| **Flow 2** | ~$0.05 | ~$5 |
| **Flow 3** | $0.00 + ~$0.01 | ~$1 |

---

## Adding Depot CI Later

When you get a Depot account:

1. **Sign up** at [depot.dev](https://depot.dev)
2. **Install CLI**: `curl -L https://depot.dev/install.sh | sh`
3. **Configure**: `depot login`
4. **Re-run benchmark**: `./scripts/benchmark-flows.sh`

The script will automatically benchmark Flow 4 and compare against your existing baselines.

### Expected Depot CI Results

| Stage | Flow 1-3 Avg | Depot CI | Speedup |
|-------|--------------|----------|---------|
| Dependencies | 45-60s | ~5s | **9-12x** |
| TypeScript | 20-30s | ~3s | **7-10x** |
| Docker | 60-120s | ~8s | **8-15x** |
| **Total** | **145-355s** | **~30s** | **5-12x** |

---

## Running Individual Flows

If you only want to benchmark specific flows:

### Flow 1 Only
```bash
cd sample-app
rm -rf node_modules dist
time npm install
time npm run build
time docker build -t openclaw-demo .
```

### Flow 2 Only
```bash
cd sample-app
echo "// benchmark" >> src/benchmark.ts
git add benchmark.ts
git commit -m "benchmark" --quiet
git push origin main
# Check Railway dashboard for time
```

### Flow 3 Only
```bash
cd sample-app
rm -rf node_modules dist
time npm ci
time npm run build
# railway up (if configured)
```

---

## Troubleshooting

### Flow 1 Issues

**Problem**: Docker build fails
```bash
# Ensure Docker is running
docker ps

# Build with no cache to see errors
docker build --no-cache -t openclaw-demo .
```

**Problem**: npm install is slow
```bash
# Clear npm cache
npm cache clean --force

# Try different registry
npm install --registry=https://registry.npmjs.org
```

### Flow 2 Issues

**Problem**: No build triggered
- Check Railway autobuild is enabled
- Check GitHub is connected to Railway
- Check branch matches autobuild settings

**Problem**: Build is stuck
- Check Railway status page
- Check build logs in Railway dashboard

### Flow 3 Issues

**Problem**: Tests fail
```bash
# Run tests with output
npm test

# Tests may just return "completed" in this demo
```

**Problem**: Railway deploy fails
```bash
# Install Railway CLI
npm install -g @railway/cli

# Check configuration
railway status
```

---

## Recording Manual Measurements

For the most accurate results, you can manually record timings:

### Manual Flow 2 Measurement

1. Open Railway dashboard
2. Trigger a build (push code)
3. Start timer when build begins
4. Stop timer when build completes
5. Record time: `flow2,manual,total,<seconds>,<timestamp>`

### Manual Flow 3 Measurement

1. Go to GitHub Actions
2. Trigger workflow
3. Note start time from workflow run
4. Note completion time
5. Record time: `flow3,manual,total,<seconds>,<timestamp>`

---

## Next Steps

After running benchmarks:

1. ✅ **Review results** in CSV file
2. ⏳ **Document findings** (see template below)
3. ⏳ **Get Depot account** for Flow 4
4. ⏳ **Re-run benchmarks** with Flow 4
5. ⏳ **Compare Depot CI** vs baselines

---

## See Also

- **[comparison-summary.md](./performance-testing/comparison-summary.md)** — Complete performance test results
- [performance-test-guide.md](./performance-test-guide.md) — How to run all flows
- [test-case-instructions.md](./performance-testing/test-case-instructions.md) — Progressive test scenarios

---

> **Note:** The benchmarks directory has been removed as comprehensive performance testing has been completed. All results are documented in `comparison-summary.md` with real test data from March 31 - April 2, 2026.
