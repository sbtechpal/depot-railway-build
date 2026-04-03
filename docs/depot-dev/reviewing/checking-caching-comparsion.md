Here's a fact-check of the claims against Depot's actual documentation:

✅ Partially Correct / ❌ Inaccurate Claims
GitHub Actions Cache Description
Claim

Verdict

"Stored on runner (ephemeral), destroyed after each job"

❌ Inaccurate. GitHub Actions cache is stored remotely (Azure Blob), not on the runner itself. It persists across jobs.

"Limited to ~10 GB"

✅ Roughly accurate for GitHub's own cache limits

"7-day retention"

✅ Accurate for GitHub's default

Depot CI Cache Description
Claim

Verdict

"Distributed global storage (S3), persists across all builds"

✅ Plausible, but not explicitly confirmed in docs

"No size limit (unlimited)"

⚠️ Misleading. Depot Cache has configurable size limits: 25 GB, 50 GB, 100 GB, 150 GB, 250 GB, 500 GB, or No limit — "no limit" is an option, not the default. (source)

"30-day retention (4x longer)"

⚠️ Partially inaccurate. 30 days is the maximum configurable option. The default is 14 days, not 30. Available options are 7, 14, or 30 days. (source)

"Project-isolated"

⚠️ Inaccurate. Depot Cache is scoped by repository, not by project. (source)

Technical Architecture Claims (Azure vs AWS, throughput numbers)
Claim

Verdict

"GitHub Actions on Azure, Depot on AWS EC2"

❌ Not verifiable from docs. Depot's documentation does not make claims about Azure vs. AWS infrastructure comparisons.

"~10 Gbps / 1 GB/s throughput, 8 parallel streams"

❌ Not documented. These specific throughput figures are not stated anywhere in Depot's official documentation.

"GitHub Actions ~150 MB/s, Depot ~1,000 MB/s"

❌ Not documented. No official benchmarks supporting these numbers exist in Depot's docs.

"Drop-in Replacement" Claim
Claim

Verdict

Claim

Verdict

"Works with existing actions/cache@v3, no workflow changes"

✅ Accurate — but only when using Depot GitHub Actions Runners. It does not automatically apply to standard GitHub-hosted runners. (source)

Summary
The content contains several inaccuracies and unsupported claims:

The default retention is 14 days, not 30.

"No size limit" is a configurable option, not the default.

The throughput/speed figures (1 GB/s, 10x faster, 8 parallel streams) are not documented and should not be presented as facts.

The claim that GitHub's cache lives "on the runner" is technically incorrect.

The drop-in replacement benefit only applies when using Depot GitHub Actions Runners, not Depot CI specifically.

I'd recommend not using this content as-is, as it overstates capabilities and includes unverified benchmarks.