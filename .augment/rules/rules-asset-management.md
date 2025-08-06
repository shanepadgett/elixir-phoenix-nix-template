---
type: "agent_requested"
description: "assets tailwind css javascript build pipeline"
---
# Asset Management Rules

- Use `mix assets.setup` for initial asset setup
- Use `mix assets.deploy` for production builds
- TailwindCSS + daisyUI configured by default
- Assets located in `assets/` directory
- Built assets go to `priv/static/`
- Use Phoenix asset pipeline for development
- Configure TailwindCSS in `assets/tailwind.config.js`
- JavaScript builds automatically during development
