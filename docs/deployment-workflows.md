# Deployment Workflows Guide

This guide explains the additional deployment workflows available for the Depot CI demo.

## Available Workflows

| Platform | Workflow File | Description |
|----------|---------------|-------------|
| **Railway** | `.github/workflows/depot-ci.yml` | Original Railway deployment |
| **AWS ECS** | `.github/workflows/depot-ci-aws.yml` | Amazon Elastic Container Service |
| **Google Cloud Run** | `.github/workflows/depot-ci-gcp.yml` | Google Cloud Platform |
| **Azure ACI** | `.github/workflows/depot-ci-azure.yml` | Azure Container Instances |
| **Fly.io** | `.github/workflows/depot-ci-fly.yml` | Fly.io platform |

## Workflow Comparison

| Platform | Setup Complexity | Cold Start | Scaling | Pricing |
|----------|------------------|------------|---------|---------|
| Railway | ⭐ Very Easy | ~30s | Auto | $5-50/mo |
| AWS ECS | ⭐⭐⭐ Medium | ~1m | Auto | Pay-per-use |
| GCP Cloud Run | ⭐⭐ Easy | ~30s | Auto | Pay-per-use |
| Azure ACI | ⭐⭐⭐ Medium | ~1m | Manual | Pay-per-use |
| Fly.io | ⭐⭐ Easy | ~20s | Manual | $5-50/mo |

## Required Secrets by Platform

### Railway (Original)

| Secret | Description |
|--------|-------------|
| `DEPOT_TOKEN` | Depot API token |
| `DEPOT_PROJECT_ID` | Depot project ID |
| `RAILWAY_TOKEN` | Railway API token |
| `RAILWAY_PROJECT_ID` | Railway project ID |
| `RAILWAY_SERVICE_ID` | Railway service ID |

### AWS ECS

| Secret | Description |
|--------|-------------|
| `DEPOT_TOKEN` | Depot API token |
| `DEPOT_PROJECT_ID` | Depot project ID |
| `AWS_ACCESS_KEY_ID` | AWS access key |
| `AWS_SECRET_ACCESS_KEY` | AWS secret key |

### Google Cloud Run

| Secret | Description |
|--------|-------------|
| `DEPOT_TOKEN` | Depot API token |
| `DEPOT_PROJECT_ID` | Depot project ID |
| `GCP_PROJECT_ID` | GCP project ID |
| `GCP_SA_KEY` | Service account key (JSON) |

### Azure ACI

| Secret | Description |
|--------|-------------|
| `DEPOT_TOKEN` | Depot API token |
| `DEPOT_PROJECT_ID` | Depot project ID |
| `AZURE_CREDENTIALS` | Azure service principal (JSON) |
| `ACR_REGISTRY` | Azure Container Registry URL |

### Fly.io

| Secret | Description |
|--------|-------------|
| `DEPOT_TOKEN` | Depot API token |
| `DEPOT_PROJECT_ID` | Depot project ID |
| `FLY_API_TOKEN` | Fly.io API token |

## Platform-Specific Setup

### AWS ECS

#### Prerequisites
1. AWS Account with ECS access
2. EC2 or Fargate cluster
4. ECR repository

#### Quick Setup
```bash
# Create ECR repository
aws ecr create-repository --repository-name openclaw-demo

# Create ECS cluster
aws ecs create-cluster --cluster-name depot-demo-cluster

# Create task definition (see sample-app/aws/task-definition.json)
aws ecs register-task-definition --cli-input-json file://task-definition.json

# Create service
aws ecs create-service \
  --cluster depot-demo-cluster \
  --service-name openclaw-demo \
  --task-definition openclaw-demo \
  --desired-count 1
```

#### Environment Variables
```bash
export AWS_REGION=us-east-1
export ECS_CLUSTER=depot-demo-cluster
export ECS_SERVICE=openclaw-demo
```

### Google Cloud Run

#### Prerequisites
1. GCP project with Cloud Run enabled
2. Artifact Registry (or GCR)
3. Service account with appropriate permissions

#### Quick Setup
```bash
# Enable APIs
gcloud services enable run.googleapis.com
gcloud services enable artifactregistry.googleapis.com

# Create repository
gcloud artifacts repositories create openclaw-demo \
  --repository-format=docker \
  --location=us-central1

# Deploy to Cloud Run
gcloud run deploy openclaw-demo \
  --source ./sample-app \
  --platform managed \
  --region us-central1 \
  --allow-unauthenticated
```

#### Environment Variables
```bash
export GCP_PROJECT_ID=your-project-id
export GCP_REGION=us-central1
```

### Azure ACI

#### Prerequisites
1. Azure account
2. Container Registry
3. Resource group

#### Quick Setup
```bash
# Create resource group
az group create --name depot-demo-rg --location eastus

# Create container registry
az acr create --resource-group depot-demo-rg \
  --name depotdemoacr --sku Basic

# Build and push image
az acr build --registry depotdemoacr \
  --image openclaw-demo ./sample-app
```

#### Environment Variables
```bash
export AZURE_RESOURCE_GROUP=depot-demo-rg
export AZURE_LOCATION=eastus
export ACR_REGISTRY=depotdemoacr.azurecr.io
```

### Fly.io

#### Prerequisites
1. Fly.io account
2. `flyctl` CLI installed

#### Quick Setup
```bash
# Install flyctl
curl -L https://fly.io/install.sh | sh

# Login
flyctl auth login

# Create app
flyctl apps create openclaw-demo

# Deploy
flyctl deploy ./sample-app
```

#### Environment Variables
```bash
export FLY_APP_NAME=openclaw-demo
```

## Switching Between Deployments

To change deployment target, update your workflow trigger:

```yaml
on:
  push:
    branches: [main]
  workflow_dispatch:
    inputs:
      target:
        description: 'Deployment target'
        required: true
        type: choice
        options:
          - railway
          - aws
          - gcp
          - azure
          - fly
```

Or simply rename the workflow file to make it the default:
```bash
mv .github/workflows/depot-ci-aws.yml .github/workflows/depot-ci.yml
```

## Troubleshooting

### AWS ECS

**Problem**: Task definition fails
```bash
# Validate task definition
aws ecs validate-task-definition --cli-input-json file://task-definition.json
```

**Problem**: Service won't start
```bash
# Check service events
aws ecs describe-services --cluster depot-demo-cluster --services openclaw-demo
```

### Google Cloud Run

**Problem**: Authentication fails
```bash
# Re-authenticate
gcloud auth login
gcloud auth configure-docker gcr.io
```

**Problem**: Deployment fails
```bash
# Check logs
gcloud logs tail /projects/$PROJECT_ID/logs/cloudrun.googleapis.com%2Fopenclaw-demo
```

### Azure ACI

**Problem**: Container won't start
```bash
# Check logs
az container logs --resource-group depot-demo-rg --name openclaw-demo
```

**Problem**: IP not accessible
```bash
# Check container state
az container show --resource-group depot-demo-rg --name openclaw-demo
```

### Fly.io

**Problem**: Deploy fails
```bash
# Check app status
flyctl status --app openclaw-demo

# View logs
flyctl logs --app openclaw-demo
```

## Performance Comparison

All workflows should show similar Depot CI performance improvements:

| Metric | Traditional CI | Depot CI | Speedup |
|--------|----------------|----------|---------|
| Build time | 4-7 min | 20-60s | **5-10x** |
| Deploy time | 1-2 min | 20-40s | **2-3x** |
| Total time | 5-9 min | 40-100s | **5-8x** |

---

For more information, see:
- [Depot Documentation](https://depot.dev/docs)
- [AWS ECS Guide](https://docs.aws.amazon.com/ecs/)
- [Google Cloud Run Guide](https://cloud.google.com/run/docs)
- [Azure ACI Guide](https://docs.microsoft.com/azure/container-instances/)
- [Fly.io Guide](https://fly.io/docs/)
