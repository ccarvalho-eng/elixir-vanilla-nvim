local M = {}

function M.setup()
  local ok, configs = pcall(require, 'nvim-treesitter.configs')
  if not ok then return end

  configs.setup {
    ensure_installed = { 'elixir', 'lua', 'vim', 'heex', 'eex' },
    highlight = { enable = true },
  }
end

return M
