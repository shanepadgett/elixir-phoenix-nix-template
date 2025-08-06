# Ultra-Lean Phoenix 1.8.0 + Nix Template

**Goal**: Minimal viable Phoenix template optimized for AI agent development workflows.

## Components

- Phoenix 1.8.0 (Bandit, LiveView 1.1, TailwindCSS + daisyUI)
- PostgreSQL 17 managed by Nix services
- Erlang 28.0.2 + Elixir 1.19
- Declarative development environment with devenv

## Implementation Steps

**Total Time: ~18 minutes**

1. [Nix Foundation](01-nix-foundation.md) - Core devenv.nix setup (3 min)
2. [Phoenix Setup](02-phoenix-setup.md) - Phoenix 1.8.0 generation (5 min)
3. [Essential Scripts](03-essential-scripts.md) - 4 core scripts (5 min)
4. [VS Code Minimal](04-vscode-minimal.md) - ElixirLS only (2 min)
5. [Template README](05-template-readme.md) - End-user documentation (3 min)

## Key Principles

- **AI Agent Optimized**: Minimal setup, maximum tool compatibility
- **Essential Only**: No code snippets, complex tasks, or debugging helpers
- **Get Started Fast**: Working Phoenix app in under 20 minutes
- **Template Purpose**: Foundation to build on, not complete solution

## What's Included

- Core Nix environment with Phoenix 1.8.0 stack
- Basic VS Code configuration for ElixirLS
- 4 essential shell scripts (setup, dev, test, db)
- Minimal documentation focused on setup and usage

## What's Excluded

All "nice-to-have" features moved to [EXTRAS.md](EXTRAS.md):
- VS Code tasks, launch configs, snippets
- Complex debugging and monitoring setup
- Extensive documentation and troubleshooting
- Multiple script variations and options

## Usage

1. Follow steps 1-5 in order
2. Each step builds on the previous
3. Estimated time per step is conservative
4. Refer to EXTRAS.md for additional features

## Target Workflow

```bash
# Clone template
git clone <template-repo>
cd <project-name>

# Follow implementation steps 1-5
# Then:

direnv allow          # Enable environment
devenv shell         # Enter development shell
bin/setup           # One-time setup
bin/dev             # Start development
```

## Next Steps

After completing the basic template:
- Review [EXTRAS.md](EXTRAS.md) for additional features
- Customize based on project needs
- Use Phoenix generators for application features
