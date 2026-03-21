I talk to folks every week who are exhausted and blocked by the existing status quo — not just the delivery pipeline, but the software development platform as a whole.  

We're in a new world of software engineering. One where an idea can become working code in minutes.  

But the existing tools simply can't keep up. They're crumbling under the load.   

The bottleneck has shifted.  

Writing code is no longer the bottleneck. Integrating it is. Everything that comes after the code is written is now the problem:  

- Source control that's slow and unreliable 
- CI pipelines that are slow, flaky, and can't handle agent workloads 
- Code review designed for a pace of engineering that no longer exists 
- Context trapped in silos, inaccessible to agents and engineers alike  

The current providers aren't working for this world.  

So what are we building in the short term? Depot CI.  

The CI systems we have today weren't built for this moment. GitHub Actions, CircleCI, Buildkite — designed for a world where humans batch up code, push it, and wait. A 15-minute pipeline was annoying but survivable.  

That world is gone.  

A team of 10 engineers with agents can now move like a team of 100. The volume of code entering CI has never been higher. The old systems aren't just slow — they're architecturally wrong for this moment.  

Depot CI is a programmable CI engine with performance as a first-class citizen — fast orchestration, composable compute, and an API-first design that works for engineers at a terminal and agents running autonomously.  

Already on GitHub Actions? Bring your workflows directly — we run them faster and more reliably. But Actions compatibility is just one frontend. We're building something new underneath.  

Depot CI is the bridge, not the destination. We're building toward a software delivery platform where source control, CI, builds, and validation are all designed from the ground up for the pace engineers and agents are working at today.  

We started by making builds 40x faster. Now we're building what comes after GitHub.

Full announcement post: https://depot.dev/blog/depot-raises-series-a