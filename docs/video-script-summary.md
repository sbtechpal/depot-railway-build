# Depot CI vs GitHub Actions: Video Script Flow Diagram

```text
═══════════════════════════════════════════════════════════════════════════════════════
                    DEPOT CI vs GITHUB ACTIONS VIDEO FLOW
═══════════════════════════════════════════════════════════════════════════════════════

+-----------------------------------------------------------------------------+
|  SECTION 1: THE PROBLEM (0:00 - 0:45)                                        |
+-----------------------------------------------------------------------------+

   "Your CI is slowing you down..."
                |
                v
   +-----------------------------------------+
   | The Reality                             |
   | * AI coding = fast                     |
   | * CI builds = slow (minutes)           |
   | * Time mismatch = lost productivity    |
   +-----------------------------------------+
                |
                v
   +-----------------------------------------+
   | GitHub Actions (Default Choice)         |
   | * Easy to use                           |
   | * BUT: 2-3 minutes per Docker build     |
   | * Hours/weeks spent waiting             |
   +-----------------------------------------+

+-----------------------------------------------------------------------------+
|  SECTION 2: THE SOLUTION (0:45 - 1:30)                                       |
+-----------------------------------------------------------------------------+

   +-----------------------------------------+
   | Depot CI Introduction                   |
   | "38% Faster Docker Builds"              |
   | * Runs GitHub Actions workflows         |
   | * On Depot's optimized infrastructure   |
   | * No configuration required             |
   +-----------------------------------------+
                |
                v
   +-----------------------------------------+
   | Getting Started (4 Steps)               |
   | 1. brew install depot/tap/depot         |
   |    OR curl install script (Linux)       |
   |           |                             |
   |           v                             |
   | 2. depot login                          |
   |           |                             |
   |           v                             |
   | 3. Connect GitHub                       |
   |    (In Depot dashboard: install         |
   |     "Depot Code Access" GitHub App)     |
   |           |                             |
   |           v                             |
   | 4. depot ci migrate                     |
   +-----------------------------------------+
                |
                v
   +-----------------------------------------------+
   | What Makes It Different                       |
   | * Runner: 4 CPU, 16 GB (checks out code)     |
   | * Remote builder: 16 CPU, 32 GB (heavy lift) |
   | * NVMe SSD cache (automatic)                  |
   | * Pre-warmed pool                             |
   | * 38% faster builds                           |
   +-----------------------------------------------+

+-----------------------------------------------------------------------------+
|  SECTION 3: DEPOT CI DEMO (1:30 - 6:50)                                      |
+-----------------------------------------------------------------------------+

   +-----------------------------------------+
   | 1:30 - 1:50 | Get Started               |
   | * Install CLI (brew / curl)             |
   | * Login + Connect GitHub                |
   | * depot ci migrate                      |
   +-----------------------------------------+
                |
                v
   +-----------------------------------------+
   | 1:50 - 3:00 | Migration Process          |
   | * Running depot ci migrate live         |
   | * Showing output step-by-step           |
   | * Explaining each fix applied           |
   +-----------------------------------------+
                |
                v
   +-----------------------------------------+
   | 3:00 - 4:30 | Review Generated Files     |
   | * Side-by-side: .github/ vs .depot/     |
   | * Runner label updates                  |
   | * Cache flags removed                   |
   | * Build action replaced                 |
   +-----------------------------------------+
                |
                v
   +-----------------------------------------+
   | 4:30 - 6:50 | Run a Build End-to-End     |
   | * Trigger build on Depot CI             |
   | * Watch remote builder connect          |
   | * See NVMe cache hits in real-time      |
   | * Build completes in ~2m 20s            |
   +-----------------------------------------+

+-----------------------------------------------------------------------------+
|  SECTION 4: REAL PERFORMANCE DATA (6:50 - 8:20)                              |
+-----------------------------------------------------------------------------+

   +-----------------------------------------+
   | Test Setup                              |
   | * App: OpenClaw AI                      |
   | * 500+ dependencies                     |
   | * 6 test scenarios                      |
   | * Same Dockerfile for both              |
   +-----------------------------------------+
                |
                v
   +---------------------------------------------------------------------+
   |                         TEST RESULTS                                  |
   +---------------------------------------------------------------------+
   | Test Case              GitHub    Depot    Improvement                |
   | -------------------------------------------------------------------  |
   | Baseline (cold)        3m 44s    2m 28s   34% faster ✓              |
   | Documentation change   3m 56s    3m 2s    23% faster ✓              |
   | New source file        3m 21s    1m 53s   44% faster ✓              |
   | UI component           3m 50s    2m 31s   34% faster ✓              |
   | New dependency         3m 59s    2m 13s   44% faster ✓              |
   | Major changes          3m 52s    1m 55s   50% faster ✓              |
   | -------------------------------------------------------------------  |
   | AVERAGE                 3m 47s   2m 20s   38% faster                |
   +---------------------------------------------------------------------+
                |
                v
   +-----------------------------------------+
   | Key Insights                            |
   | * Depot CI wins ALL 6 test cases       |
   | * Biggest win: major changes (50%)     |
   | * Even without cache: 34% faster       |
   +-----------------------------------------+

+-----------------------------------------------------------------------------+
|  SECTION 5: WHY DEPOT WINS (8:20 - 9:20)                                     |
+-----------------------------------------------------------------------------+

   +-----------------------------------------+     +-----------------------------------------------+
   | GitHub Actions                          |     | Depot CI                                      |
   +-----------------------------------------+     +-----------------------------------------------+
   | * Runner only: 2 CPU, 8 GB              |     | * Runner: 4 CPU, 16 GB (code checkout)       |
   | * No separate builder                   |     | * Remote builder: 16 CPU, 32 GB (builds)     |
   | * GHA cache (ineffective)               |     | * NVMe SSD cache (automatic)                  |
   | * Flat build times across scenarios     |     | * Real cache differentiation                  |
   | * 7-day cache retention                 |     | * 14-day default retention                    |
   | * Per-minute billing                    |     | * Per-second billing                           |
   +-----------------------------------------+     +-----------------------------------------------+

   Extra Features (Depot CI only):
   +-----------------------------------------+
   | ✓ SSH into running builds               |
   | ✓ Retry individual failed jobs          |
   | ✓ Per-second billing                    |
   | ✓ Detailed metrics dashboard            |
   | ✓ AI failure diagnosis                  |
   +-----------------------------------------+

+-----------------------------------------------------------------------------+
|  SECTION 6: THE IMPACT (9:20 - 10:30)                                         |
+-----------------------------------------------------------------------------+

   +-----------------------------------------+
   | Time Savings (100 builds/day)           |
   |                                         |
   | GitHub Actions:  ~6.5 hrs/day           |
   | Depot CI:        ~4 hrs/day             |
   | --------------------------              |
   | SAVED: ~12.5 hrs/week                   |
   |         = ~625 hrs/year                 |
   |         = ~16 full work weeks!          |
   +-----------------------------------------+
                |
                v
   +-----------------------------------------+
   | Cost Savings (1,000 builds/month)       |
   |                                         |
   | GitHub Actions:  ~$24/month             |
   | Depot CI:        ~$16/month             |
   | --------------------------              |
   | SAVED: ~33% reduction                   |
   | (Pricing as of April 2026)              |
   +-----------------------------------------+
                |
                v
   +-----------------------------------------+
   | Developer Experience + CTA              |
   | "Ship faster. Iterate more. Wait less." |
   |                                         |
   | depot.dev                               |
   | Free trial + Plans from $20/month       |
   +-----------------------------------------+
                |
                v
   +-----------------------------------------+
   |          FINAL TAGLINE                  |
   |                                         |
   |  "Stop waiting for your builds."        |
   |  "Start shipping faster."               |
   |  "Depot CI"                             |
   +-----------------------------------------+

═══════════════════════════════════════════════════════════════════════════════════════
  KEY TAKEAWAY: Depot CI is 38% faster than GitHub Actions for Docker builds
  - Wins every test case (6/6)
  - Runner + remote builder architecture (4 CPU runner → 16 CPU builder)
  - Saves ~12.5 hours/week for teams doing 100 builds/day
  - 33% cost reduction with per-second billing
═══════════════════════════════════════════════════════════════════════════════════════
```

## Quick Reference

| Metric                | GitHub Actions | Depot CI    | Improvement     |
| --------------------- | -------------- | ----------- | --------------- |
| **Average Build Time**   | 3m 47s         | 2m 20s      | 38% faster      |
| **Fastest Test**         | 3m 21s         | 1m 53s      | 44% faster      |
| **Slowest Test**         | 3m 59s         | 3m 2s       | 23% faster      |
| **Cache Default Retention** | 7 days      | 14 days      | 2x longer       |
| **Billing**              | Per-minute     | Per-second  | More accurate   |
| **Cost (1000 builds/mo)**| ~$24           | ~$16        | 33% savings     |

## Video Flow Summary

| Section | Time | Topic |
|---------|------|-------|
| 1. The Problem | 0:00 - 0:45 | CI is slowing you down |
| 2. The Solution | 0:45 - 1:30 | Depot CI introduction + what makes it different |
| **3. Depot CI Demo** | **1:30 - 6:50** | **Live demo: migrate, review files, run build** |
| 4. Real Performance Data | 6:50 - 8:20 | Head-to-head test results |
| 5. Why Depot Wins | 8:20 - 9:20 | Runner + builder architecture + cache comparison |
| 6. The Impact | 9:20 - 10:30 | Time/cost savings + CTA + closing |

## Migration Commands

```bash
# macOS
brew install depot/tap/depot

# Linux
curl -L https://depot.dev/install-cli.sh | sh

# Login
depot login

# Migrate existing workflows
depot ci migrate
```
