Here is a comprehensive claim-by-claim analysis of the entire document:

✅ Correct Claims


Claim	Notes
Depot CI is a programmable CI engine	✅ (source)
Container builds up to 40x faster	✅ (source)
Jobs start in 2–3 seconds	✅ (source)
Pre-warmed sandboxes	✅ (source)
Depot Cache built in, no configuration required	✅ (source)
depot ci migrate copies workflows from .github/workflows/ to .depot/workflows/	✅ (source)
Run both GitHub Actions and Depot CI in parallel during testing	✅ (source)
Plans start at $20/month with 2,000 included minutes	✅ (source)
7-day free trial, no credit card required	✅ (source)
Per-second billing, no minimums	✅ (source)
SSH into running sandbox	✅ (source)
Retry failed jobs without rerunning entire workflow	✅ (source)
AI failure diagnosis (what went wrong + suggested fix)	✅ (source)
Coding agent integration with Claude Code and Cursor	✅ (source)
Switchyard orchestrator handles dependencies and schedules tasks	✅ (source)
CLI commands: depot ci run, depot ci status, depot ci logs, depot ci ssh, depot ci migrate	✅ (source)
--ssh-after-step flag inserts SSH pause after specific step	✅ (source)
macOS: brew install depot/tap/depot	✅ (source)
Linux: curl -L https://depot.dev/install-cli.sh | sh	✅ (source)
Connect GitHub via Depot Code Access GitHub App	✅ (source)
Future syntax support (GitLab CI etc.) is architecturally possible	✅ Consistent with docs stating "the system is programmable" (source)
❌ Inaccurate or Unsupported Claims
1. Pricing listed as $0.0001/second
⚠️ Misleading without context. The per-second price of $0.0001 applies only to the smallest 2-CPU sandbox. Larger sandboxes cost more per second ($0.0002 up to $0.0032). The document presents this as a single flat price, which is inaccurate. (source)

2. Performance comparison table — "Startup: 40+ seconds cold start" for GitHub Actions
❌ Not documented by Depot. This specific figure for GitHub Actions cold start time is not sourced from Depot's documentation and should not be presented as a verified fact.

3. Performance comparison table — "State: Durable (crash = resume)"
❌ Not documented. The docs describe Switchyard as having a durable state machine that "handles failures & retries," but there is no documented claim that a crashed job automatically resumes from where it left off. The retry functionality documented is user-initiated, not automatic crash recovery. (source)

4. Performance comparison table — "Scheduling: Pull model (one job at a time) vs Push model (DAG-aware)"
❌ Inaccurate — as covered in our earlier review. GitHub Actions already runs independent jobs in parallel. Presenting it as "one job at a time" is factually wrong. The DAG scheduling framing is not a documented Depot advantage over GitHub Actions. (source)

5. Performance comparison table — "Debugging: Restart from beginning vs Replay from any step + SSH"
❌ "Replay from any step" is not a documented feature. Depot CI supports retrying failed jobs and SSH debugging, but "replay from any step" as a distinct feature is not documented. This was flagged in earlier reviews. (source)

6. Compute Layer — "Standby pools: Pre-warmed EC2 instances in stopped state"
⚠️ Partially unsupported. The docs confirm pre-warmed sandboxes and 2–3 second startup, but the specific implementation detail of "EC2 instances in stopped state" is not documented publicly. Avoid stating internal implementation details as facts unless sourced. (source)

7. Compute Layer — "Sandboxes with BuildKit pre-installed"
❌ Wrong product context. BuildKit is the engine for Depot Container Builds, not Depot CI. Depot CI sandboxes run GitHub Actions workflows — they don't have BuildKit as a defining feature. (source)

8. DAG section — "GitHub Actions: Pull Model (one job at a time)"
❌ Factually incorrect — same issue as #4 above. GitHub Actions parallelises independent jobs. This entire section repeats the same inaccurate framing from the previous document reviewed.

9. CLI command shown as depot ci logs <run-id> --job <job-name>
⚠️ Minor inaccuracy. The correct flag is --job <key> (job key), not --job <job-name>. This is a small distinction but worth correcting for technical accuracy. (source)

10. "80% reduction in CI compute costs"
❌ Not documented. This is an unsubstantiated marketing claim not found anywhere in Depot's official documentation. Remove or replace with verifiable data.

11. "No migration project required" under GitHub Actions Compatible
⚠️ Unclear/misleading. The migration does require connecting a GitHub organization via the Depot Code Access GitHub App and having a Depot account/org set up. "No migration project required" could confuse readers. (source)

Summary Table


Category	Count
✅ Accurate claims	21
❌ Inaccurate / unsupported claims	11
Top Priority Fixes


#	Issue	Fix
1	DAG "pull model / one job at a time" for GitHub Actions	Remove entirely — GitHub Actions parallelises jobs too
2	"Replay from any step"	Change to "Retry individual failed jobs + SSH debugging"
3	"Sandboxes with BuildKit pre-installed"	Remove — BuildKit belongs to Container Builds, not Depot CI
4	"Durable (crash = resume)"	Change to "Durable state machine with retry support"
5	"80% reduction in CI compute costs"	Remove — not documented
6	Flat $0.0001/second pricing	Add "starting from" or show the full sandbox size table
7	"40+ seconds cold start" for GitHub Actions	Remove — not sourced from Depot docs
