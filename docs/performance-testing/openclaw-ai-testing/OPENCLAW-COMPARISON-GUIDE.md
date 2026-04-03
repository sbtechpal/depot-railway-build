# OpenClaw Performance Comparison Guide

## Overview

This guide explains how to run performance comparison tests between Local Docker, GitHub Actions, and Depot CI for the OpenClaw AI application.

## Test Status

| Environment | Status | Date |
|-------------|--------|------|
| **Local Docker** | ✅ Complete | 2026-04-02 |
| **GitHub Actions** | ⏳ Pending | TBD |
| **Depot CI** | ⏳ Pending | TBD |

## Local Results (Baseline)

| Test | Time | vs Baseline |
|------|------|-------------|
| **Baseline** | 13m 14s | — |
| **Documentation** | 10m 7s | 23% faster |
| **Source File** | 8m 58s | 32% faster |
| **UI Component** | 9m 23s | 29% faster |
| **New Dependency** | 9m 53s | 25% faster |
| **Major Changes** | 8m 52s | 33% faster |

**Average:** 10m 4s per build

## Running GitHub Actions Tests

### 1. Navigate to GitHub Actions

```
https://github.com/YOUR_USERNAME/depot-railway-build/actions
```

### 2. Select Workflow

Choose: **"GitHub Actions Baseline - OpenClaw Performance Test"**

### 3. Run Test Cases

For each test case (run sequentially):

1. Click "Run workflow"
2. Select test case from dropdown:
   - `baseline` - Cold build, no cache
   - `test-2-docs` - README comment
   - `test-3-source` - New source file
   - `test-4-ui` - New UI component
   - `test-5-dependency` - New dependency
   - `test-6-major` - Multiple changes
3. Click "Run workflow"
4. Wait for completion (~10-20 minutes each)
5. Record the build time from the logs

### 4. Record Results

Add times to the comparison table below.

## Running Depot CI Tests

### Prerequisites

Ensure these secrets are configured in your GitHub repository:

| Secret | Description | Required |
|--------|-------------|----------|
| `DEPOT_TOKEN` | Depot API token | ✅ Yes |
| `DEPOT_PROJECT_ID` | Your Depot project ID | ✅ Yes |

### 1. Navigate to GitHub Actions

```
https://github.com/YOUR_USERNAME/depot-railway-build/actions
```

### 2. Select Workflow

Choose: **"Depot CI - OpenClaw Performance Test"**

### 3. Run Test Cases

For each test case (run sequentially):

1. Click "Run workflow"
2. Select test case from dropdown (same as GitHub Actions)
3. Click "Run workflow"
4. Wait for completion (~3-6 minutes each)
5. Record the build time from the logs

### 4. Record Results

Add times to the comparison table below.

## Comparison Results Template

### Complete Results Table

| Test | Local Docker | GitHub Actions | Depot CI | GHA vs Local | Depot vs Local | Depot vs GHA |
|------|--------------|----------------|----------|--------------|----------------|--------------|
| **Baseline** | 13m 14s | | | | | |
| **Documentation** | 10m 7s | | | | | |
| **Source File** | 8m 58s | | | | | |
| **UI Component** | 9m 23s | | | | | |
| **New Dependency** | 9m 53s | | | | | |
| **Major Changes** | 8m 52s | | | | | |

### Speedup Summary

| Comparison | Average Speedup | Best Case | Worst Case |
|------------|-----------------|-----------|------------|
| **GitHub Actions vs Local** | | | |
| **Depot CI vs Local** | | | |
| **Depot CI vs GitHub Actions** | | | |

## Expected Results

Based on Depot CI's capabilities:

| Test | Local | Expected GHA | Expected Depot | Depot vs Local |
|------|-------|--------------|----------------|----------------|
| Baseline | 13m 14s | 10-15m | 2-3m | **4-6x faster** |
| Docs | 10m 7s | 8-12m | 2-3m | **3-5x faster** |
| Source | 8m 58s | 7-10m | 2-3m | **3-4x faster** |
| UI | 9m 23s | 7-10m | 2-3m | **3-4x faster** |
| Dependency | 9m 53s | 8-12m | 2-3m | **3-4x faster** |
| Major | 8m 52s | 7-10m | 2-3m | **3-4x faster** |

## Why Depot CI Should Be Faster

### 1. Optimized Infrastructure
- **Dedicated build runners** vs shared GitHub Actions runners
- **High-performance networking** for faster dependency downloads
- **Optimized Docker BuildKit** configuration

### 2. Intelligent Caching
- **Distributed cache** across builds and projects
- **Layer-aware caching** that understands Dockerfile structure
- **Predictive caching** for common patterns

### 3. Parallel Processing
- **Multi-stage parallel execution** where possible
- **Optimized dependency resolution**
- **Background layer preparation**

## Troubleshooting

### GitHub Actions Issues

**Problem:** Build fails with timeout
**Solution:** Increase `timeout-minutes` in workflow

**Problem:** pnpm install fails
**Solution:** Ensure pnpm action-setup is configured correctly

### Depot CI Issues

**Problem:** "DEPOT_TOKEN not found"
**Solution:** Add DEPOT_TOKEN to GitHub secrets

**Problem:** "DEPOT_PROJECT_ID not found"
**Solution:** Add DEPOT_PROJECT_ID to GitHub secrets

**Problem:** Build fails with auth error
**Solution:** Verify Depot token is valid and has correct permissions

## Next Steps

1. **Complete GitHub Actions tests** - Run all 6 test cases
2. **Complete Depot CI tests** - Run all 6 test cases
3. **Fill in comparison table** - Add actual results
4. **Analyze results** - Compare expected vs actual
5. **Document findings** - Create final report

## Files to Update

After testing, update these files:

1. **`comparison-summary.md`** - Final comparison results
2. **`STATUS.md`** - Update completion status
3. **`openclaw-ai-performance-testing.md`** - Overall documentation

## Questions?

Refer to:
- [Depot Documentation](https://depot.dev/docs)
- [GitHub Actions Documentation](https://docs.github.com/en/actions)
- [Project README](../../README.md)
