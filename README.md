# Elixir Vanilla Neovim

Minimal Neovim configuration optimized for Elixir development.

## Features

- **Format on save** - Automatic `mix format` when saving Elixir files
- **Test running** - Quick test execution with keymaps
- **LSP support** - ElixirLS integration via Mason
- **IEx integration** - Built-in terminal launcher
- **Elixir-specific settings** - Proper indentation and line width

## Keymaps

| Key | Action |
|-----|--------|
| `<space>ta` | Run all tests |
| `<space>tf` | Run current file tests |
| `<space>tt` | Run test at cursor |
| `<space>tl` | Run failed tests |
| `<space>i` | Open IEx terminal |
| `<Ctrl-l>` | Insert pipe operator `\|>` |

## Installation

```bash
git clone git@github.com:ccarvalho-eng/elixir-vanilla-nvim.git ~/.config/nvim
```

First launch will automatically install plugins via Packer.