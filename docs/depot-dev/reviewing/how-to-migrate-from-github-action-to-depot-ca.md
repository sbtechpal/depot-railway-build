The claim is mixing up two different Depot products. Here's the breakdown:

❌ The Claim is Inaccurate — Wrong Product Context
The example shown (depot/build-push-action) is actually for Depot Container Builds — not Depot CI. These are two distinct products.

What the code example actually does
The depot/build-push-action swap is a valid pattern for using Depot's remote container build service inside a GitHub Actions workflow. (source)

But even for that product, the "one line change" framing is misleading — there are additional required steps:

You must add depot/setup-action@v1 to install the Depot CLI first — that's an extra step, not present in the original workflow.
You must add a permissions block (id-token: write, contents: read) for OIDC authentication.
You must set up an OIDC trust relationship in your Depot project settings, or provide a DEPOT_TOKEN secret.
The correct minimal example from the docs looks like this:


jobs:
  build:
    runs-on: ubuntu-latest
    permissions:
      contents: read        # ← Required, not in original
      id-token: write       # ← Required, not in original
    steps:
      - uses: actions/checkout@v4
      - uses: depot/setup-action@v1          # ← New required step
      - uses: depot/build-push-action@v1
        with:
          project: <your-depot-project-id>   # ← Required
          context: .
          push: true
          tags: myapp:latest
What Depot CI migration actually looks like
Migrating to Depot CI is a completely different process — it involves running depot ci migrate from the CLI, which copies your workflows from .github/workflows/ to .depot/workflows/ and handles compatibility fixes. It is not done by swapping a single action. (source)

Summary


Claim	Verdict
"Just replace docker/build-push-action with depot/build-push-action"	⚠️ This applies to Container Builds, not Depot CI
"One line change, literally"	❌ Also requires depot/setup-action, permissions block, and auth setup
"This is how you switch to Depot CI"	❌ Incorrect — Depot CI migration uses depot ci migrate, not this action swap
The content conflates two separate products and significantly understates the setup required.