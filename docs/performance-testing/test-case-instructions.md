# Docker Build Performance Test Cases - Step-by-Step Guide

Complete instructions for running each test case individually for all 4 flows.

---

## Quick Start: Using Workflow Dropdowns ⚡

**Flows 3 & 4 (GitHub Actions & Depot CI) now have built-in test case selection!**

### How It Works

```
┌─────────────────────────────────────────────────────────────┐
│  GitHub Actions Workflow UI                                 │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  Run workflow ▼                                             │
│  ┌──────────────────────────────────────┐                  │
│  │ Use workflow from:                  │                  │
│  │ Branch: main                    ▼   │                  │
│  │                                     │                  │
│  │ Performance Test Case ▼            │  ← Select here!   │
│  │ ┌───────────────────────────────┐  │                  │
│  │ │ • baseline                     │  │                  │
│  │ │ • test-2-comment               │  │                  │
│  │ │ • test-3-function             │  │                  │
│  │ │ • test-4-dependency            │  │                  │
│  │ │ • test-5-major                 │  │                  │
│  │ └───────────────────────────────┘  │                  │
│  │                                     │                  │
│  │ [ Run workflow ]                   │                  │
│  └──────────────────────────────────────┘                  │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

### Flow 3: GitHub Actions → Railway

1. Go to: https://github.com/bytechie/depot-railway-build/actions/workflows/railway-direct.yml
2. Click **"Run workflow"**
3. Select test case from dropdown
4. Click **"Run workflow"**

### Flow 4: Depot CI → Railway

1. Go to: https://github.com/bytechie/depot-railway-build/actions/workflows/depot-ci.yml
2. Click **"Run workflow"**
3. Select test case from dropdown
4. Click **"Run workflow"**

**The workflow automatically:**
- ✅ Applies the test case changes
- ✅ Displays expected cache hit percentage
- ✅ Shows timing for each build step
- ✅ Deploys to Railway

---

## Preparation

**Before starting, ensure you have:**
1. Clean git state: `git status` shows no uncommitted changes
2. Access to GitHub Actions (for Flows 3 & 4)
3. Railway CLI installed (for Flows 1 & 3)
4. Docker running locally (for Flow 1)

**To reset between tests:**
```bash
# Discard test changes
git checkout sample-app/package.json
git checkout sample-app/package-lock.json
git checkout sample-app/src/
rm -f sample-app/src/utils.ts
rm -f sample-app/src/database.ts
rm -f sample-app/src/cache.ts
rm -f sample-app/.eslintrc.js
```

---

## Flow 1: Local → Railway

### Test Case 1: Baseline (No Changes)

**Purpose:** Measure fully cached build

```bash
cd sample-app
time docker build -t openclaw-demo:test .
```

**Record:** `___ seconds`

---

### Test Case 2: Comment Change

**Purpose:** Minimal source change

```bash
# Apply test case
./scripts/apply-test-case-2.sh

# Build and measure
cd sample-app
time docker build -t openclaw-demo:test .
```

**Record:** `___ seconds`

---

### Test Case 3: New Function

**Purpose:** Small code addition

```bash
# Apply test case
./scripts/apply-test-case-3.sh

# Build and measure
cd sample-app
time docker build -t openclaw-demo:test .
```

**Record:** `___ seconds`

---

### Test Case 4: New Dependency

**Purpose:** Package.json change

```bash
# Apply test case
./scripts/apply-test-case-4.sh

# Build and measure
cd sample-app
time docker build -t openclaw-demo:test .
```

**Record:** `___ seconds`

---

### Test Case 5: Major Changes

**Purpose:** Significant changes

```bash
# Apply test case
./scripts/apply-test-case-5.sh

# Build and measure
cd sample-app
time docker build -t openclaw-demo:test .
```

**Record:** `___ seconds`

---

## Flow 2: Commit → Railway (Auto-Build)

### Test Case 1: Baseline (No Changes)

**Purpose:** Already measured - Railway rebuild with cache

**Reference:** `docs/performance-testing/railway-build-results.md`
- Initial build: 29.06 seconds
- Cached rebuild: 3.81 seconds

---

### Test Case 2: Comment Change

**Purpose:** Minimal source change on Railway

```bash
# Apply test case
./scripts/apply-test-case-2.sh

# Commit and push
git add sample-app/src/index.ts
git commit -m "Test Case 2: Comment change"
git push
```

**Watch Railway build:**
1. Go to Railway dashboard
2. Watch the build progress
3. Record the build time from logs

**Record:** `___ seconds`

---

### Test Case 3: New Function

**Purpose:** Small code addition on Railway

```bash
# Apply test case
./scripts/apply-test-case-3.sh

# Commit and push
git add sample-app/
git commit -m "Test Case 3: New function"
git push
```

**Watch Railway build:**
1. Go to Railway dashboard
2. Watch the build progress
3. Record the build time from logs

**Record:** `___ seconds`

---

### Test Case 4: New Dependency

**Purpose:** Package.json change on Railway

```bash
# Apply test case
./scripts/apply-test-case-4.sh

# Commit and push
git add sample-app/
git commit -m "Test Case 4: New dependency"
git push
```

**Watch Railway build:**
1. Go to Railway dashboard
2. Watch the build progress
3. Record the build time from logs

**Record:** `___ seconds`

---

### Test Case 5: Major Changes

**Purpose:** Significant changes on Railway

```bash
# Apply test case
./scripts/apply-test-case-5.sh

# Commit and push
git add sample-app/
git commit -m "Test Case 5: Major changes"
git push
```

**Watch Railway build:**
1. Go to Railway dashboard
2. Watch the build progress
3. Record the build time from logs

**Record:** `___ seconds`

---

## Flow 3: GitHub Actions → Railway

### Using the Test Case Dropdown ⚡

**All test cases are now available as dropdown options!**

**Steps for any test case:**
1. Go to: https://github.com/bytechie/depot-railway-build/actions/workflows/railway-direct.yml
2. Click **"Run workflow"**
3. Select test case from dropdown:
   - `baseline` - No changes
   - `test-2-comment` - Comment change
   - `test-3-function` - New function
   - `test-4-dependency` - New dependency
   - `test-5-major` - Major changes
4. Click **"Run workflow"**
5. Watch the progress
6. Record total workflow time from logs

**The workflow automatically:**
- Applies the test case changes
- Displays expected cache hit
- Builds and deploys
- Shows timing for each step

---

## Flow 4: Depot CI → Railway

### Using the Test Case Dropdown ⚡

**All test cases are now available as dropdown options!**

**Steps for any test case:**
1. Go to: https://github.com/bytechie/depot-railway-build/actions/workflows/depot-ci.yml
2. Click **"Run workflow"**
3. Select test case from dropdown:
   - `baseline` - No changes
   - `test-2-comment` - Comment change
   - `test-3-function` - New function
   - `test-4-dependency` - New dependency
   - `test-5-major` - Major changes
4. Click **"Run workflow"**
5. Watch the progress
6. Record total workflow time from logs

**The workflow automatically:**
- Applies the test case changes
- Displays expected cache hit
- Builds with Depot CI
- Shows timing for each step

---

## Results Template

Copy and fill in this template after completing all tests:

```
Docker Build Performance Test Results
=====================================

Flow 1: Local → Railway
Test 1 (Baseline):     ___ seconds (100% cache)
Test 2 (Comment):      ___ seconds (~80% cache)
Test 3 (Function):     ___ seconds (~60% cache)
Test 4 (Dependency):   ___ seconds (~40% cache)
Test 5 (Major):        ___ seconds (~10% cache)

Flow 2: Railway Auto-Build
Test 1 (Baseline):     3.81 seconds (cached)
Test 2 (Comment):      ___ seconds
Test 3 (Function):     ___ seconds
Test 4 (Dependency):   ___ seconds
Test 5 (Major):        ___ seconds

Flow 3: GitHub Actions
Test 1 (Baseline):     ___ seconds (100% cache)
Test 2 (Comment):      ___ seconds
Test 3 (Function):     ___ seconds
Test 4 (Dependency):   ___ seconds
Test 5 (Major):        ___ seconds

Flow 4: Depot CI
Test 1 (Baseline):     ___ seconds (100% cache)
Test 2 (Comment):      ___ seconds
Test 3 (Function):     ___ seconds
Test 4 (Dependency):   ___ seconds
Test 5 (Major):        ___ seconds
```

---

## Reset Between Tests

**Quick reset command:**
```bash
git checkout sample-app/package.json \
            sample-app/package-lock.json \
            sample-app/src/ && \
rm -f sample-app/src/utils.ts \
     sample-app/src/database.ts \
     sample-app/src/cache.ts \
     sample-app/.eslintrc.js
```

**Or reset everything:**
```bash
git reset --hard HEAD
git clean -fd sample-app/
```

---

## Tips

1. **Run each test 2-3 times** - First run after reset may be slower
2. **Record exact times** - Use the time shown in workflow logs
3. **Note cache behavior** - Check which layers were rebuilt
4. **Compare across flows** - Same test case across all 4 flows shows true difference
5. **Document environment** - Note your machine specs for local builds
6. **Use dropdowns for Flows 3 & 4** - Much easier than manual script running!

## Workflow Test Case Quick Reference

| Flow | How to Select Test Case |
|------|------------------------|
| **Flow 1: Local** | Run `./scripts/apply-test-case-N.sh` manually |
| **Flow 2: Railway** | Run script, then `git push` |
| **Flow 3: GitHub Actions** | Use dropdown in workflow UI ⚡ |
| **Flow 4: Depot CI** | Use dropdown in workflow UI ⚡ |

---

## Quick Reference

| Command | Purpose |
|---------|---------|
| `./scripts/apply-test-case-2.sh` | Apply comment change |
| `./scripts/apply-test-case-3.sh` | Apply new function |
| `./scripts/apply-test-case-4.sh` | Apply new dependency |
| `./scripts/apply-test-case-5.sh` | Apply major changes |
| `git reset --hard HEAD` | Reset all changes |
| `docker build -t test .` | Local build test |
| `time <command>` | Measure execution time |
