# GitHub Secrets Configuration Guide

This guide explains how to configure the required GitHub secrets for the Depot CI demo workflows.

## Required Secrets

| Secret Name | Description | Source |
|-------------|-------------|--------|
| `DEPOT_TOKEN` | Depot API authentication token | Depot CLI or Dashboard |
| `DEPOT_PROJECT_ID` | Your Depot project identifier | `depot project list` |
| `RAILWAY_TOKEN` | Railway API authentication token | Railway CLI or Dashboard |
| `RAILWAY_PROJECT_ID` | Your Railway project identifier | Railway Dashboard |
| `RAILWAY_SERVICE_ID` | Your Railway service identifier | Railway Dashboard |

## Step-by-Step Setup

### 1. Get Depot Credentials

#### Option A: Using Depot CLI

```bash
# Install Depot CLI (if not installed)
curl -L https://depot.dev/install.sh | sh

# Login to Depot
depot login

# Get your token (after login)
depot token
```

#### Option B: Using Depot Dashboard

1. Go to [depot.dev](https://depot.dev)
2. Log in to your account
3. Navigate to Settings → API Tokens
4. Create a new token (or copy existing)
5. Save the token securely

#### Get Depot Project ID

```bash
# List your projects
depot project list

# Output format:
# PROJECT_ID    PROJECT_NAME    CREATED_AT
# abc123def456  openclaw-demo   2024-03-21
```

Copy the PROJECT_ID for your project.

### 2. Get Railway Credentials

#### Option A: Using Railway CLI

```bash
# Install Railway CLI
npm install -g @railway/cli

# Login to Railway
railway login

# Get your token
railway token
```

#### Option B: Using Railway Dashboard

1. Go to [railway.app](https://railway.app)
2. Log in to your account
3. Navigate to Account → API Tokens
4. Create a new token
5. Save the token securely

#### Get Railway Project and Service IDs

1. Go to your Railway project
2. The project ID is in the URL: `https://railway.app/project/<PROJECT_ID>`
3. Click on your service
4. The service ID is also in the URL: `https://railway.app/project/<PROJECT_ID>/service/<SERVICE_ID>`

### 3. Add Secrets to GitHub

1. Go to your repository on GitHub
2. Click **Settings** → **Secrets and variables** → **Actions**
3. Click **New repository secret**
4. Add each secret:

#### Adding `DEPOT_TOKEN`

| Field | Value |
|-------|-------|
| Name | `DEPOT_TOKEN` |
| Secret | `your_depot_token_here` |
| Environment | (leave empty for all environments) |

Click **Add secret**.

#### Adding `DEPOT_PROJECT_ID`

| Field | Value |
|-------|-------|
| Name | `DEPOT_PROJECT_ID` |
| Secret | `your_project_id_here` |

Click **Add secret**.

#### Adding `RAILWAY_TOKEN`

| Field | Value |
|-------|-------|
| Name | `RAILWAY_TOKEN` |
| Secret | `your_railway_token_here` |

Click **Add secret**.

#### Adding `RAILWAY_PROJECT_ID`

| Field | Value |
|-------|-------|
| Name | `RAILWAY_PROJECT_ID` |
| Secret | `your_railway_project_id_here` |

Click **Add secret**.

#### Adding `RAILWAY_SERVICE_ID`

| Field | Value |
|-------|-------|
| Name | `RAILWAY_SERVICE_ID` |
| Secret | `your_railway_service_id_here` |

Click **Add secret**.

### 4. Verify Configuration

After adding all secrets, you should see:

```
Actions secrets
├── DEPOT_TOKEN              ••••••••••
├── DEPOT_PROJECT_ID         ••••••••••
├── RAILWAY_TOKEN            ••••••••••
├── RAILWAY_PROJECT_ID       ••••••••••
└── RAILWAY_SERVICE_ID       ••••••••••
```

## Troubleshooting

### Workflow Fails with "Authentication Failed"

- Verify all secret names match exactly (case-sensitive)
- Ensure tokens are valid and not expired
- Re-generate tokens if needed

### Workflow Fails with "Project Not Found"

- Double-check project IDs are correct
- Verify the project exists in your Depot/Railway account
- Ensure you have permissions to access the project

### Token Has Expired

Regenerate the token:
```bash
# Depot
depot token --refresh

# Railway
railway token
```

Then update the GitHub secret with the new value.

## Security Best Practices

1. **Never commit secrets to git** - Always use GitHub Secrets
2. **Rotate tokens regularly** - Update secrets when rotating tokens
3. **Use minimum required permissions** - Don't use admin tokens if not needed
4. **Monitor token usage** - Check for unauthorized access
5. **Revoke unused tokens** - Clean up old tokens from dashboards

## Quick Reference Commands

```bash
# Depot
depot login                    # Authenticate
depot token                    # Get API token
depot project list             # List projects
depot status                   # Check status

# Railway
railway login                  # Authenticate
railway token                  # Get API token
railway projects               # List projects
railway status                 # Check status
railway link                   # Get project/service URLs
```

---

After configuring all secrets, you're ready to run the workflows!
