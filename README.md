# Elixir Vanilla Neovim

Minimal Neovim configuration optimized for Elixir development with modern tooling.

## Features

### Core
- **LSP support** - ElixirLS via elixir-tools.nvim with Dialyzer and test lenses
- **Format on save** - Automatic `mix format` when saving Elixir files
- **Smart completion** - nvim-cmp with LSP, buffer, path, and snippet sources
- **Syntax highlighting** - Treesitter for Elixir, HEEx, EEx, Lua, Vim

### Git Integration
- **Gitsigns** - Git changes in sign column, inline blame, hunk operations
- **Fugitive** - Full Git integration (`:Git`, `:Gdiffsplit`, etc.)
- **LazyGit** - Terminal UI for Git operations

### Editor Enhancements
- **Telescope** - Fuzzy finder for files, grep, LSP symbols
- **Comment.nvim** - Smart commenting with `gcc` and `gc`
- **nvim-autopairs** - Auto-close brackets and quotes
- **nvim-surround** - Easy surround editing (`ys`, `cs`, `ds`)

### Testing
- **vim-test** - Sophisticated test runner with multiple strategies
- **IEx integration** - Built-in terminal launcher

## Keymaps

### LSP (Elixir files)
| Key | Action |
|-----|--------|
| `gd` | Go to definition |
| `gr` | Go to references |
| `K` | Hover documentation |
| `<space>rn` | Rename symbol |
| `<space>f` | Format buffer |
| `<space>ca` | Code action |

### Telescope
| Key | Action |
|-----|--------|
| `<space>ff` | Find files |
| `<space>fg` | Live grep |
| `<space>fb` | Find buffers |
| `<space>fh` | Help tags |
| `<space>fs` | LSP document symbols |
| `<space>fr` | LSP references |

### Git (Gitsigns)
| Key | Action |
|-----|--------|
| `]c` | Next hunk |
| `[c` | Previous hunk |
| `<space>hs` | Stage hunk |
| `<space>hr` | Reset hunk |
| `<space>hS` | Stage buffer |
| `<space>hR` | Reset buffer |
| `<space>hp` | Preview hunk |
| `<space>hb` | Blame line |
| `<space>hd` | Diff this |

### Git (Fugitive & LazyGit)
| Key | Action |
|-----|--------|
| `<space>gg` | Open LazyGit |
| `<space>gs` | Git status |
| `<space>gc` | Git commit |
| `<space>gp` | Git push |
| `<space>gl` | Git log |
| `<space>gd` | Git diff split |

### Testing
| Key | Action |
|-----|--------|
| `<space>tn` | Test nearest |
| `<space>tf` | Test file |
| `<space>ts` | Test suite |
| `<space>tl` | Test last |
| `<space>tv` | Test visit |

### Elixir-specific
| Key | Action |
|-----|--------|
| `<space>i` | Open IEx terminal |
| `<Ctrl-l>` | Insert pipe operator `\|>` (insert mode) |

### Completion
| Key | Action |
|-----|--------|
| `<Tab>` | Next completion / expand snippet |
| `<S-Tab>` | Previous completion / jump back |
| `<CR>` | Confirm selection |
| `<C-Space>` | Trigger completion |

### Commenting
| Key | Action |
|-----|--------|
| `gcc` | Toggle line comment |
| `gc` | Toggle comment (visual/motion) |

## Installation

```bash
git clone git@github.com:ccarvalho-eng/elixir-vanilla-nvim.git ~/.config/nvim
```

First launch will automatically install plugins via Packer. Run `:PackerSync` to install all plugins.