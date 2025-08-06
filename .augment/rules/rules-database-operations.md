---
type: "agent_requested"
description: "database postgres ecto migration setup test"
---
# Database Operations Rules

- Database configuration is in `config/dev.exs`, `config/test.exs`, `config/runtime.exs`
- Development database: `myapp_dev` on localhost:5432
- Test database: `myapp_test` on localhost:5432
- Use `mix ecto.create` to create databases
- Use `mix ecto.migrate` to run migrations
- Use `mix ecto.gen.migration` to create migrations
- Use `mix ecto.reset` to reset database
- Test database uses `MIX_ENV=test` environment
- PostgreSQL service must be running before database operations
