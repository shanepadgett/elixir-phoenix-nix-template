# Elixir Phoenix Nix Template

Phoenix 1.8.0 application template with Nix development environment.

## Stack

- **Phoenix 1.8.0** with Bandit, LiveView 1.1
- **Database**: PostgreSQL 17
- **Styling**: TailwindCSS + daisyUI
- **Runtime**: Elixir 1.18, Erlang 25-27
- **Environment**: Nix with devenv

## Setup

### Prerequisites

- [Nix](https://nixos.org/download.html) with flakes enabled
- [devenv](https://devenv.sh/getting-started/)
- [direnv](https://direnv.net/docs/installation.html) (recommended)

### Installation

```bash
# Clone and enter directory
git clone git@github.com:shanepadgett/elixir-phoenix-nix-template.git
cd elixir-phoenix-nix-template

# Allow direnv (if using direnv)
direnv allow

# Enter development shell
devenv shell

# Run setup
bin/setup
```

## Development

### Essential Scripts

This project includes 4 essential development scripts that handle environment setup and service management:

#### `bin/setup` - One-time project setup
**When to use**: First time setting up the project, or after major dependency changes.

```bash
bin/setup
```

This script:
- Verifies you're in the devenv shell
- Starts PostgreSQL service if needed
- Installs Hex and Rebar
- Installs all project dependencies
- Sets up assets (TailwindCSS, esbuild)
- Creates and migrates the development database
- Compiles the project

#### `bin/dev` - Start development server
**When to use**: Daily development work, when you want to run the Phoenix server.

```bash
bin/dev
```

This script:
- Verifies you're in the devenv shell
- Starts PostgreSQL service if needed
- Starts the Phoenix server on http://localhost:4000
- Shows helpful URLs (app and LiveDashboard)

#### `bin/test` - Run tests
**When to use**: Running tests during development, in CI/CD, or before committing changes.

```bash
# Run all tests
bin/test

# Run specific test file
bin/test test/myapp_web/controllers/page_controller_test.exs

# Run tests matching a pattern
bin/test --grep "user"
```

This script:
- Verifies you're in the devenv shell
- Starts PostgreSQL service if needed
- Sets up the test database (creates and migrates)
- Runs the test suite with any additional arguments you provide

#### `bin/db` - Database console
**When to use**: When you need to inspect data, run SQL queries, or debug database issues.

```bash
bin/db
```

This script:
- Verifies you're in the devenv shell
- Starts PostgreSQL service if needed
- Opens a PostgreSQL console connected to the development database

### Daily Usage

```bash
# Start development server
bin/dev

# Run tests
bin/test

# Database console
bin/db

# Enter development shell (if not using direnv)
devenv shell
```

### URLs

- **Application**: http://localhost:4000
- **LiveDashboard**: http://localhost:4000/dev/dashboard

### Database

```bash
# Create migration
mix ecto.gen.migration create_users

# Run migrations
mix ecto.migrate

# Reset database
mix ecto.reset
```

### Code Generation

```bash
# LiveView CRUD
mix phx.gen.live Blog Post posts title:string content:text

# HTML CRUD
mix phx.gen.html Blog Post posts title:string content:text

# JSON API
mix phx.gen.json Blog Post posts title:string content:text

# Context only
mix phx.gen.context Blog Post posts title:string content:text
```

### Testing

```bash
# Run all tests
bin/test

# Run specific test
bin/test test/myapp_web/controllers/page_controller_test.exs

# Run with coverage
mix test --cover
```

## Production

### Environment Variables

```bash
export SECRET_KEY_BASE="<64-char-secret>"
export DATABASE_URL="postgres://user:pass@host/database"
export PHX_HOST="yourdomain.com"
```

### Build Release

```bash
# Set production environment
export MIX_ENV=prod

# Install dependencies
mix deps.get --only prod

# Build assets
mix assets.deploy

# Build release
mix release
```

## VS Code

Recommended extensions are configured in `.vscode/extensions.json`:
- ElixirLS for language support
- Nix IDE for Nix files
- TailwindCSS IntelliSense

## Troubleshooting

### Services Not Starting

```bash
# Check service status
devenv processes

# Restart services
devenv down && devenv up -d
```

### Environment Issues

```bash
# Reload direnv
direnv reload

# Check environment
echo $DEVENV_SHELL
echo $DATABASE_URL
```

### Port Already in Use

```bash
# Find process using port 4000
lsof -i :4000

# Kill process
kill -9 <PID>
```
