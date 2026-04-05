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

+-----------------------------------------------------------------------------+
|  SECTION 3: REAL PERFORMANCE DATA (1:30 - 3:00)                              |
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
|  SECTION 4: WHY DEPOT WINS (3:00 - 4:00)                                      |
+-----------------------------------------------------------------------------+

   +-----------------------------------------+     +-----------------------------------------+
   | GitHub Actions                          |     | Depot CI                                 |
   +-----------------------------------------+     +-----------------------------------------+
   | * 2 CPU, 8 GB generic VM                |     | * 16 CPU, 32 GB remote builders          |
   | * GHA cache (ineffective)               |     | * NVMe SSD cache (automatic)             |
   | * Flat build times across scenarios     |     | * Real cache differentiation             |
   | * 7-day cache retention                 |     | * 14-day default retention               |
   | * Per-minute billing                    |     | * Per-second billing                     |
   +-----------------------------------------+     +-----------------------------------------+

   Cache Comparison:

   GitHub Actions:              Depot CI:
   +--------------+             +--------------+
   | Flat times   |             | Real cache   |
   | across all   |             | hits (31-52%)|
   | scenarios    |             | NVMe SSD     |
   | 201-239s     |             | 113-182s     |
   | No real      |             | Meaningful   |
   | diff (38s)   |             | diff (69s)   |
   +--------------+             +--------------+

   Extra Features (Depot CI only):
   +-----------------------------------------+
   | ✓ SSH into running builds               |
   | ✓ Retry individual failed jobs          |
   | ✓ Per-second billing                    |
   | ✓ Detailed metrics dashboard            |
   | ✓ AI failure diagnosis                  |
   +-----------------------------------------+

+-----------------------------------------------------------------------------+
|  SECTION 5: THE IMPACT (4:00 - 5:00)                                          |
+-----------------------------------------------------------------------------+

   +-----------------------------------------+
   | Time Savings (100 builds/day)           |
   |                                         |
   | GitHub Actions:  380 min/day            |
   | Depot CI:        230 min/day            |
   | --------------------------              |
   | SAVED: 150 min/day = ~12.5 hrs/week    |
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
   +-----------------------------------------+
                |
                v
   +-----------------------------------------+
   | Developer Experience                    |
   | "Ship faster. Iterate more. Wait less." |
   +-----------------------------------------+

+-----------------------------------------------------------------------------+
|  SECTION 6: CALL TO ACTION (5:00 - 6:00)                                      |
+-----------------------------------------------------------------------------+

   +-----------------------------------------+
   | Get Started Today                       |
   |                                         |
   | 1. brew install depot/tap/depot         |
   | 2. depot login                          |
   | 3. Connect GitHub                       |
   | 4. depot ci migrate                     |
   |                                         |
   | Visit: depot.dev                        |
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
| **Cache Retention**      | 7 days         | 14 days      | 2x longer       |
| **Billing**              | Per-minute     | Per-second  | More accurate   |
| **Cost (1000 builds/mo)**| ~$24           | ~$16        | 33% savings     |

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
