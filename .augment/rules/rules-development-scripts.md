---
type: "always_apply"
---

# Development Scripts Rules

- Use `bin/setup` for initial project setup
- Use `bin/dev` to start development server
- Use `bin/test` to run tests
- Use `bin/db` to access database console
- All scripts require devenv shell environment
- Scripts automatically start services if needed
- Prefer custom scripts over direct mix commands
- Scripts handle service dependencies automatically
- Pass additional arguments to scripts when needed (e.g., `bin/test specific_test.exs`)
