-- Basic options
vim.g.mapleader = ' '
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = 'a'
vim.opt.clipboard = 'unnamedplus'

-- Clear search highlights on Esc
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Bootstrap packer
local packer_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(packer_path)) > 0 then
  vim.fn.system({
    'git', 'clone', '--depth', '1',
    'https://github.com/wbthomason/packer.nvim',
    packer_path
  })
  vim.cmd [[packadd packer.nvim]]
end

require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use { 'navarasu/onedark.nvim', config = function() vim.cmd 'colorscheme onedark' end }

  -- Git tools
  use 'lewis6991/gitsigns.nvim'
  use 'tpope/vim-fugitive'
  use 'kdheepak/lazygit.nvim'

  -- Completion
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'L3MON4D3/LuaSnip'
  use 'saadparwaiz1/cmp_luasnip'

  -- Telescope
  use { 'nvim-telescope/telescope.nvim', requires = { 'nvim-lua/plenary.nvim' } }
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }

  -- Editor enhancements
  use 'numToStr/Comment.nvim'
  use 'windwp/nvim-autopairs'
  use 'kylechui/nvim-surround'

  -- Elixir-specific
  use 'vim-test/vim-test'
  use { 'elixir-tools/elixir-tools.nvim', requires = { 'nvim-lua/plenary.nvim' } }
end)

-- Elixir tools setup
local elixir = require('elixir')
local elixirls = require('elixir.elixirls')

elixir.setup {
  nextls = { enable = false },
  elixirls = {
    enable = true,
    settings = elixirls.settings {
      dialyzerEnabled = true,
      enableTestLenses = true,
    },
    on_attach = function(_, bufnr)
      local bufmap = function(mode, lhs, rhs, desc)
        vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, silent = true, desc = desc })
      end
      bufmap('n', 'gd', vim.lsp.buf.definition, 'Go to definition')
      bufmap('n', 'K', vim.lsp.buf.hover, 'Hover')
      bufmap('n', 'gr', vim.lsp.buf.references, 'Go to references')
      bufmap('n', '<space>rn', vim.lsp.buf.rename, 'Rename')
      bufmap('n', '<space>f', function() vim.lsp.buf.format { async = true } end, 'Format')
      bufmap('n', '<space>ca', vim.lsp.buf.code_action, 'Code action')
    end,
  },
  projectionist = { enable = false },
}

-- Treesitter
require('nvim-treesitter.configs').setup {
  ensure_installed = { 'elixir', 'lua', 'vim', 'heex', 'eex' },
  highlight = { enable = true },
}

-- Gitsigns
require('gitsigns').setup {
  signs = {
    add = { text = '+' },
    change = { text = '~' },
    delete = { text = '_' },
    topdelete = { text = '‾' },
    changedelete = { text = '~' },
  },
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns
    local function map(mode, l, r, desc)
      vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc })
    end
    map('n', ']c', gs.next_hunk, 'Next git hunk')
    map('n', '[c', gs.prev_hunk, 'Previous git hunk')
    map('n', '<leader>hs', gs.stage_hunk, 'Stage hunk')
    map('n', '<leader>hr', gs.reset_hunk, 'Reset hunk')
    map('n', '<leader>hS', gs.stage_buffer, 'Stage buffer')
    map('n', '<leader>hu', gs.undo_stage_hunk, 'Undo stage hunk')
    map('n', '<leader>hR', gs.reset_buffer, 'Reset buffer')
    map('n', '<leader>hp', gs.preview_hunk, 'Preview hunk')
    map('n', '<leader>hb', function() gs.blame_line { full = true } end, 'Blame line')
    map('n', '<leader>hd', gs.diffthis, 'Diff this')
  end,
}

-- Telescope
require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
      },
    },
  },
}
pcall(require('telescope').load_extension, 'fzf')

vim.keymap.set('n', '<leader>ff', require('telescope.builtin').find_files, { desc = 'Find files' })
vim.keymap.set('n', '<leader>fg', require('telescope.builtin').live_grep, { desc = 'Live grep' })
vim.keymap.set('n', '<leader>fb', require('telescope.builtin').buffers, { desc = 'Find buffers' })
vim.keymap.set('n', '<leader>fh', require('telescope.builtin').help_tags, { desc = 'Help tags' })
vim.keymap.set('n', '<leader>fs', require('telescope.builtin').lsp_document_symbols, { desc = 'LSP symbols' })
vim.keymap.set('n', '<leader>fr', require('telescope.builtin').lsp_references, { desc = 'LSP references' })

-- nvim-cmp
local cmp = require('cmp')
local luasnip = require('luasnip')

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert {
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm { select = true },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'buffer' },
    { name = 'path' },
  },
}

-- Comment.nvim
require('Comment').setup()

-- nvim-autopairs
require('nvim-autopairs').setup()

-- nvim-surround
require('nvim-surround').setup()

-- Lazygit
vim.keymap.set('n', '<leader>gg', '<cmd>LazyGit<cr>', { desc = 'LazyGit' })

-- vim-fugitive keymaps
vim.keymap.set('n', '<leader>gs', '<cmd>Git<cr>', { desc = 'Git status' })
vim.keymap.set('n', '<leader>gc', '<cmd>Git commit<cr>', { desc = 'Git commit' })
vim.keymap.set('n', '<leader>gp', '<cmd>Git push<cr>', { desc = 'Git push' })
vim.keymap.set('n', '<leader>gl', '<cmd>Git log<cr>', { desc = 'Git log' })
vim.keymap.set('n', '<leader>gd', '<cmd>Gdiffsplit<cr>', { desc = 'Git diff split' })

-- vim-test
vim.g['test#strategy'] = 'neovim'
vim.keymap.set('n', '<leader>tn', '<cmd>TestNearest<cr>', { desc = 'Test nearest' })
vim.keymap.set('n', '<leader>tf', '<cmd>TestFile<cr>', { desc = 'Test file' })
vim.keymap.set('n', '<leader>ts', '<cmd>TestSuite<cr>', { desc = 'Test suite' })
vim.keymap.set('n', '<leader>tl', '<cmd>TestLast<cr>', { desc = 'Test last' })
vim.keymap.set('n', '<leader>tv', '<cmd>TestVisit<cr>', { desc = 'Test visit' })

-- Elixir-specific settings and keymaps
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'elixir',
  callback = function()
    vim.opt_local.shiftwidth = 2
    vim.opt_local.tabstop = 2
    vim.opt_local.expandtab = true
    vim.opt_local.textwidth = 98

    local bufmap = function(mode, lhs, rhs, desc)
      vim.keymap.set(mode, lhs, rhs, { buffer = 0, silent = true, desc = desc })
    end

    -- Format on save
    vim.api.nvim_create_autocmd('BufWritePre', {
      buffer = 0,
      callback = function()
        vim.lsp.buf.format { async = false }
      end,
    })

    -- Pipe operator shortcut
    bufmap('i', '<C-l>', ' |> ', 'Insert pipe operator')

    -- IEx terminal
    bufmap('n', '<leader>i', function()
      vim.cmd('split | terminal iex -S mix')
      vim.cmd('wincmd p')
    end, 'Open IEx terminal')
  end,
})
