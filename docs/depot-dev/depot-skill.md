Read
/blog/now-available-depot-skills
Depot Skills Details
Depot skills are a collection of skill files that teach AI coding agents how to leverage Depot for various workflows. (source) They provide context and instructions to AI agents so they generate correct Depot commands and configurations on the first try.

Available Skills
Depot provides four main skills:

Container Builds — Teaches agents:

How to use depot build and depot bake
Multi-platform builds
Cache management
Depot Registry workflows
Migration from docker build or docker buildx
GitHub Actions Runners — Shows agents:

How to leverage Depot GitHub Actions runners
Available runs-on labels
GitHub app installation
Caching functionality
Egress filtering
Dependabot integration
SSH debugging
Connecting runners to Tailscale
Depot CI — Covers:

Depot CI (currently in beta)
depot ci migrate command
Secrets and variables configuration
Running workflows
GitHub Actions compatibility
General — Includes:

CLI installation
Authentication (tokens and OIDC)
Project setup
Organization management
Depot API
Pricing
Getting Started
Install Depot skills using skills.sh:


npx skills add depot/skills
Skills.sh automatically detects your agent and installs the files in the right location. For manual installation options, see the skills repository. (source)

Supported Agents
Skills work best with agents that explicitly support the SKILL.md convention:

Claude Code
Codex
Cursor
For other agents, you can reference the skill files manually or add "using the Depot skills" to your prompt to encourage the agent to use them. (source)

Why Depot Built Skills
Skills were created to prevent agents from confidently generating incorrect commands or configurations—such as using docker build instead of depot build, or using wrong GitHub Actions runner labels. They eliminate friction in agent-driven workflows by providing context upfront. (source)

