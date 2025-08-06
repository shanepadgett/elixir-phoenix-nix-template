# Step 2: Phoenix Setup

**Goal**: Generate Phoenix 1.8.0 application with Nix integration

**Prerequisites**: Step 1 completed, devenv shell active

**Estimated Time**: 5 minutes

## 2.1 Install Phoenix Archive

```bash
# Install Phoenix archive
mix archive.install hex phx_new --force

# Verify version
mix phx.new --version
```

## 2.2 Generate Phoenix Application

```bash
# Generate app (replace myapp with your app name)
mix phx.new . --app myapp --module MyApp --database postgres

# Install dependencies when prompted
```

Phoenix 1.8.0 includes:
- Bandit HTTP adapter
- LiveView 1.1
- TailwindCSS + daisyUI
- Simplified layout structure

## 2.3 Update Database Configuration

Replace `config/dev.exs` database section:

```elixir
# Database configuration for Nix PostgreSQL
config :myapp, MyApp.Repo,
  username: "postgres",
  password: "",
  hostname: "localhost",
  port: 5432,
  database: "myapp_dev",
  pool_size: 10,
  show_sensitive_data_on_connection_error: true
```

Replace `config/test.exs` database section:

```elixir
# Test database configuration
config :myapp, MyApp.Repo,
  username: "postgres",
  password: "",
  hostname: "localhost",
  port: 5432,
  database: "myapp_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: System.schedulers_online() * 2
```

## 2.4 Update Runtime Configuration

Replace `config/runtime.exs` database section:

```elixir
if config_env() == :prod do
  database_url =
    System.get_env("DATABASE_URL") ||
      raise """
      environment variable DATABASE_URL is missing.
      For example: ecto://USER:PASS@HOST/DATABASE
      """

  maybe_ipv6 = if System.get_env("ECTO_IPV6") in ~w(true 1), do: [:inet6], else: []

  config :myapp, MyApp.Repo,
    url: database_url,
    pool_size: String.to_integer(System.get_env("POOL_SIZE") || "10"),
    socket_options: maybe_ipv6
end
```

## 2.5 Test Setup

```bash
# Start services
devenv up -d

# Create databases
mix ecto.create

# Run migrations
mix ecto.migrate

# Test server start
mix phx.server
```

Visit http://localhost:4000 to verify Phoenix is running.

## Verification

You should see:
- Phoenix welcome page at localhost:4000
- No database connection errors
- Assets loading correctly (TailwindCSS)

## Next Step

Continue to [Essential Scripts](03-essential-scripts.md)
