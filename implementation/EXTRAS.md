# EXTRAS: Recommended Additions

**Purpose**: Optional features excluded from the ultra-lean template for teams that want more comprehensive tooling.

## VS Code Enhancements

### Tasks Configuration

Add `.vscode/tasks.json` for integrated task running:

```json
{
  "version": "2.0.0",
  "tasks": [
    {
      "label": "Phoenix Server",
      "type": "shell",
      "command": "bin/dev",
      "group": "build",
      "presentation": {
        "echo": true,
        "reveal": "always",
        "focus": false,
        "panel": "new"
      }
    },
    {
      "label": "Run Tests",
      "type": "shell",
      "command": "bin/test",
      "group": "test",
      "presentation": {
        "echo": true,
        "reveal": "always",
        "focus": false,
        "panel": "new"
      }
    },
    {
      "label": "Database Console",
      "type": "shell",
      "command": "bin/db",
      "group": "build",
      "presentation": {
        "echo": true,
        "reveal": "always",
        "focus": true,
        "panel": "new"
      }
    }
  ]
}
```

### Launch Configuration

Add `.vscode/launch.json` for debugging:

```json
{
  "version": "0.2.0",
  "configurations": [
    {
      "type": "mix_task",
      "name": "Phoenix Server",
      "request": "launch",
      "task": "phx.server",
      "taskArgs": [],
      "startApps": true,
      "projectDir": "${workspaceRoot}"
    },
    {
      "type": "mix_task",
      "name": "Run Tests",
      "request": "launch",
      "task": "test",
      "taskArgs": [],
      "startApps": true,
      "projectDir": "${workspaceRoot}"
    }
  ]
}
```

### Code Snippets

Add `.vscode/elixir.code-snippets`:

```json
{
  "LiveView Mount": {
    "prefix": "mount",
    "body": [
      "def mount(_params, _session, socket) do",
      "  {:ok, socket}",
      "end"
    ],
    "description": "LiveView mount function"
  },
  "LiveView Handle Event": {
    "prefix": "handle_event",
    "body": [
      "def handle_event(\"${1:event_name}\", %{\"${2:key}\" => ${3:value}}, socket) do",
      "  ${4:# Handle event}",
      "  {:noreply, socket}",
      "end"
    ],
    "description": "LiveView handle_event function"
  },
  "Phoenix Controller Action": {
    "prefix": "action",
    "body": [
      "def ${1:action_name}(conn, %{\"${2:param}\" => ${3:value}}) do",
      "  ${4:# Controller logic}",
      "  render(conn, :${1:action_name})",
      "end"
    ],
    "description": "Phoenix controller action"
  }
}
```

### Keyboard Shortcuts

Add to VS Code keybindings:

```json
[
  {
    "key": "cmd+shift+t",
    "command": "workbench.action.tasks.runTask",
    "args": "Run Tests"
  },
  {
    "key": "cmd+shift+s",
    "command": "workbench.action.tasks.runTask",
    "args": "Phoenix Server"
  },
  {
    "key": "cmd+shift+d",
    "command": "workbench.action.tasks.runTask",
    "args": "Database Console"
  }
]
```

## Additional Extensions

### Development Tools
- **Live Share** (`MS-vsliveshare.vsliveshare`) - Collaborative editing
- **GitLens** (`eamodio.gitlens`) - Enhanced Git integration
- **Thunder Client** (`rangav.vscode-thunder-client`) - API testing
- **Auto Rename Tag** (`formulahendry.auto-rename-tag`) - HTML tag renaming

### Code Quality
- **Credo** (`msaraiva.elixir-credo`) - Static analysis
- **Coverage Gutters** (`ryanluker.vscode-coverage-gutters`) - Test coverage visualization

## Enhanced Scripts

### Advanced Development Script

Replace `bin/dev` with enhanced version:

```bash
#!/usr/bin/env bash
set -e

# Check devenv shell
if [[ -z "$DEVENV_SHELL" ]]; then
  echo "❌ Not in devenv shell. Run 'devenv shell' first."
  exit 1
fi

# Parse arguments
WATCH_TESTS=false
OPEN_BROWSER=false

while [[ $# -gt 0 ]]; do
  case $1 in
    --watch-tests)
      WATCH_TESTS=true
      shift
      ;;
    --open)
      OPEN_BROWSER=true
      shift
      ;;
    *)
      echo "Unknown option: $1"
      exit 1
      ;;
  esac
done

# Start services
if ! pg_isready -h localhost -p 5432 -U postgres &>/dev/null; then
  echo "📦 Starting services..."
  devenv up -d
  sleep 3
fi

# Open browser if requested
if [[ "$OPEN_BROWSER" == "true" ]]; then
  sleep 2 && open http://localhost:4000 &
fi

# Start test watcher if requested
if [[ "$WATCH_TESTS" == "true" ]]; then
  echo "🧪 Starting test watcher..."
  mix test.watch &
fi

echo "🚀 Starting Phoenix server..."
echo "Visit: http://localhost:4000"
echo "LiveDashboard: http://localhost:4000/dev/dashboard"
echo ""

# Start Phoenix server
mix phx.server
```

### Enhanced Test Script

Replace `bin/test` with enhanced version:

```bash
#!/usr/bin/env bash
set -e

# Check devenv shell
if [[ -z "$DEVENV_SHELL" ]]; then
  echo "❌ Not in devenv shell. Run 'devenv shell' first."
  exit 1
fi

# Parse arguments
COVERAGE=false
WATCH=false
FAILED=false

while [[ $# -gt 0 ]]; do
  case $1 in
    --coverage)
      COVERAGE=true
      shift
      ;;
    --watch)
      WATCH=true
      shift
      ;;
    --failed)
      FAILED=true
      shift
      ;;
    *)
      break
      ;;
  esac
done

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

# Run tests with options
if [[ "$WATCH" == "true" ]]; then
  echo "🧪 Running tests in watch mode..."
  mix test.watch "$@"
elif [[ "$COVERAGE" == "true" ]]; then
  echo "🧪 Running tests with coverage..."
  mix test --cover "$@"
elif [[ "$FAILED" == "true" ]]; then
  echo "🧪 Running failed tests..."
  mix test --failed "$@"
else
  echo "🧪 Running tests..."
  mix test "$@"
fi
```

## Code Quality Tools

### Add Credo for Static Analysis

Add to `mix.exs` dependencies:

```elixir
{:credo, "~> 1.7", only: [:dev, :test], runtime: false}
```

Create `.credo.exs`:

```elixir
%{
  configs: [
    %{
      name: "default",
      files: %{
        included: [
          "lib/",
          "src/",
          "test/",
          "web/",
          "apps/*/lib/",
          "apps/*/src/",
          "apps/*/test/",
          "apps/*/web/"
        ],
        excluded: [~r"/_build/", ~r"/deps/", ~r"/node_modules/"]
      },
      plugins: [],
      requires: [],
      strict: true,
      parse_timeout: 5000,
      color: true,
      checks: %{
        enabled: [
          {Credo.Check.Consistency.ExceptionNames, []},
          {Credo.Check.Consistency.LineEndings, []},
          {Credo.Check.Consistency.ParameterPatternMatching, []},
          {Credo.Check.Consistency.SpaceAroundOperators, []},
          {Credo.Check.Consistency.SpaceInParentheses, []},
          {Credo.Check.Consistency.TabsOrSpaces, []},
          {Credo.Check.Design.AliasUsage, [priority: :low, if_nested_deeper_than: 2, if_called_more_often_than: 0]},
          {Credo.Check.Design.TagTODO, [priority: :low]},
          {Credo.Check.Design.TagFIXME, []},
          {Credo.Check.Readability.AliasOrder, []},
          {Credo.Check.Readability.FunctionNames, []},
          {Credo.Check.Readability.LargeNumbers, []},
          {Credo.Check.Readability.MaxLineLength, [priority: :low, max_length: 120]},
          {Credo.Check.Readability.ModuleAttributeNames, []},
          {Credo.Check.Readability.ModuleDoc, []},
          {Credo.Check.Readability.ModuleNames, []},
          {Credo.Check.Readability.ParenthesesInCondition, []},
          {Credo.Check.Readability.ParenthesesOnZeroArityDefs, []},
          {Credo.Check.Readability.PipeIntoAnonymousFunctions, []},
          {Credo.Check.Readability.PredicateFunctionNames, []},
          {Credo.Check.Readability.PreferImplicitTry, []},
          {Credo.Check.Readability.RedundantBlankLines, []},
          {Credo.Check.Readability.Semicolons, []},
          {Credo.Check.Readability.SpaceAfterCommas, []},
          {Credo.Check.Readability.StringSigils, []},
          {Credo.Check.Readability.TrailingBlankLine, []},
          {Credo.Check.Readability.TrailingWhiteSpace, []},
          {Credo.Check.Readability.UnnecessaryAliasExpansion, []},
          {Credo.Check.Readability.VariableNames, []},
          {Credo.Check.Refactor.CondStatements, []},
          {Credo.Check.Refactor.CyclomaticComplexity, []},
          {Credo.Check.Refactor.FunctionArity, []},
          {Credo.Check.Refactor.LongQuoteBlocks, []},
          {Credo.Check.Refactor.MapInto, []},
          {Credo.Check.Refactor.MatchInCondition, []},
          {Credo.Check.Refactor.NegatedConditionsInUnless, []},
          {Credo.Check.Refactor.NegatedConditionsWithElse, []},
          {Credo.Check.Refactor.Nesting, []},
          {Credo.Check.Refactor.UnlessWithElse, []},
          {Credo.Check.Refactor.WithClauses, []},
          {Credo.Check.Warning.ApplicationConfigInModuleAttribute, []},
          {Credo.Check.Warning.BoolOperationOnSameValues, []},
          {Credo.Check.Warning.ExpensiveEmptyEnumCheck, []},
          {Credo.Check.Warning.IExPry, []},
          {Credo.Check.Warning.IoInspect, []},
          {Credo.Check.Warning.LazyLogging, []},
          {Credo.Check.Warning.MixEnv, false},
          {Credo.Check.Warning.OperationOnSameValues, []},
          {Credo.Check.Warning.OperationWithConstantResult, []},
          {Credo.Check.Warning.RaiseInsideRescue, []},
          {Credo.Check.Warning.SpecWithStruct, []},
          {Credo.Check.Warning.WrongTestFileExtension, []},
          {Credo.Check.Warning.UnusedEnumOperation, []},
          {Credo.Check.Warning.UnusedFileOperation, []},
          {Credo.Check.Warning.UnusedKeywordOperation, []},
          {Credo.Check.Warning.UnusedListOperation, []},
          {Credo.Check.Warning.UnusedPathOperation, []},
          {Credo.Check.Warning.UnusedRegexOperation, []},
          {Credo.Check.Warning.UnusedStringOperation, []},
          {Credo.Check.Warning.UnusedTupleOperation, []},
          {Credo.Check.Warning.UnsafeExec, []}
        ]
      }
    }
  ]
}
```

### Add Dialyzer for Type Checking

Add to `mix.exs` dependencies:

```elixir
{:dialyxir, "~> 1.4", only: [:dev, :test], runtime: false}
```

Create `dialyzer.ignore-warnings`:

```
# Ignore common Phoenix/LiveView warnings
lib/myapp_web/live/
lib/myapp_web/controllers/
```

### Add Sobelow for Security Analysis

Add to `mix.exs` dependencies:

```elixir
{:sobelow, "~> 0.13", only: [:dev, :test], runtime: false}
```

Create `.sobelow-conf`:

```
[
  verbose: true,
  private: false,
  skip: ["Config.HTTPS"]
]
```

## Performance Monitoring

### Add Telemetry

Add to `mix.exs` dependencies:

```elixir
{:telemetry_metrics, "~> 1.0"},
{:telemetry_poller, "~> 1.1"}
```

### LiveDashboard Enhancements

Add to `config/dev.exs`:

```elixir
config :myapp, MyAppWeb.Endpoint,
  live_dashboard: [
    metrics: MyAppWeb.Telemetry,
    additional_pages: [
      broadway: BroadwayDashboard
    ]
  ]
```

## Database Tools

### Enhanced Database Scripts

Create `bin/db-reset`:

```bash
#!/usr/bin/env bash
set -e

echo "🗄️  Resetting database..."
mix ecto.drop
mix ecto.create
mix ecto.migrate
mix run priv/repo/seeds.exs
echo "✅ Database reset complete!"
```

Create `bin/db-backup`:

```bash
#!/usr/bin/env bash
set -e

BACKUP_FILE="backup_$(date +%Y%m%d_%H%M%S).sql"
echo "🗄️  Creating backup: $BACKUP_FILE"
pg_dump -h localhost -p 5432 -U postgres myapp_dev > "$BACKUP_FILE"
echo "✅ Backup created: $BACKUP_FILE"
```

## Git Hooks

### Pre-commit Hook

Create `.git/hooks/pre-commit`:

```bash
#!/bin/sh
set -e

echo "🔍 Running pre-commit checks..."

# Format code
mix format --check-formatted

# Run Credo
mix credo --strict

# Run tests
mix test

echo "✅ Pre-commit checks passed!"
```

### Pre-push Hook

Create `.git/hooks/pre-push`:

```bash
#!/bin/sh
set -e

echo "🔍 Running pre-push checks..."

# Run Dialyzer
mix dialyzer

# Run security check
mix sobelow

echo "✅ Pre-push checks passed!"
```

## Documentation

### Add ExDoc

Add to `mix.exs` dependencies:

```elixir
{:ex_doc, "~> 0.31", only: :dev, runtime: false}
```

Update `mix.exs` project configuration:

```elixir
def project do
  [
    # ... existing config
    docs: [
      main: "MyApp",
      extras: ["README.md"]
    ]
  ]
end
```

### Generate Documentation

```bash
# Generate docs
mix docs

# Open docs
open doc/index.html
```

## Deployment

### Docker Support

Create `Dockerfile`:

```dockerfile
FROM hexpm/elixir:1.19.0-erlang-28.0.2-alpine-3.20.2 as build

# Install build dependencies
RUN apk add --no-cache build-base npm git python3

# Prepare build dir
WORKDIR /app

# Install hex + rebar
RUN mix local.hex --force && \
    mix local.rebar --force

# Set build ENV
ENV MIX_ENV="prod"

# Install mix dependencies
COPY mix.exs mix.lock ./
RUN mix deps.get --only $MIX_ENV
RUN mkdir config

# Copy compile-time config files before we compile dependencies
COPY config/config.exs config/${MIX_ENV}.exs config/
RUN mix deps.compile

# Copy priv, lib, and assets
COPY priv priv
COPY lib lib
COPY assets assets

# Compile assets
RUN mix assets.deploy

# Compile the release
RUN mix compile

# Changes to config/runtime.exs don't require recompiling the code
COPY config/runtime.exs config/

COPY rel rel
RUN mix release

# Start a new build stage so that the final image will only contain
# the compiled release and other runtime necessities
FROM alpine:3.20.2 AS app
RUN apk add --no-cache libstdc++ openssl ncurses-libs

WORKDIR /app
RUN chown nobody /app

# Set runner ENV
ENV MIX_ENV="prod"

# Only copy the final release from the build stage
COPY --from=build --chown=nobody:root /app/_build/${MIX_ENV}/rel/myapp ./

USER nobody

# If using a startup script, copy it here
# COPY --from=build --chown=nobody:root /app/bin/server /app/

CMD ["/app/bin/server"]
```

### Fly.io Configuration

Create `fly.toml`:

```toml
app = "myapp"
primary_region = "sjc"

[build]

[env]
  PHX_HOST = "myapp.fly.dev"
  PORT = "8080"

[http_service]
  internal_port = 8080
  force_https = true
  auto_stop_machines = true
  auto_start_machines = true
  min_machines_running = 0
  processes = ["app"]

[[vm]]
  memory = "1gb"
  cpu_kind = "shared"
  cpus = 1

[[statics]]
  guest_path = "/app/lib/myapp-0.1.0/priv/static"
  url_prefix = "/static/"
```

## When to Use These Extras

- **VS Code Enhancements**: Teams with human developers who want IDE productivity
- **Code Quality Tools**: Projects requiring high code standards
- **Performance Monitoring**: Production applications needing observability
- **Enhanced Scripts**: Teams wanting more development workflow options
- **Git Hooks**: Projects requiring automated quality gates
- **Documentation**: Open source projects or large teams
- **Deployment**: Production-ready applications

## Installation

To add any of these features:

1. Copy the relevant configuration files
2. Install additional dependencies
3. Update scripts as needed
4. Configure team preferences

Remember: Start lean, add complexity only when needed.
```
