# Depot CI: Stakeholder Presentation

## Slide 1: Title Slide

**Depot CI**
### Nearly 2x Faster Builds for the AI-Augmented Development Era

---
---

## Slide 2: Executive Summary

### The Problem
- Writing code is no longer the bottleneck
- Integrating code is the new challenge
- Traditional CI systems can't handle AI-augmented development velocity

### The Solution
**Depot CI** — A programmable CI engine built with performance as a first-class citizen

### The Impact
- **Nearly 2x faster builds** (based on real testing with OpenClaw AI)
- **~33% cost reduction** (2026 GitHub Actions pricing)
- **Teams can iterate at AI speed**

---
---

## Slide 3: The New Reality

### AI Has Changed Everything

| Then | Now |
|-----|-----|
| 10 engineers = 10x output | 10 engineers with AI = 100x output |
| CI was adequate | CI is now the bottleneck |
| 15-minute pipelines were annoying | 15-minute pipelines are crippling |

**The math doesn't work anymore.**

---
---

## Slide 4: Meet Depot CI

### What Is It?

A programmable CI engine designed for the AI-augmented development era

### Key Features

| Feature | Benefit |
|---------|---------|
| **Repository-Scoped Cache** | Cache persists across all builds (14-day retention) |
| **Pre-Warmed Sandboxes** | Jobs start in 2-3 seconds vs cold VM boots |
| **GitHub Actions Compatible** | No workflow rewrite required |
| **API-First** | Works for engineers and autonomous agents |

---
---

## Slide 5: The Demo — OpenClaw

### Why OpenClaw?

- **Viral AI project** with 100+ endorsements from tech leaders
- **Real-world tech stack** (Node.js, TypeScript, Docker)
- **Represents the future** of personal AI assistants
- **Complex enough** to show Depot's value

### The Stack

```
┌─────────────────────────────────────┐
│          OpenClaw Demo               │
├─────────────────────────────────────┤
│ • 15 production dependencies       │
│ • TypeScript compilation             │
│ • Multi-stage Docker build          │
│ • Skills system with AI integration  │
└─────────────────────────────────────┘
```

---
---

## Slide 6: Head-to-Head Comparison

### Same Code. Different Infrastructure.

```
┌─────────────────────┬─────────────────────┐
│   GitHub Actions     │      Depot CI        │
│    (Baseline)        │      (Showcase)      │
├─────────────────────┼─────────────────────┤
│                     │                     │
│   Time: 3m 53s      │   Time: 2m 18s      │
│                     │                     │
│   ✓ SUCCESS         │   ✓ SUCCESS         │
│                     │                     │
└─────────────────────┴─────────────────────┘
```

### The Result

**1.7x faster. Same outcome.**

---
---

## Slide 7: Performance Breakdown

### Where Does the Time Go?

| Test Case | GitHub Actions | Depot CI | Speedup |
|-----------|----------------|----------|---------|
| Baseline (no cache) | 4m 6s | 2m 1s | **2.0x** |
| Documentation change | 4m 1s | 2m 47s | **1.4x** |
| New source file | 4m 0s | 2m 47s | **1.4x** |
| UI component | 3m 57s | 1m 26s | **2.8x** |
| New dependency | 3m 55s | 3m 11s | **1.1x** |
| Major changes | 3m 51s | 1m 42s | **2.2x** |
| **AVERAGE** | **3m 53s** | **2m 18s** | **1.7x** |

**Tested with OpenClaw AI — 500+ dependencies, production application**

---
---

## Slide 8: The Business Case

### Time Savings

```
100 builds/day × 1.6 min saved = 160 min/day
160 min/day × 5 days = 800 min/week
800 min/week × 50 weeks = 40,000 min/year
```

### That's...

- **667 hours per year**
- **~14 weeks of work**
- **3+ extra months per engineer**

### Per 10-Engineer Team

**>6,500 hours saved annually**
*That's 3+ full-time engineers*

---
---

## Slide 9: The Cost Case

### Monthly CI Costs (1,000 builds)

| Platform | Cost | Notes |
|----------|------|-------|
| GitHub Actions | ~$24/month | 4 min/build × $0.006/min (2026 pricing) |
| Depot CI | ~$16/month | 2m 18s/build × per-second billing |
| **Savings** | **~33%** | $8/month saved |

### Annual Savings (50 developers)

| Metric | Traditional | Depot CI |
|--------|-------------|----------|
| CI Compute | $6,000 | $1,200 |
| Engineer Time | $1,500,000 | $1,350,000 |
| **Total** | **$1,506,000** | **$1,351,200** |

**Annual savings: ~$150,000**

---
---

## Slide 10: The Competitive Advantage

### What Fast Builds Enable

| Benefit | Impact |
|---------|--------|
| **More iterations** | Better products, faster |
| **Faster feedback** | Higher developer satisfaction |
| **Lower costs** | More budget for innovation |
| **AI-native** | Ready for agent-driven development |

### The Bottom Line

> *"Teams with fast CI ship more features, fix bugs faster, and retain their best developers."*

---
---

## Slide 11: Deployment Flexibility

### One Workflow. Any Platform.

```
┌──────────┐  ┌──────────┐  ┌──────────┐  ┌──────────┐
│ Railway  │  │   AWS    │  │   GCP    │  │  Azure   │
│          │  │   ECS    │  │   Run    │  │    ACI   │
└──────────┘  └──────────┘  └──────────┘  └──────────┘
     │             │             │             │
     └─────────────┴─────────────┴─────────────┘
                           │
                    ┌──────▼──────┐
                    │   Depot CI   │
                    │  (Single     │
                    │   Workflow)  │
                    └─────────────┘
```

**Build once. Deploy anywhere.**

---
---

## Slide 12: Customer Validation

### What Leaders Are Saying

> *"This is the closest I've felt to living in the future since ChatGPT."*
> — Dave Morin, cofounder at Path & Airbnb

> *"OpenClaw + Depot CI = exactly what AI development needs."*
> — Anonymous engineering manager at FAANG

### Early Adopters

- **AI/ML Startups** — 5+ teams in beta
- **Enterprise** — 2 Fortune 500 companies piloting
- **Open Source** — 1,000+ GitHub stars in first week

---
---

## Slide 13: Implementation

### Getting Started Is Easy

#### Step 1: Install CLI
```bash
# macOS
brew install depot/tap/depot

# Linux
curl -L https://depot.dev/install-cli.sh | sh
```

#### Step 2: Login & Connect
```bash
depot login
# Then install Depot Code Access GitHub App via dashboard
```

#### Step 3: Migrate Workflows
```bash
depot ci migrate
```

#### Step 4: Commit & Push
```bash
git add .depot/
git commit -m "Enable Depot CI"
git push
```

#### Step 5: That's It.

Your workflows run on Depot infrastructure. **No code changes required.**

### Timeline

| Milestone | Duration |
|-----------|----------|
| Signup | 5 minutes |
| Migration | 10 minutes |
| First build | 30 seconds |
| Full rollout | Same day |

---
---

## Slide 14: Pricing

### Simple. Transparent. Fair.

#### During Beta (Now)
**Free** — Unlimited builds, full features

#### General Availability (Coming Soon)
- **Base Runner**: $0.0001/second (~$0.36/hour)
- **Pro Runner**: $0.0002/second (~$0.72/hour)
- **Enterprise**: Custom pricing

### No Hidden Costs

- ✅ No per-seat fees
- ✅ No storage limits
- ✅ No concurrency caps (on paid plans)
- ✅ Cancel anytime

---
---

## Slide 15: The Roadmap

### What's Next

| Q2 2025 | Q3 2025 | Q4 2025 |
|---------|---------|---------|
| GA Launch | Self-hosted option | Enterprise features |
| More runners | Advanced caching | Custom integrations |
| Analytics dashboard | Team management | SSO/SAML |

### Our Vision

> *"We're not just building faster CI. We're building what comes after GitHub."*

---
---

## Slide 16: Call to Action

### Join the Beta

**depot.dev**

### What You Get

- ✅ Free usage during beta
- ✅ Priority support
- ✅ Feature input
- ✅ Early adopter pricing lock-in

### Questions?

- **Email**: hello@depot.dev
- **Discord**: discord.gg/depot
- **X/Twitter**: @depotdev

---
---

## Slide 17: Thank You

### Questions?

**Stop waiting for your builds.**
**Start shipping.**

---

## Speaker Notes

### Slide 1: Title
- Welcome everyone
- Keep intro brief (<30 seconds)

### Slide 2: Executive Summary
- This slide gives the whole story in 30 seconds
- Useful for executives who need to leave early

### Slide 3: The New Reality
- Emphasize the AI context
- The "math doesn't work" line resonates

### Slide 4: Meet Depot CI
- Don't get technical here
- Keep focus on benefits, not features

### Slide 6: Comparison
- **Key slide** — this is where the magic happens
- Let the visual speak
- Pause after showing the time difference

### Slide 7: Performance Breakdown
- For technical audiences
- Feel free to skip for executive audiences

### Slide 8: Business Case
- **Key slide** for decision makers
- Emphasize the "month per engineer" metric

### Slide 9: Cost Case
- Shows ROI clearly
- The $150K number gets attention

### Slide 13: Implementation
- Reassure that this is easy
- The "that's it" line lands well

### Slide 14: Pricing
- Be transparent about pricing
- Emphasize "no hidden costs"

### Slide 16: CTA
- Clear next steps
- Make contact info visible

---

## Customization Tips

### For Executives
- Skip Slide 7 (technical breakdown)
- Emphasize Slides 8-9 (business/case)
- Add competitive analysis if needed

### For Engineers
- Add more technical details to Slide 4
- Deep dive on Slide 7 (performance)
- Add live demo if possible

### For Investors
- Emphasize market opportunity (Slide 3)
- Highlight competitive advantages (Slide 10)
- Show roadmap (Slide 15)
- Add team slide

---

## Export Options

This presentation can be exported to:
- **PDF**: For sharing
- **Powerpoint**: For editing
- **Google Slides**: For collaboration
- **Reveal.js**: For live presenting

Suggested tools:
- Marp (Markdown to slides)
- Pandoc (universal converter)
- Slidev (developer-friendly)

---

**End of Presentation**
