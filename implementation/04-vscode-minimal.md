# Step 4: VS Code Minimal Setup

**Goal**: Configure VS Code for AI agent compatibility

**Prerequisites**: Step 3 completed, VS Code installed

**Estimated Time**: 2 minutes

## 4.1 Required Extensions

Install these extensions:

```
JakeBecker.elixir-ls
jnoortheen.nix-ide
bradlc.vscode-tailwindcss
```

## 4.2 Create .vscode/settings.json

```json
{
  "elixirLS.dialyzerEnabled": false,
  "elixirLS.fetchDeps": false,
  "elixirLS.suggestSpecs": false,
  "elixirLS.mixEnv": "dev",
  "elixirLS.projectDir": ".",
  
  "files.associations": {
    "*.heex": "phoenix-heex",
    "*.leex": "phoenix-heex"
  },
  
  "emmet.includeLanguages": {
    "phoenix-heex": "html",
    "elixir": "html"
  },
  
  "tailwindCSS.includeLanguages": {
    "phoenix-heex": "html",
    "elixir": "html"
  },
  
  "tailwindCSS.experimental.classRegex": [
    ["class[:]\\s*\"([^\"]*)", "\"([^\"]*)\""],
    ["class[:]\\s*'([^']*)", "'([^']*)'"]
  ],
  
  "terminal.integrated.defaultProfile.linux": "bash",
  "terminal.integrated.defaultProfile.osx": "bash",
  
  "editor.formatOnSave": true,
  "files.trimTrailingWhitespace": true,
  "files.insertFinalNewline": true,
  
  "search.exclude": {
    "**/node_modules": true,
    "**/_build": true,
    "**/deps": true,
    "**/.devenv": true,
    "**/priv/static": true
  },
  
  "files.watcherExclude": {
    "**/_build/**": true,
    "**/deps/**": true,
    "**/.devenv/**": true,
    "**/node_modules/**": true
  }
}
```

## 4.3 Create .vscode/extensions.json

```json
{
  "recommendations": [
    "JakeBecker.elixir-ls",
    "jnoortheen.nix-ide",
    "bradlc.vscode-tailwindcss"
  ]
}
```

## 4.4 Verify Setup

1. Open project in VS Code
2. Install recommended extensions when prompted
3. Open any `.ex` file - ElixirLS should activate
4. Check terminal uses devenv environment

## Features Enabled

- **ElixirLS**: Language server for Elixir
- **File Associations**: .heex files recognized
- **TailwindCSS**: IntelliSense for CSS classes
- **Auto-formatting**: Format on save
- **Exclusions**: Ignore build artifacts

## Features Excluded

Moved to EXTRAS.md:
- VS Code tasks and launch configurations
- Code snippets and autocomplete helpers
- Debugging configurations
- Keyboard shortcuts
- Complex workspace settings

## Verification

You should have:
- Syntax highlighting for Elixir/Phoenix files
- ElixirLS providing language features
- TailwindCSS class completion in .heex files
- Terminal automatically using devenv environment

## Next Step

Continue to [Template README](05-template-readme.md)
