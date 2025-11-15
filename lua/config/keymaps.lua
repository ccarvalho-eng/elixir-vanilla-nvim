local M = {}

-- Reusable keymap helper
function M.map(mode, lhs, rhs, opts)
  opts = opts or {}
  vim.keymap.set(mode, lhs, rhs, opts)
end

-- Core keymaps
M.map('n', '<Esc>', '<cmd>nohlsearch<CR>')

return M
