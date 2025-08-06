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
      '';
    };
  };

  # Shell configuration
  enterShell = ''
    echo "🚀 Phoenix 1.8.0 + Nix Development Environment"
    echo "📦 Elixir $(elixir --version | head -n1)"
    echo "🗄️  PostgreSQL 17 available on localhost:5432"
  '';
}
