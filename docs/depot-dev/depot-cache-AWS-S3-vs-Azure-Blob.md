# AWS S3 vs Azure Blob: Enterprise Storage Decision Guide 2025

**Key Context:** The Broadcom VMware acquisition has forced enterprises to reconsider their entire infrastructure stack, with cloud storage choice becoming critical for avoiding vendor lock-in.

## Main Differences

| Aspect | AWS S3 | Azure Blob |
|--------|--------|------------|
| **Market Share** | 30% global workloads | 24% global workloads |
| **Scale** | 280T+ objects, 100M+ requests/sec | 1 quadrillion+ transactions/month |
| **Storage Classes** | 6 tiers (Standard, Intelligent-Tiering, Express One Zone, Standard-IA, Glacier, Deep Archive) | 4 tiers (Hot, Cool, Cold, Archive) |
| **Durability** | 11 nines (99.999999999%) | Up to 16 nines with GRS |
| **New Feature** | S3 Vectors for AI/ML vector embeddings | N/A |

## Cost Comparison (100TB dataset over 3 years)

- **AWS S3:** $187,440
- **Azure Blob:** $156,600 (16% lower)

**Hidden Costs:** Egress fees ($0.09/GB), API migration costs ($50K-$200K), and the "lock-in tax" (15-30% of annual cloud budget).

---

# GitHub Actions vs Depot Runners: Complete Performance Comparison

> **Note:** This comparison describes **Depot GitHub Actions Runners** (a product that provides faster GitHub-hosted runners), not **Depot CI** (the programmable CI engine that runs your workflows on Depot infrastructure).

## How Depot Achieved Faster Cache Performance

Depot's approach to cache acceleration leverages:

1. **Optimized infrastructure:** Runners hosted for better cache storage proximity
2. **Increased parallelism:** More concurrent streams for cache operations
3. **Drop-in replacement:** Uses same `actions/cache@v3` — no workflow changes required

## Complete Performance Comparison

| Metric | GitHub Actions | Depot | Improvement |
|--------|----------------|-------|-------------|
| **CPU Speed (sysbench)** | 4,119.42 | 8,917.15 | ~2x faster |
| **Cache Throughput** | 100-150 MB/s | Significantly faster | Multiple streams |
| **Cache Size Limit** | 10 GB (expandable) | Configurable (up to unlimited) | No limit option |
| **Cache Retention** | 7 days | 14 days (default, up to 30) | 2x longer (up to 4x) |
| **Cost per Minute** | $0.006 (2026) | $0.004 | ~33% cheaper |

## Architecture Differences

| Aspect | GitHub Actions | Depot |
|--------|----------------|-------|
| **Infrastructure** | Azure-hosted runners | AWS EC2 + S3 |
| **Cache Storage** | Azure Blob Storage | S3 |
| **Instance Reuse** | Reuses instances between builds | Fresh EC2 instance per build |
| **Billing** | Per minute, rounded up | Per-second billing |

## Real-World Build Times (Next.js)

| Scenario | GitHub Actions | Depot | Improvement |
|----------|----------------|-------|-------------|
| **Without cache** | 4m 49s ($0.04) | 3m 32s ($0.014) | 24% faster, 65% cheaper |
| **With cache** | 4m 6s ($0.04) | 3m 1s ($0.012) | 57% faster, 70% cheaper |

## Monthly Savings (100 builds/day)

- **Time saved:** 50+ hours per month
- **Cost saved:** $80+ per month
- GitHub's round-up billing adds ~45 hours of "phantom" time monthly

## Key Technical Insight

Depot's cache acceleration comes from:

1. Optimized runner infrastructure for cache operations
2. Increased parallelism for cache downloads/uploads
3. No workflow changes required — drop-in replacement using same `actions/cache@v3`

---

## Sources

- [AWS S3 vs. Azure Blob: Enterprise Storage Decision Guide 2025 \| Everpure Blog](https://blog.purestorage.com/purely-educational/aws-s3-vs-azure-blob/)
- [Comparing GitHub Actions and Depot runners for 2x faster builds](https://depot.dev/blog/comparing-github-actions-and-depot-runners-for-2x-faster-builds)
- [We reverse-engineered the GitHub Actions cache so you don't have to](https://depot.dev/blog/github-actions-cache)
