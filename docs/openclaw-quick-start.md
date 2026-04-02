# OpenClaw Performance Testing - Quick Start

## Overview

Test Depot CI against the **actual OpenClaw application** - a production-grade AI assistant with 500+ dependencies and a complex multi-stage build.

## What You'll Need

| Item | Where to Get |
|------|--------------|
| Depot Account | [depot.dev](https://depot.dev) (free during beta) |
| Depot Token | depot.dev/settings/tokens |
| Depot Project ID | depot.dev/dashboard |
| GitHub Repository | This repo or your fork |

## Setup (2 Minutes)

### Step 1: Configure GitHub Secrets

Go to: **Settings → Secrets and variables → Actions**

Add these secrets:

| Secret Name | Value |
|-------------|-------|
| `DEPOT_TOKEN` | Your Depot API token |
| `DEPOT_PROJECT_ID` | Your Depot project ID |

### Step 2: Copy Workflows (Optional)

The workflows are in `.github/workflows-openclaw/`. To use them:

```bash
# Copy to active workflows directory
cp .github/workflows-openclaw/*.yml .github/workflows/

# Commit and push
git add .github/workflows/
git commit -m "Enable OpenClaw performance workflows"
git push
```

## Running Tests

### Option A: GitHub Actions Baseline

1. Go to **Actions** → **GitHub Actions Baseline - OpenClaw**
2. Click **Run workflow**
3. Select test case from dropdown:
   - `baseline` - No changes (fully cached)
   - `test-2-comment` - Comment change
   - `test-3-function` - New source file
   - `test-4-dependency` - New npm package
   - `test-5-major` - Multiple changes
4. Click **Run workflow**
5. Wait for completion (3-15 minutes)
6. Note the total time from workflow run

### Option B: Depot CI

1. Go to **Actions** → **Depot CI - OpenClaw**
2. Click **Run workflow**
3. Select the same test case
4. Click **Run workflow**
5. Wait for completion (30-180 seconds)
6. Note the total time

## Expected Results

| Test Case | GitHub Actions | Depot CI | Speedup |
|-----------|----------------|----------|---------|
| Baseline | 3-5 min | 30-45s | **4-7x** |
| Comment | 3-5 min | 35-50s | **4-7x** |
| Function | 4-6 min | 45-60s | **4-7x** |
| Dependency | 6-10 min | 60-90s | **5-8x** |
| Major | 8-15 min | 2-3 min | **3-5x** |

## Why OpenClaw?

OpenClaw is a **real-world application** with:

- **13,301-line** pnpm-lock.yaml
- **Multi-stage** Docker build (265 lines)
- **Bun + pnpm** dual build system
- **50+ source** directories
- **Extension system** for plugins

This complexity makes it perfect for demonstrating Depot CI's advantages.

## Recording Your Results

```
OpenClaw Performance Test Results
==================================

Baseline (100% cache):
  GitHub Actions: ___ minutes ___ seconds
  Depot CI:       ___ minutes ___ seconds
  Speedup:        ___x

Comment (~90% cache):
  GitHub Actions: ___ minutes ___ seconds
  Depot CI:       ___ minutes ___ seconds
  Speedup:        ___x

Function (~70% cache):
  GitHub Actions: ___ minutes ___ seconds
  Depot CI:       ___ minutes ___ seconds
  Speedup:        ___x

Dependency (~30% cache):
  GitHub Actions: ___ minutes ___ seconds
  Depot CI:       ___ minutes ___ seconds
  Speedup:        ___x

Major (~10% cache):
  GitHub Actions: ___ minutes ___ seconds
  Depot CI:       ___ minutes ___ seconds
  Speedup:        ___x

Average Speedup: ___x
```

## Troubleshooting

**Q: Workflow fails with "project not found"**
A: Verify `DEPOT_PROJECT_ID` is correct in secrets

**Q: First run is slow**
A: First builds warm the cache - run baseline twice

**Q: pnpm install fails**
A: OpenClaw uses pnpm 9.x - the workflow handles this

## Next Steps

1. Run all 5 test cases
2. Record your results
3. Calculate average speedup
4. Share findings with team

**Full Guide:** [openclaw-performance-guide.md](./openclaw-performance-guide.md)
