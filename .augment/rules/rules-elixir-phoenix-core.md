---
type: "always_apply"
---

# Core Elixir/Phoenix Rules

- Use Phoenix generators (`mix phx.gen.*`) instead of manual file creation for standard patterns
- Phoenix 1.8.0 uses Bandit adapter, LiveView 1.1, TailwindCSS + daisyUI by default
- Prefer `mix` commands over manual file manipulation for Elixir/Phoenix operations
- Use Ecto for all database operations and migrations
- Follow Phoenix directory structure conventions
- Use LiveView for interactive features, standard controllers for APIs
- Configure databases through `config/` files, not hardcoded values
- Use `mix format` for code formatting
- Test files go in `test/` directory with `_test.exs` suffix
