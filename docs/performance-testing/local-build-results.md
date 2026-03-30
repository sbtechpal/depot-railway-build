# Local Docker Build Results

Baseline local build performance for the OpenClaw Demo sample app.

---

## Test Environment

| Setting | Value |
|---------|-------|
| **Platform** | WSL2 on Windows |
| **Date** | 2026-03-30 |
| **Docker** | Docker Desktop (default instance) |
| **Base Image** | node:18-alpine |
| **Build Command** | `docker build -t openclaw-demo:test .` |

---

## Build Times (Local)

### Multi-Stage Build Breakdown

| Stage | Duration | Description |
|-------|----------|-------------|
| `deps` | ~115s | All dependencies (312 packages including devDependencies) |
| `production-deps` | ~113s | Production only (302 packages) |
| `build` | ~5s | TypeScript compilation (`tsc`) |
| `production` | ~2s | User creation, permissions |
| `export` | ~9s | Image assembly and export |

**Total Wall-Clock Time:** ~129 seconds (2:09)

> **Note:** `deps` and `production-deps` stages run in parallel, so the total time is not additive.

---

## Stage Details

### deps Stage
```dockerfile
FROM node:18-alpine AS base
WORKDIR /app
COPY package.json package-lock.json ./
RUN npm ci && npm cache clean --force
```
- **Purpose:** Install all dependencies including `@types/express` for TypeScript compilation
- **Packages:** 313 total (includes TypeScript, @types/*)
- **Time:** 115.2s

### production-deps Stage
```dockerfile
FROM base AS production-deps
COPY package.json package-lock.json ./
RUN npm ci --omit=dev && npm cache clean --force
```
- **Purpose:** Install only production dependencies for final image
- **Packages:** 303 total
- **Time:** 112.7s
- **Runs in parallel:** Yes, with `deps` stage

### build Stage
```dockerfile
FROM base AS build
COPY --from=deps /app/node_modules ./node_modules
COPY . .
RUN npm run build
```
- **Purpose:** Compile TypeScript to JavaScript
- **Command:** `tsc`
- **Time:** 5.2s
- **Output:** `dist/index.js` and declaration files

### production Stage
```dockerfile
FROM base AS production
ENV NODE_ENV=production
COPY --from=build /app/dist ./dist
COPY --from=production-deps /app/node_modules ./node_modules
COPY package.json ./
```
- **Purpose:** Final minimal production image
- **Time:** ~2s (user creation) + 9s (export)
- **Image Size:** TBD

---

## Key Observations

1. **npm ci dominates build time** - The dependency installation accounts for ~90% of total build time
2. **Parallel stages help** - Running `deps` and `production-deps` simultaneously saves ~113 seconds
3. **TypeScript is fast** - Compilation takes only 5 seconds once dependencies are installed
4. **Layer caching opportunity** - With Depot CI, the dependency layers can be cached across builds

---

## Comparison Targets

Once setup is complete, compare this local baseline against:

| Flow | Expected Time | Notes |
|------|---------------|-------|
| **Local (baseline)** | 2:09 | Current measurement |
| **Railway Auto-Build** | 3-5 min | Cold build on Railway infrastructure |
| **GitHub Actions** | 3-5 min | Standard ubuntu-latest runner |
| **Depot CI** | 30-60s | Cached layers + faster runners |

---

## Re-running This Test

```bash
cd sample-app
docker build -t openclaw-demo:test .
```

For a clean build (no cache):
```bash
docker build --no-cache -t openclaw-demo:test .
```

---

## Next Steps

1. [ ] Push changes to trigger Railway build
2. [ ] Run Flow 2 (Railway auto-build) and record time
3. [ ] Run Flow 3 (GitHub Actions) and record time
4. [ ] Run Flow 4 (Depot CI) and record time
5. [ ] Update this document with all flow results
