---
type: "agent_requested"
description: "testing mix test database setup patterns"
---
# Testing Patterns Rules

- Use `bin/test` script instead of direct `mix test`
- Test database is automatically created and migrated
- Use `MIX_ENV=test` for test environment
- Test files end with `_test.exs`
- Use ExUnit for testing framework
- Database sandbox for test isolation
- Run specific tests with `bin/test path/to/test.exs`
- Test database uses separate instance from development
