 the statement is inaccurate, and it's actually describing the wrong Depot product. Here's the breakdown:

What's Wrong
1. "Depot CI uses Docker-optimized infrastructure with BuildKit built in" — ❌ Wrong Product
BuildKit is the engine behind Depot Container Builds, not Depot CI. (source)

Depot CI is built on a completely different architecture called Switchyard — a programmable CI orchestration engine with pre-warmed sandboxes. Its speed advantage comes from fast sandbox provisioning (commit to running job in 2–3 seconds) and built-in Depot Cache, not from BuildKit. (source)

2. "GitHub Actions uses generic runners that have to set up Docker from scratch" — ⚠️ Misleading
This framing implies Docker build speed is the core differentiator for Depot CI, which it isn't. The real architectural difference is sandboxes vs. ephemeral VMs and pre-warmed compute vs. cold starts.

What the Statement Should Say
Based on the actual docs, the accurate version for Depot CI would be:

"The difference comes down to architecture. GitHub Actions spins up a fresh generic VM for every job — no pre-warming, no shared state. Depot CI uses pre-warmed sandboxes on performance-tuned compute, with Depot Cache built in and no configuration required. The result is jobs that start in 2–3 seconds instead of waiting for a cold VM to boot."

If the Video Is Comparing Docker Build Speed Specifically
If the benchmark is specifically about Docker image build times (which your test data suggests), then the relevant product is actually Depot Container Builds, and BuildKit is the correct thing to mention. In that case the comparison should be:

"Depot Container Builds runs on dedicated BuildKit infrastructure with persistent NVMe cache — versus GitHub Actions runners that start fresh with no layer cache on every run."

The script needs to be clear about which Depot product is responsible for the Docker build speedup shown in the test results.