The statement is mostly improved over earlier versions but still has two issues — one on each side of the comparison. Here's the breakdown:

✅ What's Now Correct


Claim	Status
"Both platforms use remote cache storage that persists across jobs"	✅ Correct
"14-day default retention" for Depot	✅ Correct (source)
"Options up to 30 days" for Depot	✅ Correct (source)
"Configurable cache sizes" for Depot	✅ Correct (25 GB up to No limit) (source)
❌ What's Still Inaccurate
1. GitHub Actions "10 GB by default, more with paid plans"
This claim about GitHub Actions pricing/limits comes from GitHub's own documentation, not Depot's — Depot's docs don't make this claim at all. You should verify it directly with GitHub's documentation before including it in the video, as it could be outdated or inaccurate.

2. Depot cache is "built in with no extra charges"
⚠️ Misleading. Depot Cache storage is billed. Each plan includes a block of storage, and additional usage beyond the included amount is billed at $0.20 per GB/month. (source)

The correct framing is that cache is included in every plan up to the plan's storage limit, not that there are no extra charges.

Suggested Replacement
"Both platforms use remote cache storage that persists across jobs. Depot Cache has a 14-day default retention — double GitHub Actions' 7-day default — with options up to 30 days, and configurable size limits up to no limit at all. Cache storage is included in every Depot plan."

This keeps the comparison factual while avoiding unverifiable claims about GitHub's pricing and the inaccurate "no extra charges" framing.