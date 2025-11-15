local M = {}

function M.setup()
  local ok, gitsigns = pcall(require, 'gitsigns')
  if not ok then return end

  gitsigns.setup {
    signs = {
      add = { text = '+' },
      change = { text = '~' },
      delete = { text = '_' },
      topdelete = { text = '‾' },
      changedelete = { text = '~' },
    },
    on_attach = function(bufnr)
      local gs = package.loaded.gitsigns
      local map = require('config.keymaps').map
      local opts = { buffer = bufnr }

      map('n', ']c', gs.next_hunk, vim.tbl_extend('force', opts, { desc = 'Next git hunk' }))
      map('n', '[c', gs.prev_hunk, vim.tbl_extend('force', opts, { desc = 'Previous git hunk' }))
      map('n', '<leader>hs', gs.stage_hunk, vim.tbl_extend('force', opts, { desc = 'Stage hunk' }))
      map('n', '<leader>hr', gs.reset_hunk, vim.tbl_extend('force', opts, { desc = 'Reset hunk' }))
      map('n', '<leader>hS', gs.stage_buffer, vim.tbl_extend('force', opts, { desc = 'Stage buffer' }))
      map('n', '<leader>hu', gs.undo_stage_hunk, vim.tbl_extend('force', opts, { desc = 'Undo stage hunk' }))
      map('n', '<leader>hR', gs.reset_buffer, vim.tbl_extend('force', opts, { desc = 'Reset buffer' }))
      map('n', '<leader>hp', gs.preview_hunk, vim.tbl_extend('force', opts, { desc = 'Preview hunk' }))
      map('n', '<leader>hb', function() gs.blame_line { full = true } end, vim.tbl_extend('force', opts, { desc = 'Blame line' }))
      map('n', '<leader>hd', gs.diffthis, vim.tbl_extend('force', opts, { desc = 'Diff this' }))
    end,
  }
end

return M
