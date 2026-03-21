# Depot + Railway Setup Guide

This guide walks you through setting up the complete Depot CI showcase demo.

## Prerequisites

| Tool | Minimum Version | Install Link |
|------|----------------|--------------|
| Node.js | 18.x | https://nodejs.org |
| npm | 9.x | Included with Node.js |
| Docker | 20.x | https://docker.com |
| Git | 2.x | https://git-scm.com |

## Quick Start

### 1. Clone and Install

```bash
git clone https://github.com/YOUR_ORG/depot-railway-build.git
cd depot-railway-build

# Run setup script
chmod +x scripts/setup.sh
./scripts/setup.sh
```

### 2. Create Depot Account

1. Go to [depot.dev](https://depot.dev)
2. Click "Get Started" or "Sign Up"
3. Choose GitHub authentication (recommended)
4. Authorize the Depot GitHub app
5. Create a new project: `openclaw-demo`

**Get your credentials:**
```bash
# After signup, get your token
depot login

# Create a project
depot project create openclaw-demo

# Note the project ID for GitHub secrets
depot project list
```

### 3. Create Railway Project

1. Go to [railway.app](https://railway.app)
2. Click "New Project"
3. Select "Deploy from Dockerfile"
4. Connect your GitHub repository
5. Add environment variables:
   - `NODE_ENV=production`
   - `PORT=3000`
   - `ANTHROPIC_API_KEY=your_key_here` (optional for demo)

**Get your credentials:**
```bash
# Install Railway CLI
npm install -g @railway/cli

# Login
railway login

# Initialize project
railway init

# Note the project and service IDs
railway status
```

### 4. Configure GitHub Secrets

Go to your GitHub repository → Settings → Secrets and Variables → Actions

Add the following secrets:

| Secret Name | Description | How to Get |
|-------------|-------------|------------|
| `DEPOT_TOKEN` | Depot API token | `depot token` or Depot dashboard |
| `DEPOT_PROJECT_ID` | Your Depot project ID | `depot project list` |
| `RAILWAY_TOKEN` | Railway API token | `railway token` |
| `RAILWAY_PROJECT_ID` | Your Railway project ID | `railway link` |
| `RAILWAY_SERVICE_ID` | Your Railway service ID | Railway dashboard URL |

### 5. Run Workflows

#### Baseline (GitHub Actions)

```bash
# Trigger the baseline workflow
git push origin main
# Or manually: GitHub → Actions → railway-direct.yml → Run workflow
```

#### Depot CI

```bash
# First, migrate your workflows to Depot CI
depot ci migrate

# Commit the generated .depot/ directory
git add .depot/
git commit -m "Add Depot CI configuration"
git push origin main
```

## Verification

### Check Depot Setup

```bash
# Verify Depot CLI
depot --version
depot status

# List projects
depot project list

# Test build
cd sample-app
depot build -t test .
```

### Check Railway Setup

```bash
# Verify Railway CLI
railway --version

# List projects
railway projects

# Check deployment
railway logs
```

### Test Sample App Locally

```bash
cd sample-app
npm install
npm run build
npm start

# Test with curl
curl http://localhost:3000/health
curl http://localhost:3000/skills
```

## Troubleshooting

### Depot Issues

**Problem**: `depot: command not found`
```bash
# Install Depot CLI
curl -L https://depot.dev/install.sh | sh

# Add to PATH
export PATH=$PATH:$HOME/.depot/bin

# Verify
depot --version
```

**Problem**: Authentication failed
```bash
# Re-authenticate
depot login --token YOUR_TOKEN

# Or use environment variable
export DEPOT_TOKEN=YOUR_TOKEN
```

### Railway Issues

**Problem**: `railway: command not found`
```bash
# Install via npm
npm install -g @railway/cli

# Or install script
curl -sSL https://railway.app/install.sh | sh
```

**Problem**: Deployment fails
```bash
# Check logs
railway logs

# Verify service is running
railway status

# Redeploy
railway up
```

### GitHub Actions Issues

**Problem**: Workflow fails immediately
- Check all secrets are configured correctly
- Verify secret names match exactly (case-sensitive)
- Check GitHub Actions runner has permissions

**Problem**: Depot CI workflow fails
- Verify Depot project ID is correct
- Check `depot ci migrate` was run
- Ensure `.depot/` directory is committed

## Next Steps

1. ✅ Run baseline workflow
2. ✅ Run Depot CI workflow
3. ⏳ Compare results
4. ⏳ Document findings
5. ⏳ Create demo video

---

For more help:
- [Depot Documentation](https://depot.dev/docs)
- [Railway Documentation](https://docs.railway.app)
- [GitHub Actions Documentation](https://docs.github.com/actions)
