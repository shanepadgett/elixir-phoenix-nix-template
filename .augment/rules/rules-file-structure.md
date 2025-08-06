---
type: "agent_requested"
description: "directory structure files organization phoenix nix"
---
# File Structure Rules

- Nix configuration in `devenv.nix`, `devenv.yaml`, `.envrc`
- Phoenix app follows standard structure: `lib/`, `test/`, `config/`, `priv/`
- Custom scripts in `bin/` directory
- VS Code configuration in `.vscode/` directory
- Exclude from version control: `_build/`, `deps/`, `.devenv/`, `priv/static/`
- Environment files: `.envrc` for direnv
- Documentation in `README.md` at project root
- Database configuration split across environment-specific config files
