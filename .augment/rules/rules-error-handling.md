---
type: "agent_requested"
description: "troubleshooting errors debugging service issues"
---
# Error Handling Rules

- Check `$DEVENV_SHELL` if commands fail
- Use `devenv processes` to check service status
- Use `lsof -i :4000` to check port conflicts
- Restart services with `devenv down && devenv up -d`
- Reload environment with `direnv reload`
- Check PostgreSQL with `pg_isready -h localhost -p 5432 -U postgres`
- Kill processes with `kill -9 <PID>` if needed
- Check logs in terminal output for service errors
