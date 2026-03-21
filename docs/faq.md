# Frequently Asked Questions

## General Questions

### What is Depot CI?

Depot CI is a programmable CI engine built with performance as a first-class citizen. It's designed for the AI-augmented development era where teams using AI agents can produce 10x the code — and traditional CI systems can't keep up.

### Why did you choose OpenClaw for the demo?

OpenClaw is the perfect showcase because:
- It's a viral AI project with massive buzz
- It represents the future of personal AI agents
- It has a real-world tech stack (Node.js/TypeScript)
- It tells a compelling story about AI development velocity

### Is Depot CI a replacement for GitHub Actions?

Not necessarily — it's compatible with GitHub Actions. You can bring your existing GitHub Actions workflows and run them on Depot CI infrastructure for better performance.

## Technical Questions

### What are the system requirements?

- Node.js 18+
- Docker 20+
- Git 2.x+
- A Depot account (free during beta)
- A Railway account (free tier available)

### How much does Depot CI cost?

During beta: **Free**

After GA: $0.0001 per second for base runners (approximately $0.36/hour)

### Does Depot CI work with other platforms besides Railway?

Yes! Depot CI can deploy to:
- Railway
- AWS (ECS, EKS, Lambda)
- Google Cloud (Run, GKE)
- Azure (Container Instances, AKS)
- Any Docker-compatible platform

### What caching mechanisms does Depot CI use?

Depot CI uses:
- **Distributed layer caching** across all builds
- **Dependency caching** for npm, yarn, pnpm, etc.
- **Incremental compilation** for TypeScript, Go, Rust
- **Global cache** shared across your organization

## Setup Questions

### Do I need to rewrite my workflows?

No! Depot CI is GitHub Actions compatible. Simply run:
```bash
depot ci migrate
```
This analyzes your workflows and creates Depot CI equivalents.

### What secrets do I need to configure?

| Secret | Purpose |
|--------|---------|
| `DEPOT_TOKEN` | Authenticate with Depot |
| `DEPOT_PROJECT_ID` | Identify your Depot project |
| `RAILWAY_TOKEN` | Authenticate with Railway |
| `RAILWAY_PROJECT_ID` | Identify your Railway project |
| `RAILWAY_SERVICE_ID` | Identify your Railway service |

See [github-secrets.md](./github-secrets.md) for detailed instructions.

### Can I run this locally without Depot/Railway?

Yes! The sample app works locally:
```bash
cd sample-app
npm install
npm run build
npm start
```

You can also build and run with Docker:
```bash
docker build -t openclaw-demo .
docker run -p 3000:3000 openclaw-demo
```

## Performance Questions

### How much faster is Depot CI really?

Based on our benchmarks:
- **Dependencies**: 9x faster (45s → 5s)
- **TypeScript build**: 10x faster (30s → 3s)
- **Docker build**: 11x faster (90s → 8s)
- **Total workflow**: 5-10x faster (4-7 min → 20-60s)

### Will my results vary?

Yes, actual performance depends on:
- Your project's dependency tree
- Your geographic location
- Cache hit rates
- Concurrent workflows

However, most teams see **at least 3-5x improvement** on first run, increasing to **10-40x** as caches warm up.

### What about first-time builds?

First builds benefit from:
- Optimized infrastructure (faster CPUs, better networking)
- Parallel execution where possible
- Even without cache, Depot's infrastructure is 2-3x faster

Subsequent builds see the full benefit of distributed caching.

## Troubleshooting

### Workflow fails with "project not found"

- Verify `DEPOT_PROJECT_ID` is correct
- Check the project exists in your Depot dashboard
- Ensure you have permissions to access it

### Workflow fails with "authentication failed"

- Verify all tokens are valid and not expired
- Regenerate tokens if needed
- Check secret names match exactly (case-sensitive)

### Docker build is still slow

- First builds are slower (cache warming)
- Check if `DOCKER_BUILDKIT=1` is set
- Verify multi-stage build is being used
- Review Dockerfile for optimization opportunities

## Railway Questions

### Why Railway for this demo?

Railway is:
- Developer-friendly (simple deployment)
- Container-native (works with Docker)
- Has visible build costs (shows Depot's value)
- Growing in popularity for AI/ML projects

### Will this work with Railway's free tier?

Yes! The sample app is designed to work within Railway's free tier:
- Small container size
- Efficient resource usage
- Minimal runtime costs

### Can I deploy elsewhere?

Absolutely. The Docker image can be deployed to:
- AWS ECS
- Google Cloud Run
- Azure Container Instances
- DigitalOcean App Platform
- Fly.io
- Render
- Any platform that supports Docker

## Demo Questions

### Can I customize the demo app?

Yes! The sample app is open-source (MIT license). You can:
- Add new skills to the skills system
- Integrate different AI models
- Modify the REST API
- Add authentication
- Connect to real services

### How do I run the benchmarks?

Use the provided benchmark script:
```bash
chmod +x scripts/benchmark.sh
./scripts/benchmark.sh
```

Results are saved to `benchmarks/results/`

### Can I use this for my own projects?

Yes! The patterns demonstrated here apply to any Node.js/TypeScript project:
- Multi-stage Docker builds
- GitHub Actions workflows
- Depot CI integration
- Railway deployment

## Support

### Where can I get help?

- **Depot Documentation**: [depot.dev/docs](https://depot.dev/docs)
- **Railway Documentation**: [docs.railway.app](https://docs.railway.app)
- **Depot Discord**: [discord.gg/depot](https://discord.gg/depot)
- **GitHub Issues**: [github.com/depot/depot-ci](https://github.com/depot/depot-ci/issues)

### Is there a community forum?

Join the conversation:
- **Discord**: [discord.gg/depot](https://discord.gg/depot)
- **X/Twitter**: [@depotdev](https://x.com/depotdev)
- **GitHub Discussions**: [github.com/depot/depot-ci/discussions]

---

Still have questions? Feel free to open an issue or join our Discord!
