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
local plugins = {
  'lsp',
  'treesitter',
  'gitsigns',
  'telescope',
  'cmp',
  'editor',
}

for _, plugin in ipairs(plugins) do
  local ok, module = pcall(require, 'plugins.' .. plugin)
  if ok then
    if module.setup then module.setup() end
    if module.keymaps then module.keymaps() end
  end
end

-- Load filetype configurations
require('config.filetype')
