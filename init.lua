-- Basic options
vim.g.mapleader = ' '
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = 'a'
vim.opt.clipboard = 'unnamedplus'

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
  use 'neovim/nvim-lspconfig'
  use 'williamboman/mason.nvim'
  use 'williamboman/mason-lspconfig.nvim'
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use { 'dracula/vim', config = function() vim.cmd 'colorscheme dracula' end }
end)

-- LSP on_attach
local on_attach = function(_, bufnr)
  local bufmap = function(mode, lhs, rhs)
    vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, silent = true })
  end
  bufmap('n', 'gd', vim.lsp.buf.definition)
  bufmap('n', 'K', vim.lsp.buf.hover)
  bufmap('n', 'gr', vim.lsp.buf.references)
  bufmap('n', '<space>rn', vim.lsp.buf.rename)
  bufmap('n', '<space>f', function() vim.lsp.buf.format { async = true } end)

  -- Format on save for Elixir files
  if vim.bo[bufnr].filetype == 'elixir' then
    vim.api.nvim_create_autocmd('BufWritePre', {
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.format { async = false }
      end,
    })
  end
end

-- Mason setup
require('mason').setup()
require('mason-lspconfig').setup {
  ensure_installed = { 'elixirls' },
  automatic_installation = true,
}

-- Default config for all servers
vim.lsp.config('*', { on_attach = on_attach })

-- Example: ElixirLS specific config
vim.lsp.config('elixirls', {
  on_attach = on_attach,
})

-- Treesitter
require('nvim-treesitter.configs').setup {
  ensure_installed = { 'elixir', 'lua', 'vim' },
  highlight = { enable = true },
}

-- Elixir test functions
local function run_mix_test(args)
  local cmd = 'mix test' .. (args and ' ' .. args or '')
  vim.cmd('split | terminal ' .. cmd)
  vim.cmd('wincmd p')
end

local function get_current_test()
  local line = vim.api.nvim_win_get_cursor(0)[1]
  local filename = vim.api.nvim_buf_get_name(0)
  return filename .. ':' .. line
end

-- Elixir-specific settings and keymaps
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'elixir',
  callback = function()
    -- Elixir-specific settings
    vim.opt_local.shiftwidth = 2
    vim.opt_local.tabstop = 2
    vim.opt_local.expandtab = true
    vim.opt_local.textwidth = 98

    local bufmap = function(mode, lhs, rhs, desc)
      vim.keymap.set(mode, lhs, rhs, { buffer = 0, silent = true, desc = desc })
    end

    -- Test keymaps
    bufmap('n', '<leader>ta', function() run_mix_test() end, 'Run all tests')
    bufmap('n', '<leader>tf', function() run_mix_test(vim.fn.expand('%')) end, 'Run current file tests')
    bufmap('n', '<leader>tt', function() run_mix_test(get_current_test()) end, 'Run test at cursor')
    bufmap('n', '<leader>tl', function() run_mix_test('--failed') end, 'Run last failed tests')

    -- Pipe operator shortcut
    bufmap('i', '<C-l>', ' |> ', 'Insert pipe operator')

    -- IEx terminal
    bufmap('n', '<leader>i', function()
      vim.cmd('split | terminal iex -S mix')
      vim.cmd('wincmd p')
    end, 'Open IEx terminal')
  end,
})
