# Step 3: Essential Scripts

**Goal**: Create 4 core development scripts

**Prerequisites**: Step 2 completed, Phoenix app generated

**Estimated Time**: 5 minutes

## 3.1 Create bin/setup

```bash
#!/usr/bin/env bash
set -e

echo "🚀 Setting up Phoenix development environment..."

# Check devenv shell
if [[ -z "$DEVENV_SHELL" ]]; then
  echo "❌ Not in devenv shell. Run 'devenv shell' first."
  exit 1
fi

# Start services
if ! pg_isready -h localhost -p 5432 -U postgres &>/dev/null; then
  echo "📦 Starting PostgreSQL..."
  devenv up -d
  sleep 3
fi

# Install Hex and Rebar
echo "📦 Installing Hex and Rebar..."
mix local.hex --force --if-missing
mix local.rebar --force --if-missing

# Install dependencies
echo "📦 Installing dependencies..."
mix deps.get

# Setup assets
echo "🎨 Setting up assets..."
mix assets.setup

# Setup database
echo "🗄️  Setting up database..."
mix ecto.create
mix ecto.migrate

# Compile
echo "🔨 Compiling..."
mix compile

echo "✅ Setup complete!"
echo "Start development: bin/dev"
```

## 3.2 Create bin/dev

```bash
#!/usr/bin/env bash
set -e

# Check devenv shell
if [[ -z "$DEVENV_SHELL" ]]; then
  echo "❌ Not in devenv shell. Run 'devenv shell' first."
  exit 1
fi

# Start services
if ! pg_isready -h localhost -p 5432 -U postgres &>/dev/null; then
  echo "📦 Starting services..."
  devenv up -d
  sleep 3
fi

echo "🚀 Starting Phoenix server..."
echo "Visit: http://localhost:4000"
echo "LiveDashboard: http://localhost:4000/dev/dashboard"
echo ""

# Start Phoenix server
mix phx.server
```

## 3.3 Create bin/test

```bash
#!/usr/bin/env bash
set -e

# Check devenv shell
if [[ -z "$DEVENV_SHELL" ]]; then
  echo "❌ Not in devenv shell. Run 'devenv shell' first."
  exit 1
fi

# Start services for test
if ! pg_isready -h localhost -p 5432 -U postgres &>/dev/null; then
  echo "📦 Starting services..."
  devenv up -d
  sleep 3
fi

# Setup test database if needed
echo "🗄️  Preparing test database..."
MIX_ENV=test mix ecto.create --quiet
MIX_ENV=test mix ecto.migrate --quiet

# Run tests
echo "🧪 Running tests..."
mix test "$@"
```

## 3.4 Create bin/db

```bash
#!/usr/bin/env bash
set -e

# Check devenv shell
if [[ -z "$DEVENV_SHELL" ]]; then
  echo "❌ Not in devenv shell. Run 'devenv shell' first."
  exit 1
fi

# Start services
if ! pg_isready -h localhost -p 5432 -U postgres &>/dev/null; then
  echo "📦 Starting services..."
  devenv up -d
  sleep 3
fi

# Connect to database
echo "🗄️  Connecting to database..."
psql -h localhost -p 5432 -U postgres -d myapp_dev
```

## 3.5 Make Scripts Executable

```bash
chmod +x bin/setup
chmod +x bin/dev
chmod +x bin/test
chmod +x bin/db
```

## Usage

```bash
# One-time setup
bin/setup

# Daily development
bin/dev

# Run tests
bin/test

# Database console
bin/db
```

## Verification

Test each script:
- `bin/setup` should complete without errors
- `bin/dev` should start Phoenix server
- `bin/test` should run test suite
- `bin/db` should open PostgreSQL console

## Next Step

Continue to [VS Code Minimal](04-vscode-minimal.md)
