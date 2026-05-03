# 💤 LazyVim

A starter template for [LazyVim](https://github.com/LazyVim/LazyVim).
Refer to the [documentation](https://lazyvim.github.io/installation) to get started.

## Bootstrap

Install the external tools this config expects before the first run:

- `git`
- `make`
- `node`
- `python3`
- `go`
- `rg`

Then open Neovim and run:

```vim
:Lazy sync
:Mason
:TSUpdate
```

Language support and debugging currently expect these Mason-managed tools:

- TypeScript/JavaScript: `ts_ls`, `eslint`, `js-debug-adapter`
- Python: `pyright`, `ruff`, `debugpy`
- Go: `gopls`, `delve`
- Platform engineering: `terraformls`, `helm_ls`, `yamlls`, `dockerls`, `bashls`

Additional workflow plugins included:

- Telescope with `fzf` and `ui-select`
- Trouble for diagnostics, quickfix, and symbol navigation
- Helm filetype support via `vim-helm`
- `nvim-lint` for shell, Dockerfile, Terraform, Helm, and YAML linting
- Kubernetes helpers for context/namespace picking plus `kubectl` and `helm` terminal wrappers

For platform linting, install these CLI tools on your system `PATH`:

- `shellcheck`
- `hadolint`
- `tflint`
- `yamllint`
- `kubectl`
- `helm`
