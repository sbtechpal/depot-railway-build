Here is a thorough section-by-section review of the script. I've flagged every inaccuracy, misleading claim, and unsupported statement with suggested corrections.

🔴 Critical Issues (Must Fix)
1. CLI Installation Method — Section 1:00 and 5:00/5:20
Script says:


npm install -g @depot/cli
❌ Wrong. The Depot CLI is not an npm package. The correct installation methods are: (source)


# macOS
brew install depot/tap/depot

# Linux
curl -L https://depot.dev/install-cli.sh | sh
This appears three times in the script (Sections 1:00, 5:00, and 5:20) and must be corrected in all three places.

2. depot init Is Not Part of Depot CI Setup — Sections 1:00 and 5:00/5:20
Script says:


depot init   # Step 3: Initialize Depot in your project
❌ Wrong for Depot CI. depot init is a Container Builds command that links a project to a depot.json file for Docker image builds. (source)

The correct Depot CI setup flow is: (source)

Install CLI
depot login
Connect to GitHub (install the Depot Code Access GitHub App via dashboard)
depot ci migrate
Remove depot init from the Depot CI migration steps entirely.

3. Missing Required Step: Connect to GitHub — Section 1:00
Script omits the required step of connecting your GitHub organization via the Depot dashboard (installing the Depot Code Access app). Without this, depot ci migrate won't work. The quickstart explicitly lists this as a prerequisite step. (source)

4. Depot CI Description Is Inaccurate — Section 0:45
Script says:

"A Docker-optimized CI solution that integrates directly with GitHub Actions workflows for faster builds."

❌ Misleading. Depot CI is not specifically a "Docker-optimized" tool — it is a programmable CI engine that runs your GitHub Actions YAML workflows entirely on Depot's own infrastructure. Docker build speed is a benefit of Container Builds, a separate Depot product. (source)

Suggested fix:

"Depot CI is a programmable CI engine that runs your existing GitHub Actions workflows entirely on Depot's own infrastructure — with faster compute, built-in caching, and no configuration required."

5. "Distributed global cache learns from everyone's builds" — Section 2:15–2:45
Script says:

"It learns from every previous build - yours and everyone else's."

❌ Not documented and likely inaccurate. Depot Cache is scoped by repository — cache entries are isolated to the repository that created them and are not shared across organizations or other users' repos. (source)

🟡 Inaccurate or Misleading Claims (Should Fix)
6. Cache Retention Default — Section 3:20
Script says:

"GitHub Actions cache is limited to 10 gigabytes with 7-day retention. Depot CI offers configurable cache sizes with options up to 30 days retention."

⚠️ Partially correct but misleading. The Depot Cache default retention is 14 days, not 30. 30 days is the maximum configurable option. The default size limit is also No limit, not a specific number. (source)

Suggested fix: Say "up to 30-day retention (configurable)" and note the default is 14 days.

7. "Replay from any step" Feature — Section 3:50
Script says:

"✅ Replay from any step"

⚠️ Partially inaccurate. Depot CI supports retrying failed jobs and re-running failed workflows, but the feature is not called "replay from any step." There is no documented "replay from any step" feature — you can retry a job or rerun a workflow, but step-level replay is not described in the docs. (source)

Suggested fix: Change to "✅ Retry individual failed jobs without rerunning the whole workflow"

8. GitHub Actions Cache Architecture — Section 2:15
Script says:

"GitHub Actions runners are ephemeral - meaning every build gets a brand new virtual machine that's destroyed after the job finishes. No cache survives between builds."

❌ Technically inaccurate. GitHub Actions cache does persist between jobs via remote storage (Azure Blob) — it is not destroyed with the runner. What is ephemeral is the runner itself, but the cache service is separate. This was flagged in our earlier review too.

9. Cost Comparison Numbers — Section 4:20
Script says:

"Cost: $0.008/minute → ~$32/month" and "Cost: $0.007/minute → ~$16/month"

⚠️ Unverifiable. The per-second price for Depot CI sandboxes from the docs is $0.0001/second (= $0.006/minute for the 2-CPU sandbox). The GitHub Actions per-minute rate varies by runner type and is not Depot's to quote. These numbers are not sourced from Depot's documentation and should either be verified independently or removed. (source)

10. Test Environment Shows depot-ubuntu-22.04 — Test Data Summary
Script says:

Runner: depot-ubuntu-22.04 (optimized)

⚠️ Outdated label. The current Depot CI sandbox labels in the docs use Ubuntu 24.04, e.g. depot-ubuntu-24.04. Verify whether depot-ubuntu-22.04 is still a valid/current label for the video. (source)

11. Image pushed to GHCR in test — Test Data Summary
⚠️ Important compatibility note to add. The script uses GHCR as the destination registry. However, Depot CI has a known limitation: pushing to GitHub Packages (including GHCR) using secrets.GITHUB_TOKEN does not work in Depot CI due to a GitHub limitation. If the test used a personal access token instead, this should be noted. If using Depot CI going forward, the recommended alternative is the Depot Registry. (source)

✅ What Is Accurate


Claim	Status
depot ci migrate copies workflows from .github/ to .depot/workflows/	✅ Correct
Original workflows continue running in parallel on GitHub	✅ Correct
Commit to running job in 2–3 seconds	✅ Documented
Pre-warmed sandboxes	✅ Documented
Depot Cache built in, no configuration required	✅ Documented
SSH into running builds	✅ Documented
AI failure diagnosis feature	✅ Documented
Per-second billing, no one-minute minimum	✅ Documented
CPU and memory metrics captured for every job	✅ Documented
Performance data from your own real tests	✅ Credible (your own benchmark)
Summary of Changes Needed


Priority	Issue	Section
🔴 Critical	Replace npm install -g @depot/cli with correct install method	1:00, 5:00, 5:20
🔴 Critical	Remove depot init from Depot CI setup steps	1:00, 5:00, 5:20
🔴 Critical	Add missing GitHub App connection step to migration flow	1:00
🔴 Critical	Fix Depot CI description (not "Docker-optimized CI")	0:45
🔴 Critical	Remove "learns from everyone's builds" — cache is repo-scoped	2:15–2:45
🟡 Should fix	Cache default is 14 days, not implied to be 30	3:20
🟡 Should fix	"Replay from any step" → "Retry individual failed jobs"	3:50
🟡 Should fix	GitHub Actions cache doesn't disappear with the runner	2:15
🟡 Should fix	Verify/remove cost per-minute figures	4:20
🟡 Should fix	Verify depot-ubuntu-22.04 label is current	Test data
🟡 Should fix	Add note about GHCR limitation in Depot CI	Test data
