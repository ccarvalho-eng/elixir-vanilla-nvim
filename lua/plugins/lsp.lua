local M = {}

function M.setup()
  local map = require('config.keymaps').map
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
        local opts = { buffer = bufnr, silent = true }
        map('n', 'gd', vim.lsp.buf.definition, vim.tbl_extend('force', opts, { desc = 'Go to definition' }))
        map('n', 'K', vim.lsp.buf.hover, vim.tbl_extend('force', opts, { desc = 'Hover' }))
        map('n', 'gr', vim.lsp.buf.references, vim.tbl_extend('force', opts, { desc = 'Go to references' }))
        map('n', '<space>rn', vim.lsp.buf.rename, vim.tbl_extend('force', opts, { desc = 'Rename' }))
        map('n', '<space>f', function() vim.lsp.buf.format { async = true } end, vim.tbl_extend('force', opts, { desc = 'Format' }))
        map('n', '<space>la', vim.lsp.buf.code_action, vim.tbl_extend('force', opts, { desc = 'LSP code action' }))
      end,
    },
    projectionist = { enable = false },
  }
end

return M
