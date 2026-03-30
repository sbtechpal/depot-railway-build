# Depot CI Authentication with GitHub Actions

This guide explains how to authenticate Depot CI with GitHub Actions using OIDC (recommended) or static tokens.

---

## Recommended: OIDC (No Token Required)

The best approach for GitHub Actions is to use an OIDC trust relationship — this avoids storing any static secrets.

### Step 1: Set up an OIDC Trust Relationship

1. Go to your **Depot Projects** page in the dashboard
2. Click on your project → **Settings**
3. Under **Trust Relationships**, click **Add trust relationship**
4. Select **GitHub** as the provider
5. Enter your GitHub user or organization name
6. Enter the repository name (exact match, not the full URL)
7. Click **Add trust relationship**

### Step 2: Add permissions to your workflow

Add the `permissions` block to your job so GitHub can issue the OIDC token:

```yaml
jobs:
  build:
    runs-on: ubuntu-latest
    permissions:
      contents: read
      id-token: write  # Required for OIDC
    steps:
      - uses: actions/checkout@v4
      - uses: depot/setup-action@v1
      - uses: depot/build-push-action@v1
        with:
          project: <your-depot-project-id>
          context: .
```

**No `DEPOT_TOKEN` secret needed!** Depot authenticates automatically via OIDC.

---

## Alternative: Static Token (Project or Organization Token)

If OIDC is not an option (e.g., Dependabot workflows), use a project token or organization token.

### Generate a Project Token

1. Go to your **Projects** page
2. Click on the project → **Settings**
3. Under **Project Tokens**, enter a description and click **Create token**
4. Copy and save the token immediately — you won't be able to retrieve it again

### Generate an Organization Token

1. Go to your **Organization Settings**
2. Under **API Tokens**, enter a description and click **Create token**
3. Copy and save the token immediately

### Use the Token in Your Workflow

Add the token as a GitHub Actions secret named `DEPOT_TOKEN` in your repository settings. Reference it in your workflow:

```yaml
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: depot/setup-action@v1
      - uses: depot/build-push-action@v1
        with:
          project: <your-depot-project-id>
          token: ${{ secrets.DEPOT_TOKEN }}
          context: .
```

---

## Summary of Token Types

| Token Type | Scope | Best For |
|------------|-------|----------|
| **OIDC** | Project-scoped (temporary) | GitHub Actions (recommended) |
| **Project Token** | Single project | CI without OIDC support |
| **Organization Token** | All projects in org | Broad CI access |
| **User Access Token** | All orgs & projects | Local development only |

---

## References

- [Depot Documentation: GitHub Actions OIDC](https://depot.dev/docs/github-actions/oidc)
- [Depot Documentation: Authentication](https://depot.dev/docs/authentication)
