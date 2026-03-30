What is a "Programmable CI Engine"?
The term has two key parts: "programmable" and "CI engine".

CI Engine (not a wrapper)
Depot CI is an entirely new CI engine, not a wrapper around GitHub Actions. It sits on top of its own orchestrator and compute layer called Switchyard, built from the ground up. Switchyard has two components:

Orchestrator — Schedules tasks across the compute fleet, handles job dependencies, and monitors progress
Compute — Receives tasks from the orchestrator, provisions sandboxes, and executes jobs
Programmable
This is the key differentiator. Because Depot CI is built on Switchyard, the system is designed to be programmable in several ways:

CLI-first for engineers and agents — You can trigger runs, fetch logs, and monitor job status from the CLI without needing a GitHub event or even the dashboard. This means both humans and AI coding agents can interact with it programmatically.

API access — Switchyard can give your own CI frontend direct API access to workflows, orchestration, and compute. You're not locked into one workflow syntax.

Run workflows locally — You can run a workflow against your local working tree without pushing to GitHub first, pass --job to run a subset of jobs, and even open an interactive SSH debug session at a specific step.

Multiple syntax support — GitHub Actions YAML is just the first syntax Depot CI supports. The engine is designed to support more workflow syntaxes in the future because the underlying Switchyard system is syntax-agnostic.

Summary
In short, "programmable CI engine" means Depot CI is:

A fully independent CI system (not dependent on GitHub's infrastructure)
Controllable via API/CLI by both engineers and AI agents without needing UI interaction or GitHub events
Extensible beyond GitHub Actions syntax, since the underlying engine can support different workflow definitions
Performance-first, with 2-3 second job start times, pre-warmed sandboxes, and built-in caching