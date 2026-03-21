Depot CI
Depot CI is a programmable CI engine built with performance as a first-class citizen, currently in beta. (source) It's designed as a faster, more reliable alternative to traditional CI systems like GitHub Actions, built specifically for modern software engineering workflows.

Key Features
GitHub Actions Compatible: Run your existing GitHub Actions workflows on Depot CI (source)
Performance-First Architecture: Unlike legacy CI systems, Depot CI was built from the ground up with performance as a core design principle, not an afterthought
Three-Part Architecture: (source)
Compute subsystem - Executes work and provisions resources
Orchestrator subsystem - Schedules tasks, handles dependencies, and monitors progress
GitHub Actions workflow parser - Converts Actions YAML into Depot CI workflows
Getting Started
To get started with Depot CI beta:

Install the Depot Code Access app in your GitHub organization from the Depot dashboard
Run the migrate command to automatically discover and copy your workflows:

depot ci migrate
This command discovers workflows, analyzes compatibility, creates a .depot/ directory, and helps you configure secrets and variables.
Commit and push the new .depot/ directory to your default branch
Monitor workflows from the Workflows page in your Depot dashboard
For more details, see the Depot CI Beta setup and compatibility guide.

Current Status & Beta Program
Depot CI is currently in beta with a limited number of users. Join the waitlist if you're interested in participating. Pricing during beta is free, with GA pricing planned at $0.0001 per second for the base runner.