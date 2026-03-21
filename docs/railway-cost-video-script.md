# Stop Overpaying Railway for Builds

**Title**: "Stop Overpaying Railway for Builds"
**Duration**: 90 seconds
**Format**: 16:9 (1920x1080)
**Style**: Screen recording + voiceover with Railway dashboard focus

---

## Script Legend

| Symbol | Meaning |
|--------|---------|
| `[VISUAL]` | On-screen graphics/text |
| `[SCREEN]` | Screen recording action |
| `[SOUND]` | Sound effect or music cue |
| `[HIGHLIGHT]` | Area to highlight on screen |
| `[COST]` | Cost calculation display |

---

## Section 1: The Problem (0:00 - 0:20)

### 0:00 - 0:10 | The Hidden Cost

**[SCREEN]** Railway dashboard showing:
- Project overview
- Credit balance: $5.00
- "Builds consume resources" notice

**[VOICEOVER]**
"Railway is amazing for deployment. But did you know every time you push code..."

**[SCREEN]** Click "New Deployment" → Build starts
Build progress bar appears, timer counting up

**[VOICEOVER]**
"...you're paying Railway to build your code?"

---

### 0:10 - 0:20 | The Meter Running

**[SCREEN]** Zoom in on Railway build progress:
```
Building...
├─ Installing dependencies... 45s
├─ Building application...     90s
└─ Deploying...               30s
Total: 2m 45s
```

**[HIGHLIGHT]** The cost meter incrementing: $0.02 → $0.03 → $0.04...

**[VOICEOVER]**
"That build just took nearly 3 minutes. And it cost you about 5 cents. Doesn't sound like much, right?"

---

## Section 2: Do the Math (0:20 - 0:40)

### 0:20 - 0:30 | Multiply It Out

**[VISUAL]** Animated calculation:

```
1 build  = $0.05
10 builds = $0.50
100 builds = $5.00
─────────────────────
Your monthly $5 credit? Gone.
```

**[VOICEOVER]**
"But if you deploy 10 times a day? That's $1.50. $45 a month. Your entire $5 credit? Gone in 100 builds."

**[VISUAL]** Calendar showing red X's when credits run out

**[VOICEOVER]**
"And once credits are gone? You're paying full price."

---

### 0:30 - 0:40 | The Opportunity Cost

**[VISUAL]** Split screen:
- Left: Railway build meter spinning
- Right: "$$$" flying away

**[VOICEOVER]**
"Here's the thing: Railway's compute is expensive for building. You're paying premium prices for something that should be fast, cheap, and automated."

---

## Section 3: The Solution (0:40 - 1:10)

### 0:40 - 0:50 | Enter Depot CI

**[VISUAL]** Clean transition to Depot interface

**[SOUND]** Upbeat, optimistic music

**[VOICEOVER]**
"Enter Depot CI. Build your code elsewhere, then deploy to Railway."

**[SCREEN]** Show Depot build process:
```
Depot CI Build...
├─ Dependencies (cached)   5s  ✓
├─ TypeScript (cached)     3s  ✓
├─ Docker (cached)         8s  ✓
└─ Push to Depot          2s  ✓
Total: 18 seconds
```

**[VOICEOVER]**
"Same code. Same result. But 18 seconds instead of 3 minutes."

---

### 0:50 - 1:00 | Deploy to Railway

**[SCREEN]** Railway deployment:
```
Deploying to Railway...
├─ Pull image              5s
├─ Health check            5s
└─ Live                    ✓
Total: 10 seconds
```

**[HIGHLIGHT]** Railway cost meter barely moves: $0.01

**[VOICEOVER]**
"Then deploy the pre-built image to Railway in 10 seconds. Total cost? One penny."

---

### 1:00 - 1:10 | Side-by-Side Comparison

**[VISUAL]** Full comparison:

```
┌─────────────────────┬─────────────────────┐
│   BUILD ON RAILWAY   │   DEPOT → RAILWAY   │
├─────────────────────┼─────────────────────┤
│                     │                     │
│   Time: 2:45        │   Time: 0:28        │
│   Cost: $0.05       │   Cost: $0.01       │
│                     │                     │
│   ✓ SAME RESULT     │   ✓ SAME RESULT     │
│                     │                     │
└─────────────────────┴─────────────────────┘
```

**[SOUND]** Cha-ching! (success sound)

**[VOICEOVER]**
"Same deployment. 8x cheaper. 6x faster. That's not an optimization — that's a no-brainer."

---

## Section 4: The Impact (1:10 - 1:25)

### 1:10 - 1:20 | Monthly Savings

**[VISUAL]** Savings calculator:

```
Monthly Deployment Cost Comparison (100 builds)

Building on Railway:  $████████████ $5.00
Depot → Railway:      $██░░░░░░░░░░░░ $0.60

Monthly Savings: $4.40
Annual Savings:  $52.80
```

**[VOICEOVER]**
"For a typical team, that's $50 a year. For a single developer. Scale that up? You're saving hundreds, maybe thousands."

---

### 1:20 - 1:25 | The Bigger Picture

**[VISUAL]** Happy developer, money staying in pocket

**[VOICEOVER]**
"Railway is amazing for RUNNING your apps. Let Depot handle BUILDING them."

---

## Section 5: Call to Action (1:25 - 1:30)

### 1:25 - 1:30 | Get Started

**[VISUAL]** Large URL and buttons:

```
depot.dev

[ Join the Free Beta ]

Build faster. Deploy to Railway. Save money.
```

**[SOUND]** Music swells briefly then fades

**[VOICEOVER]**
"Stop overpaying Railway for builds. Start using Depot CI. Visit depot.dev today."

---

## Key Visual Assets Needed

| Asset | Description | When Used |
|-------|-------------|-----------|
| Railway dashboard | Screen recording of build in progress | 0:00-0:20 |
| Cost animation | Money counter incrementing | 0:10-0:20 |
| Calculator animation | $0.05 × 100 = $5.00 | 0:20-0:40 |
| Depot build screen | Fast Depot CI build | 0:40-0:50 |
| Deployment screen | Quick Railway deployment | 0:50-1:00 |
| Comparison table | Side-by-side metrics | 1:00-1:10 |
| Savings chart | Monthly/annual savings | 1:10-1:20 |

---

## Production Notes

### Screen Recording Tips

1. **Railway Dashboard**
   - Use a project with visible credit balance
   - Start with ~$4.50 to show impact
   - Ensure build is complex enough to take 2-3 minutes

2. **Cost Visibility**
   - Highlight the cost meter in Railway
   - Use red color for costs, green for savings

3. **Timing**
   - Don't speed up the Railway build — real pain is important
   - DO speed up Depot build to show contrast

### Audio Guidelines

| Section | Tone | Key Words to Emphasize |
|---------|------|----------------------|
| Problem | Concern | "paying", "every time", "expensive" |
| Solution | Optimistic | "fast", "cheap", "18 seconds" |
| Comparison | Confident | "8x cheaper", "no-brainer" |
| CTA | Direct | "stop", "start", "today" |

---

## Alternative Endings

### Option A: Direct
*"Railway for running. Depot for building. Your wallet will thank you."*

### Option B: Question
*"How much are you paying Railway to build your code? Find out. Then fix it with Depot CI."*

### Option C: Challenge
*"100 free deployments per month vs 5. Which would you choose?"*

---

## Thumbnail Suggestions

```
┌─────────────────────────────────────┐
│                                     │
│     RAILWAY BUILDS COST $$$        │
│            vs                      │
│        DEPOT CI = $                │
│                                     │
│    Stop Overpaying. Start Saving.  │
│                                     │
└─────────────────────────────────────┘
```

Or:

```
┌─────────────────────────────────────┐
│                                     │
│   $5.00    →    $0.60              │
│  Railway       Depot + Railway      │
│   Builds          Builds           │
│                                     │
│     Save 88% on Deployments        │
│                                     │
└─────────────────────────────────────┘
```

---

## Distribution Plan

| Platform | Format | Title |
|----------|--------|-------|
| YouTube | 1080p | "Stop Overpaying Railway for Builds" |
| Twitter/X | 720p, 60s cut | "Railway Builds Are Costing You" |
| LinkedIn | 1080p | "Optimize Your Railway Deployments" |
| Reddit | 1080p | "TIL Railway Builds Cost Money" |

---

## Hashtags & SEO

**Keywords**: Railway, Depot CI, DevOps, cost savings, cloud costs, deployment optimization

**Hashtags**: #Railway #DepotCI #DevOps #CloudCosts #SaveMoney #DeveloperTools

---

## Title & Description for Upload

**Title**: Stop Overpaying Railway for Builds | Save 88% with Depot CI

**Description**:
```
Did you know Railway charges you to build your code?

Every time you push, Railway uses their (expensive) compute to:
- Install dependencies
- Build your application
- Run tests
- Deploy

That 3-minute build just cost you 5 cents. 100 builds? $5. Your entire monthly credit? Gone.

There's a better way:
1. Build with Depot CI (18 seconds, $0.01)
2. Deploy to Railway (10 seconds, $0.01)
3. Save 88% on deployment costs

Same result. 8x cheaper. 6x faster.

Railway is amazing for RUNNING apps. Let Depot handle BUILDING them.

🚀 Get started free: depot.dev

#Railway #DepotCI #DevOps #CloudCosts #SaveMoney
```

---

**End of Script**
