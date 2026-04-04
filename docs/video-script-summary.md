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
   | "Nearly 2x Faster Docker Builds"        |
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
   | Test Case              GitHub    Depot    Speedup                   |
   | -------------------------------------------------------------------  |
   | Baseline (no cache)     4m 6s    2m 1s    2.0x ✓                   |
   | Comment change         4m 1s    2m 47s   1.4x ✓                   |
   | New source file        4m 0s    2m 47s   1.4x ✓                   |
   | UI component           3m 57s   1m 26s   2.8x ✓                   |
   | New dependency         3m 55s   3m 11s   1.1x ✓                   |
   | Major changes          3m 51s   1m 42s   2.2x ✓                   |
   | -------------------------------------------------------------------  |
   | AVERAGE                 3m 53s   2m 18s   1.7x faster              |
   +---------------------------------------------------------------------+
                |
                v
   +-----------------------------------------+
   | Key Insights                            |
   | * Depot CI wins ALL 6 test cases       |
   | * Biggest win: UI component (2.8x)     |
   | * Even without cache: 2x faster        |
   +-----------------------------------------+

+-----------------------------------------------------------------------------+
|  SECTION 4: WHY DEPOT WINS (3:00 - 4:00)                                      |
+-----------------------------------------------------------------------------+

   +-----------------------------------------+     +-----------------------------------------+
   | GitHub Actions                          |     | Depot CI                                 |
   +-----------------------------------------+     +-----------------------------------------+
   | * Generic VM runners                    |     | * Docker-optimized runners               |
   | * Cold starts                           |     | * Pre-warmed sandboxes                   |
   | * No shared state                       |     | * Persistent cache                       |
   | * 7-day cache retention                 |     | * 14-30 day retention                    |
   | * Per-minute billing                    |     | * Per-second billing                     |
   +-----------------------------------------+     +-----------------------------------------+

   Cache Comparison:

   GitHub Actions:              Depot CI:
   +--------------+             +--------------+
   | Fresh VM     |             | Pre-warmed   |
   | No cache     |             | + Persistent |
   | Download all |             |   cache      |
   | 500+ pkgs    |             | Download     |
   | 2-3 min      |             | NEW pkgs only|
   +--------------+             | 30-60 sec    |
                                +--------------+

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
   | GitHub Actions:  370 min/day            |
   | Depot CI:        200 min/day            |
   | --------------------------              |
   | SAVED: 170 min/day = ~14 hrs/week       |
   |         = ~700 hrs/year                 |
   |         = ~18 full work weeks!          |
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
  KEY TAKEAWAY: Depot CI is 1.7x faster than GitHub Actions for Docker builds
  - Wins every test case (6/6)
  - Saves ~14 hours/week for teams doing 100 builds/day
  - 33% cost reduction with per-second billing
═══════════════════════════════════════════════════════════════════════════════════════
```

## Quick Reference

| Metric                | GitHub Actions | Depot CI    | Improvement     |
| --------------------- | -------------- | ----------- | --------------- |
|--------|----------------|----------|-------------|
| **Average Build Time**   | 3m 53s         | 2m 18s      | 1.7x faster      |
| **Fastest Test**         | 3m 51s         | 1m 26s      | 2.8x faster      |
| **Slowest Test**         | 4m 6s          | 3m 11s      | 1.1x faster      |
| **Cache Retention**      | 7 days         | 14-30 days  | 2-4x longer      |
| **Billing**              | Per-minute     | Per-second  | More accurate    |
| **Cost (1000 builds/mo)**| ~$24           | ~$16        | 33% savings      |

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
