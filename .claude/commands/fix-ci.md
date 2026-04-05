Fix a Depot CI workflow, run, or job until it is green.

### Before you start

Invoke the `depot-ci` skill to load the full CLI reference. Then drive the debug loop.

Use `/home/techie/.depot/bin/depot` as the CLI path (already installed).

### Inputs

Accept any of:

- a workflow path (for example, `.depot/workflows/ci.yml`)
- a run ID, job ID, or attempt ID
- a target job name (for example, `build`)
- a natural-language goal (for example, "make the test job pass")

If the request is ambiguous, ask for the narrowest useful target.

### The Loop

Iterate up to **5 attempts**. If CI is still red after 5 attempts, stop and report the remaining blocker.

Each attempt:

1. **Run** the workflow against local changes, scoped to the smallest useful job.
   - `depot ci run --workflow <path>` (or `--job <name>` to scope)
   - If there are untracked files the workflow needs, `git add` them first.
2. **Check status** — `depot ci status <run-id>`
3. **Read logs** for failed jobs — `depot ci logs <run-id>`
   - Truncate long logs to the last 200 lines; most failures surface near the end.
4. If logs aren't enough, connect to the running sandbox with **`depot ci ssh`**, or **rerun with `--ssh-after-step`** to pause at a specific step first.
5. **Fix locally** based on what you found.
6. **Rerun.** Repeat until green.

### Autonomy

The agent may: run workflows, inspect status/logs, SSH into runners, edit local files, and rerun until green.

Ask before: changing secrets or vars, altering deploy or release behavior, opening a PR, or large refactors beyond the immediate fix.

### When done, report

- what was targeted
- what was wrong
- what changed
- proof of green (or the exact remaining blocker)
