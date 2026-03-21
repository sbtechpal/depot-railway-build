# 🦞 OpenClaw Demo

A demonstration app showcasing Depot CI capabilities with a personal AI assistant inspired by [OpenClaw](https://openclaw.ai/).

## What This Demonstrates

This sample application showcases how **Depot CI** accelerates AI/ML application development with:

- **40x faster builds** through intelligent caching
- **GitHub Actions compatible** workflows
- **Seamless Railway deployment** integration

## Features

- 🤖 **Personal AI Assistant** with extensible skills system
- 📧 **Email Management** skill
- 📅 **Calendar Management** skill
- ⏰ **Reminders** skill
- 🔍 **Web Search** skill
- 🔌 **Plugin Architecture** for easy skill development

## Quick Start

```bash
# Install dependencies
npm install

# Build the application
npm run build

# Run locally
npm start

# Or with Docker
docker build -t openclaw-demo .
docker run -p 3000:3000 openclaw-demo
```

## API Endpoints

| Endpoint | Method | Description |
|----------|--------|-------------|
| `/health` | GET | Health check |
| `/skills` | GET | List available skills |
| `/message` | POST | Process a message with AI |

## Tech Stack

- **Runtime**: Node.js 18+
- **Language**: TypeScript
- **AI Models**: Claude (Anthropic), GPT-4 (OpenAI)
- **Deployment**: Railway
- **CI/CD**: Depot CI

## Depot CI Integration

This demo includes:
- `.github/workflows/` — GitHub Actions baseline workflow
- `.depot/` — Depot CI configuration (generated)

## License

MIT

---

**Built to showcase Depot CI — 40x faster builds for the AI-augmented development era.**
