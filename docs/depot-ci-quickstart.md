# Depot CI Quickstart

Get started with Depot CI to run your GitHub Actions workflows on a fast and reliable engine built for engineers and agents. This quickstart covers the full setup including coding agent integration.

---

## Prerequisites

### 1. Depot account

Sign up at [depot.dev](https://depot.dev). The Developer plan ($20/month) includes 500 Docker build minutes, 2,000 Depot CI minutes, and 25 GB cache storage.

### 2. Install the Depot CLI

Install the CLI on your machine to work with Depot CI from your terminal or coding agent.

**macOS:**
```bash
brew install depot/tap/depot
```

**Linux:**
```bash
curl -L https://depot.dev/install-cli.sh | sh
```

**GitHub Actions:**
```yaml
- uses: depot/setup-action@v1
```

**All platforms:** Download the binary from the [Depot CLI releases page](https://github.com/depot/cli/releases).

Verify the installation:
```bash
depot --version
```

### 3. Install Depot skills for coding agents (recommended)

If you use coding agents like Claude Code or Cursor, install the Depot skills so your agent has full knowledge of the Depot CLI, container builds, GitHub Actions runners, and Depot CI.

```bash
npx skills add depot/skills
```

This installs four skills into your project's `.agents/skills/` directory:

| Skill | Coverage |
|-------|----------|
| `depot-general` | CLI install, auth, project setup, org management |
| `depot-container-builds` | `depot build`, `depot bake`, caching, multi-platform builds |
| `depot-github-runners` | Depot-managed GHA runners, runner labels, sizes |
| `depot-ci` | Depot CI workflows, migrate, secrets, SSH, status, logs |

---

## Connect to GitHub

Depot CI uses the Depot Code Access GitHub App to read your repository and register workflow triggers. If you've used Claude Code on Depot, you may already have this installed.

1. Log in to your [Depot dashboard](https://depot.dev).
2. Click **Settings**.
3. In the **GitHub Code Access** section, check for existing GitHub connections.
4. Click **Connect to GitHub** to connect an organization.
5. Follow the prompts to install the Depot Code Access app into your GitHub organization.

---

## Authenticate the CLI

```bash
depot login
```

This opens a browser for interactive login. For CI environments, set the `DEPOT_TOKEN` environment variable or pass `--token` on commands.

---

## Migrate your workflows

The `depot ci migrate` command automates migrating your GitHub Actions workflows to Depot CI.

From the root of your repository, run:

```bash
depot ci migrate
```

The command runs a preflight check, then copies and transforms your workflows:

1. Validates authentication and checks that the Depot Code Access app is installed with the correct permissions.
2. Discovers all workflow files in `.github/workflows/`.
3. Prompts you to select which workflows to migrate.
4. Copies selected workflows to `.depot/workflows/` and any local actions to `.depot/actions/`, applying compatibility fixes and adding inline comments for any changes.

After migration, the command reports any secrets and variables referenced by the migrated workflows.

### Review the migrated workflow with your coding agent

**Important:** `depot ci migrate` produces a minimal transformation -- it primarily changes the `runs-on` label and applies compatibility fixes. The migrated workflow may not take full advantage of Depot's features.

Ask your coding agent to review and analyze the migrated workflow in `.depot/workflows/` to ensure it uses Depot platform features:

- **Depot remote builders** (`depot/build-push-action@v1`) instead of `docker build` or `docker buildx build`
- **Depot-managed runners** (e.g., `depot-ubuntu-24.04-4`) for appropriate sizing
- **OIDC authentication** (`id-token: write`) instead of static secrets
- **Remove GHA cache flags** (`--cache-from type=gha`, `--cache-to type=gha`) -- Depot caches automatically on NVMe SSD
- **`provenance: false`** to avoid unknown/unknown platform issues on multi-platform builds
- **`context: .`** when building from a local checkout (otherwise Depot fetches from the remote repo)

Example prompt for your coding agent:
```
Review .depot/workflows/my-workflow.yml and update it to use the full
Depot feature set: depot/build-push-action for builds, depot-ubuntu runners,
OIDC auth, and remove any --cache-from/to type=gha flags.
```

### Migrate flags

| Flag | Description |
|------|-------------|
| `-y, --yes` | Non-interactive, migrate all workflows |
| `--overwrite` | Overwrite existing `.depot/` directory |
| `--org <id>` | Organization ID (required if multiple orgs) |
| `--token <token>` | Depot API token |

---

## Import secrets and variables

If your workflows reference GitHub secrets or variables, import them into Depot CI:

```bash
depot ci migrate secrets-and-vars
```

This creates a one-shot GitHub Actions workflow that reads your existing GitHub secrets and variables and imports them into Depot CI. The command prints a URL where you can monitor the import.

You can also add secrets and variables manually:

```bash
# Add a secret (prompts for value interactively)
depot ci secrets add SECRET_NAME

# Add with value from environment variable
depot ci secrets add SECRET_NAME --value "$MY_SECRET"

# Add repo-scoped secret
depot ci secrets add SECRET_NAME --repo owner/repo --value "$MY_SECRET"

# Add a variable
depot ci vars add VAR_NAME --value "some-value"

# List secrets and variables
depot ci secrets list
depot ci vars list
```

---

## Merge your workflows

Push and merge the changes so that automatic workflow triggers (`push`, `pull_request`, etc.) are registered with Depot CI.

```bash
git add .depot/
git commit -m "Add Depot CI workflows"
git push
```

Then merge into your default branch.

**Important:** Workflows continue to run in both GitHub and Depot CI after merging. Any workflows that cause side effects (deploys, artifact updates) will execute twice. During migration and testing, keep your GitHub Actions workflows running alongside your Depot CI workflows.

---

## Next steps

### View your workflow runs

Go to the Depot CI page in your [Depot dashboard](https://depot.dev) to view your workflow runs and job statuses.

You can also use the CLI:

```bash
# List recent runs
depot ci run list

# Check the status of a specific run
depot ci status <run-id>

# Fetch logs for a run, job, or attempt
depot ci logs <run-id>
```

### Run a workflow locally

Use `depot ci run` to test a workflow against your local working tree without pushing to GitHub first:

```bash
depot ci run --workflow .depot/workflows/ci.yml
```

If you have uncommitted changes, they are automatically included in the run.

Pass `--job` to run a subset of jobs:

```bash
depot ci run --workflow .depot/workflows/ci.yml --job build --job test
```

### SSH into running jobs

Connect to a running CI job via interactive terminal for debugging:

```bash
# Connect using a run ID (auto-selects job if only one)
depot ci ssh <run-id>

# Connect to a specific job
depot ci ssh <run-id> --job build

# Print connection details without connecting
depot ci ssh <run-id> --info --output json
```

### Use Depot CI in coding agent loops

Depot CI is built for programmatic use, making it a natural fit for AI coding agents. Instead of the push-wait-guess cycle, an agent can run CI locally, read the failure, fix the code, and rerun -- all in a closed loop from your terminal.

**How it works:**

1. `depot ci run` starts a run against your local working tree (no commit or push needed)
2. `depot ci status` shows the full run hierarchy with statuses
3. `depot ci logs` fetches log output for failed jobs
4. `depot ci ssh` connects directly to a running sandbox for deeper debugging
5. The agent fixes code locally and reruns until CI is green

#### Set up the fix-CI loop

Create a `/fix-ci` command for your agent. Example for Claude Code (`.claude/commands/fix-ci.md`):

```markdown
Fix a Depot CI workflow, run, or job until it is green.

### Before you start
Invoke the `depot-ci` skill to load the full CLI reference.

### Inputs
Accept any of:
- a workflow path (e.g., `.depot/workflows/ci.yml`)
- a run ID, job ID, or attempt ID
- a target job name (e.g., `build`)

### The Loop
1. **Run** the workflow against local changes, scoped to the smallest useful job.
2. **Check status** and **read logs** for failed jobs.
3. If logs aren't enough, connect with **`depot ci ssh`**.
4. **Fix locally** based on what you found.
5. **Rerun.** Repeat until green (max 5 attempts).

### Autonomy
The agent may: run workflows, inspect status/logs, SSH into runners,
edit local files, and rerun until green.

Ask before: changing secrets or vars, altering deploy behavior,
opening a PR, or large refactors.

### When done, report
- what was targeted
- what was wrong
- what changed
- proof of green (or the exact remaining blocker)
```

#### Give the agent permission

For Claude Code, add to `.claude/settings.json`:

```json
{
  "permissions": {
    "allow": ["Bash(depot *)"]
  }
}
```

For Cursor, add to `<project>/.cursor/cli.json`:

```json
{
  "permissions": {
    "allow": ["Shell(depot)"]
  }
}
```

#### Run the agent loop

```
/fix-ci .depot/workflows/ci.yml
```

The agent will iterate autonomously: run, check status, read logs, fix, rerun -- capped at 5 attempts.

#### Tips for the agent loop

| Tip | Details |
|-----|---------|
| **Iteration limits** | Cap at 3-5 attempts to prevent infinite loops on broken builds |
| **Log truncation** | Truncate logs to the last ~200 lines; most failures surface near the end |
| **Polling** | `depot ci status` returns immediately -- agents naturally poll in a loop |
| **Untracked files** | `depot ci run` only patches tracked files; `git add` new files before running |
| **Scope to one job** | Use `--job build` for faster iteration when debugging a specific job |

---

## Directory structure

After completing this quickstart, your repository will look like:

```
your-repo/
├── .github/
│   ├── workflows/          # Original GHA workflows (kept during transition)
│   └── actions/            # Local composite actions
├── .depot/
│   ├── workflows/          # Depot CI copies of workflows
│   └── actions/            # Depot CI copies of local actions
├── .agents/
│   └── skills/             # Depot skills for coding agents
│       ├── depot-general/
│       ├── depot-container-builds/
│       ├── depot-github-runners/
│       └── depot-ci/
├── .claude/
│   ├── commands/
│   │   └── fix-ci.md       # Agent loop command
│   └── settings.json       # Permissions for depot commands
```

---

## Common troubleshooting

| Issue | Fix |
|-------|-----|
| Workflows not starting | Verify single runner label; check runner group allows the repo; verify Depot GitHub App permissions |
| `UNRESOLVED_IMPORT` or build errors | Check that `context: .` is set when building from local checkout |
| "Unable to get ACTIONS_ID_TOKEN_REQUEST_URL" | Dependabot doesn't support OIDC -- use `DEPOT_TOKEN` secret instead |
| `--cache-from type=gha` errors | Remove these flags; Depot caches automatically on NVMe SSD |
| Unknown/unknown platform in registry | Add `provenance: false` to build action |
| Missing secrets in Depot CI | Run `depot ci migrate secrets-and-vars` or add manually with `depot ci secrets add` |
| Stuck workflows | Force cancel: `POST /repos/{owner}/{repo}/actions/runs/{id}/force-cancel` |
| Wrong org context | Run `depot org show` and `depot org list`; use `--org <id>` flag |

---

## References

- [Depot CI Quickstart](https://depot.dev/docs/ci/quickstart) -- official documentation
- [Use Depot CI in coding agent loops](https://depot.dev/docs/ci/how-to-guides/coding-agents) -- agent loop guide
- [Depot skills](https://github.com/depot/skills) -- skills for AI coding agents
- [Depot CLI reference](https://depot.dev/docs/cli) -- full CLI command reference
- [Depot CI compatibility](https://depot.dev/docs/ci/reference/compatibility) -- GitHub Actions feature support
