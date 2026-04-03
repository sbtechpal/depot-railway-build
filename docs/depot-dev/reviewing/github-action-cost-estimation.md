Here’s the corrected breakdown using current 2026 GitHub Actions pricing.

✅ 1. Your time‑rounding math is correct
233 seconds = 3.88 minutes → billed as 4 minutes (GitHub rounds up to the next full minute)

1,000 builds × 4 minutes = 4,000 billed minutes/month

That part is spot‑on.

❗ 2. Your rate ($0.008/min) is the old 2025 Linux rate
GitHub reduced runner prices in January 2026:

Linux runners: now $0.006/min (down from $0.008) 

Windows and macOS also dropped, but Linux is the most common baseline.

There is also a $0.002/min cloud platform fee, but GitHub states this is already included in the new published rates. 

So the effective Linux rate is $0.006/min, not $0.008.

✅ 3. Corrected cost calculation (2026 pricing)
Item	Value
Billed minutes	4,000 / month
Rate (Linux)	$0.006/min
Monthly cost	$24/month

📌 Conclusion
Your method is correct, but the price per minute should be updated:

Your estimate: ~$32/month

Correct 2026 estimate: ~$24/month


# references
- https://ubos.tech/news/github-actions-announces-2026-pricing-changes-and-new-cloud-platform-charges/?utm_source=copilot.com
- https://dev.to/shubhamoriginx/github-actions-changed-pricing-in-2026-heres-exactly-what-youre-paying-now-51db?utm_source=copilot.com