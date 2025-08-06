---
type: "always_apply"
---

# Nix Development Environment Rules

- Always check for `$DEVENV_SHELL` environment variable before running commands
- Use `devenv shell` to enter development environment
- Use `devenv up -d` to start services (PostgreSQL)
- Use `devenv down` to stop services
- Check service status with `pg_isready -h localhost -p 5432 -U postgres`
- Environment variables are set in `devenv.nix` file
- PostgreSQL runs on localhost:5432 with user `postgres` and no password
- Use `direnv allow` to enable automatic environment loading
- Services must be running before database operations
