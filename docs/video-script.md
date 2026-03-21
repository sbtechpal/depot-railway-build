# Depot CI Demo Video Script

**Title**: "Depot CI: 40x Faster Builds for AI Development"
**Duration**: 3:45
**Format**: 16:9 (1920x1080)
**Style**: Screen recording + voiceover with motion graphics overlays

---

## Script Legend

| Symbol | Meaning |
|--------|---------|
| `[VISUAL]` | On-screen graphics/text |
| `[SCREEN]` | Screen recording action |
| `[CAMERA]` | Camera angle or movement |
| `[SOUND]` | Sound effect or music cue |
| `[PAUSE]` | Brief pause for emphasis |
| `( )` | Optional/directional notes |

---

## Section 1: The Problem (0:00 - 0:45)

### 0:00 - 0:15 | Opening Hook

**[VISUAL]** Dark screen, text fades in: *"In the AI-augmented development era..."*

**[SOUND]** Subtle, building tech ambient music starts

**[VOICEOVER]**
"In the AI-augmented development era... writing code is no longer the bottleneck."

**[VISUAL]** Text continues: *"...integrating it is."*

**[VOICEOVER]**
"Integrating it is."

---

### 0:15 - 0:30 | The Reality Check

**[VISUAL]** Montage:
- Developer typing furiously
- CI progress bar: "Building... 15 min remaining"
- Clock spinning, timestamps flying by

**[VOICEOVER]**
"With AI agents like Claude Code and Cursor, a team of 10 engineers can now produce output like 100."

**[VISUAL]** Chart: Code volume line going up sharply, CI performance line staying flat

**[VOICEOVER]**
"But traditional CI systems? They were built for a different world."

---

### 0:30 - 0:45 | The Pain

**[SCREEN]** GitHub Actions workflow running slowly:
- "Setup Node.js" (30s)
- "Install dependencies" (2m 15s)
- "Build" (1m 45s)
- Timer at 4:32 and still going

**[VOICEOVER]**
"GitHub Actions. CircleCI. Buildkite. Great tools, but they're architecturally wrong for this moment."

**[VISUAL]** Frustrated developer at desk, head in hands

**[VOICEOVER]**
"15-minute pipelines were annoying. Now? They're crippling."

---

## Section 2: The Solution (0:45 - 1:30)

### 0:45 - 1:00 | Introducing Depot CI

**[VISUAL]** Clean white screen, Depot logo animates in

**[SOUND]** Subtle "whoosh" logo sound, music becomes more optimistic

**[VISUAL]** Tagline appears: *"40x Faster Builds"*

**[VOICEOVER]**
"Meet Depot CI. A programmable CI engine built with performance as a first-class citizen."

---

### 1:00 - 1:15 | How It Works

**[VISUAL]** Animated diagram:
```
┌─────────┐    ┌──────────────┐    ┌─────────┐
│  Code   │───▶│  Depot CI    │───▶│ Deployed│
└─────────┘    └──────────────┘    └─────────┘
                    │
        ┌───────────┼───────────┐
        ▼           ▼           ▼
    ┌───────┐  ┌───────┐  ┌───────┐
    │ Cache │  │ Scale │  │ Fast  │
    └───────┘  └───────┘  └───────┘
```

**[VOICEOVER]**
"Depot CI isn't just faster — it's built differently. Intelligent caching that learns across every build. Distributed compute that scales when you need it. An orchestrator designed for modern workloads."

---

### 1:15 - 1:30 | Compatibility

**[VISUAL]** GitHub logo + Depot logo, connection line between them

**[VISUAL]** Text: *"Your Workflows. Faster."*

**[VOICEOVER]**
"Already using GitHub Actions? Bring your workflows. We run them faster, more reliably. Same YAML, better performance."

**[VISUAL]** Side-by-side workflow files (identical), different execution speeds

**[VOICEOVER]**
"No rewrite. No migration project. Just speed."

---

## Section 3: The Demo (1:30 - 3:00)

### 1:30 - 1:45 | Introducing OpenClaw

**[SCREEN]** OpenClaw website (openclaw.ai)

**[VOICEOVER]**
"To show you what Depot CI can do, we're using OpenClaw."

**[VISUAL]** Scroll through testimonials:
- Andrej Karpathy
- Nat Eliason
- "iPhone moment"
- "Early AGI"

**[VOICEOVER]**
"OpenClaw is a personal AI assistant that's taking the tech world by storm. It runs on your own hardware. It works through WhatsApp, Telegram, Discord. It's the future of personal AI."

---

### 1:45 - 2:00 | The Tech Stack

**[SCREEN]** VS Code showing the sample app:
- TypeScript files
- Dependencies in package.json
- Dockerfile

**[VOICEOVER]**
"And it's exactly the kind of application that benefits from Depot CI. Node.js, TypeScript, dozens of dependencies, complex Docker builds."

**[VISUAL]** File count animation: "15 dependencies", "Multi-stage Docker", "TypeScript compilation"

**[VOICEOVER]**
"The kind of build that makes traditional CI sweat."

---

### 2:00 - 2:40 | The Comparison ⭐

**[VISUAL]** Split screen appears:

```
┌─────────────────────┬─────────────────────┐
│   GITHUB ACTIONS     │      DEPOT CI        │
│    (Baseline)        │      (Showcase)      │
├─────────────────────┼─────────────────────┤
│  [SCREEN RECORDING]  │  [SCREEN RECORDING]  │
│                     │                     │
│  Starting...        │  Starting...        │
└─────────────────────┴─────────────────────┘
```

**[VOICEOVER]**
"Let's compare. On the left: traditional GitHub Actions. On the right: Depot CI. Same code, same destination, different infrastructure."

**[SCREEN]** Both workflows start simultaneously

**[TIMERS APPEAR]**
```
GitHub Actions: 0:00 ───────────────────
Depot CI:       0:00 ───────────────────
```

**[VOICEOVER]**
"Both workflows start now..."

**[TIME LAPSE - 5 seconds real-time)**

**[SCREEN UPDATE]**
```
GitHub Actions: 0:45 ▓▓░░░░░░░░░░░ Installing dependencies...
Depot CI:       0:08 ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓ COMPLETE
```

**[VOICEOVER]**
"Watch this. GitHub Actions is still installing dependencies. Depot CI? Already done."

**[SOUND]** Subtle "ding" when Depot CI completes

---

### 2:40 - 2:55 | The Results

**[VISUAL]** Both screens show green checkmarks

**[VISUAL]** Final times animate in:

```
┌─────────────────────┬─────────────────────┐
│   GITHUB ACTIONS     │      DEPOT CI        │
├─────────────────────┼─────────────────────┤
│                     │                     │
│      ✓ SUCCESS      │      ✓ SUCCESS      │
│                     │                     │
│   Time: 4:32        │   Time: 0:28        │
│                     │                     │
└─────────────────────┴─────────────────────┘
```

**[SOUND]** Success chime

**[VOICEOVER]**
"The result? GitHub Actions: 4 minutes and 32 seconds. Depot CI: 28 seconds."

**[PAUSE - 2 seconds]**"

**[VOICEOVER]**
"That's not just faster — that's fundamentally different."

---

### 2:55 - 3:00 | The Impact Statement

**[VISUAL]** Both deployments show "Service live at..." URLs

**[VOICEOVER]**
"Both deployed successfully. The difference? With Depot CI, you've already moved on to your next feature."

---

## Section 4: The Value (3:00 - 3:45)

### 3:00 - 3:15 | Time Savings

**[VISUAL]** Animated calculation:

```
10 builds/day × 4 min saved = 40 min/day
40 min/day × 5 days = 200 min/week
```

**[VISUAL]** Text: *"That's an extra morning every week."*

**[VOICEOVER]**
"What does this mean for your team? If you do 10 builds a day, that's nearly an hour saved. Every single day."

**[VISUAL]** Calendar animation showing extra time appearing

**[VOICEOVER]**
"An extra morning, every week. What would your team do with that time?"

---

### 3:15 - 3:30 | Cost Savings

**[VISUAL]** Cost comparison chart:

```
Traditional CI:  $██████████ ($100/month)
Depot CI:        $██░░░░░░░░░ ($20/month)

Savings: 80%
```

**[VOICEOVER]**
"And it's not just time — it's money. 80% reduction in CI compute costs. That's real dollars back in your budget."

**[VISUAL]** Money animation (coins falling into piggy bank)

**[VOICEOVER]**
"Dollars you can spend on... anything else."

---

### 3:30 - 3:45 | The Bigger Picture

**[VISUAL]** Happy developer, multiple deployments flying by

**[VOICEOVER]**
"Fast builds mean more iterations. More iterations mean better products. Better products mean happier customers and more successful teams."

**[VISUAL]** Team celebrating, shipping confetti

**[VOICEOVER]**
"This is what development was supposed to feel like."

---

## Section 5: Call to Action (3:45 - 4:15)

### 3:45 - 4:00 | Join the Beta

**[VISUAL]** Depot CI interface, beautiful and clean

**[VOICEOVER]**
"Depot CI is in beta right now, and we're looking for teams ready to build at the speed of AI."

**[VISUAL]** "Try it free" badge appears

**[VOICEOVER]**
"That means free usage during the beta period. No credit card required."

---

### 4:00 - 4:15 | Final CTA

**[VISUAL]** Large URL: **depot.dev**

**[VISUAL]** Social handles:
- X: @depotdev
- Discord: discord.gg/depot
- GitHub: github.com/depot

**[VOICEOVER]**
"Visit depot.dev to join the beta. Follow us @depotdev for updates."

**[VISUAL]** Final tagline appears:

**[SOUND]** Music swells briefly then fades

> *"Stop waiting for your builds."*
> *"Start shipping."*
> *"Depot CI"*

**[SOUND]** Clean closing chord

---

## Recording Notes

### Screen Recording Tips

| Tip | Details |
|-----|---------|
| **Resolution** | Record at 1080p or higher |
| **Mouse movement** | Smooth, deliberate motions |
| **Highlighting** | Use subtle highlights for key areas |
| **Timing** | The comparison section needs to feel real — don't fake it |
| **Pacing** | Allow slight pauses after key statements |

### Voiceover Guidelines

| Element | Guidance |
|---------|----------|
| **Tone** | Professional but approachable |
| **Pace** | 140-150 words per minute |
| **Emphasis** | Bold words should be emphasized |
| **Pauses** | Marked [PAUSE] are ~1 second |
| **Energy** | Increase slightly during the demo section |

### Post-Production Checklist

- [ ] Sync voiceover perfectly with visuals
- [ ] Add subtle sound effects at key moments
- [ ] Ensure music doesn't compete with voiceover
- [ ] Color grade for consistency
- [ ] Add closed captions
- [ ] Export in multiple formats
- [ ] Create eye-catching thumbnail

---

## Alternative Closings

### Option A: Direct
*"Visit depot.dev and start building faster today."*

### Option B: Vision
*"The future of CI is here. Don't get left behind."*

### Option C: Challenge
*"What would you build with an extra hour every day?"*

---

## Quick Reference for Recording

| Section | Time | Key Visual | Key Line |
|---------|------|------------|----------|
| Problem | 0:00 | Slow CI, frustrated dev | "Integrating is the bottleneck" |
| Solution | 0:45 | Depot logo, diagram | "40x faster builds" |
| Demo | 1:30 | Split screen comparison | "4:32 vs 0:28" |
| Value | 3:00 | Time/money savings | "Extra morning every week" |
| CTA | 3:45 | depot.dev URL | "Stop waiting. Start shipping." |

---

**End of Script**
