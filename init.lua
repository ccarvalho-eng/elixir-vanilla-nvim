-- Load core configuration
require('config.options')
require('config.keymaps')

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

-- Load plugins
require('packer').startup(require('plugins'))

-- Setup plugin configurations
require('plugins.lsp').setup()
require('plugins.treesitter').setup()
require('plugins.gitsigns').setup()
require('plugins.telescope').setup()
require('plugins.telescope').keymaps()
require('plugins.cmp').setup()
require('plugins.editor').setup()

-- Load autocmds
require('config.autocmds')
