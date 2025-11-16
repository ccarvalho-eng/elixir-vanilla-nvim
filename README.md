# Vanilla Neovim

Minimal Neovim configuration optimized for Elixir development with modern tooling and AI assistance.

## Features

- **LSP** - ElixirLS with Dialyzer, test lenses, format-on-save
- **Completion** - nvim-cmp with LSP, buffer, path, and snippets
- **Git** - Gitsigns, Fugitive, LazyGit integration
- **Fuzzy Finder** - Telescope with FZF native
- **Testing** - vim-test + IEx terminal integration
- **AI** - Claude Code integration with diff support
- **Editor** - Auto-pairs, surround, smart commenting, Treesitter

## Keymaps

Leader key: `<space>`

### LSP (Elixir buffers)
| Key | Action |
|-----|--------|
| `gd` | Go to definition |
| `gr` | References |
| `K` | Hover docs |
| `<space>rn` | Rename |
| `<space>f` | Format |
| `<space>la` | Code action |

### Telescope
| Key | Action |
|-----|--------|
| `<space>ff` | Find files |
| `<space>fg` | Live grep |
| `<space>fb` | Buffers |
| `<space>fh` | Help |
| `<space>fs` | Symbols |
| `<space>fr` | References |

### Git
| Key | Action |
|-----|--------|
| `]c` / `[c` | Next/prev hunk |
| `<space>hs` / `<space>hr` | Stage/reset hunk |
| `<space>hp` | Preview hunk |
| `<space>hb` | Blame line |
| `<space>gg` | LazyGit |
| `<space>gs` | Git status |
| `<space>gd` | Diff split |

### Testing
| Key | Action |
|-----|--------|
| `<space>tn` | Test nearest |
| `<space>tf` | Test file |
| `<space>ts` | Test suite |
| `<space>tl` | Test last |
| `<space>i` | IEx terminal |

### Claude Code
| Key | Action |
|-----|--------|
| `<space>ac` | Toggle Claude |
| `<space>af` | Focus Claude |
| `<space>ar` | Resume session |
| `<space>aC` | Continue session |
| `<space>am` | Select model |
| `<space>ab` | Add buffer |
| `<space>as` | Send selection (visual) |
| `<space>aa` | Accept diff |
| `<space>ad` | Reject diff |

### Editing
- `gcc` / `gc` - Toggle comment
- `<Tab>` / `<S-Tab>` - Navigate completion
- `<C-l>` - Insert `|>` (insert mode)

## Installation

```bash
git clone <repo-url> ~/.config/nvim-vanilla
nvim  # Plugins install automatically on first launch
```

Run `:PackerSync` to update plugins.