# Step 1: Nix Foundation Setup

**Goal**: Create minimal Nix development environment for Phoenix 1.8.0

**Prerequisites**: Nix and devenv installed (check this via terminal first)

## 1.1
Use devenv init to get things scaffolded

## 1.2 Update devenv.nix

```nix
{ pkgs, lib, config, inputs, ... }:

{
  # Environment variables
  env = {
    # Locale
    LC_ALL = "en_US.UTF-8";
    LANG = "en_US.UTF-8";

    # Elixir environment
    MIX_HOME = "${config.env.DEVENV_STATE}/mix";
    HEX_HOME = "${config.env.DEVENV_STATE}/hex";
    ERL_AFLAGS = "-kernel shell_history enabled";

    # Phoenix environment
    MIX_ENV = "dev";
    PHX_SERVER = "true";

    # Database configuration
    DATABASE_URL = "postgres://postgres@localhost:5432/myapp_dev";

    # Path configuration
    PATH = lib.mkForce "${config.env.MIX_HOME}/bin:${config.env.HEX_HOME}/bin:${config.env.PATH}";
  };

  # Essential packages
  packages = with pkgs; [
    git
    curl
    postgresql_17
    lsof
  ];

  # Language support
  languages = {
    elixir = {
      enable = true;
      package = pkgs.elixir_1_19;
    };
  };

  # Services
  services = {
    postgres = {
      enable = true;
      package = pkgs.postgresql_17;
      listen_addresses = "127.0.0.1";
      port = 5432;
      initialDatabases = [
        { name = "myapp_dev"; }
        { name = "myapp_test"; }
      ];
      initialScript = ''
        CREATE USER postgres SUPERUSER;
        ALTER USER postgres PASSWORD '';
      '';
    };
  };

  # Process management
  processes = {
    postgres.exec = "postgres";
  };

  # Shell configuration
  enterShell = ''
    echo "🚀 Phoenix 1.8.0 + Nix Development Environment"
    echo "📦 Elixir $(elixir --version | head -n1)"
    echo "🗄️  PostgreSQL 17 available on localhost:5432"
    echo ""
    echo "Next steps:"
    echo "  • Continue to step 2: Phoenix Setup"
    echo "  • Or run: bin/setup (after completing all steps)"
  '';
}
```evenv
```

## 1.3 Create devenv.yaml

```yaml
inputs:
  nixpkgs:
    url: github:NixOS/nixpkgs/nixpkgs-unstable
  devenv:
    url: github:cachix/devenv
```

## 1.4 Initialize Environment

```bash
# Allow direnv
direnv allow

# Enter development shell
devenv shell

# Verify setup
elixir --version
postgres --version
```

## Verification

You should see:
- Elixir 1.19.x
- Erlang/OTP 28.x
- PostgreSQL 17.x
- Environment variables set correctly

## Next Step

Continue to [Phoenix Setup](02-phoenix-setup.md)
