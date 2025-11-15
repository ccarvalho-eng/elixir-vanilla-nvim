local map = require('config.keymaps').map

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'elixir',
  callback = function()
    vim.opt_local.shiftwidth = 2
    vim.opt_local.tabstop = 2
    vim.opt_local.expandtab = true
    vim.opt_local.textwidth = 98

    local opts = { buffer = 0, silent = true }

    -- Format on save
    vim.api.nvim_create_autocmd('BufWritePre', {
      buffer = 0,
      callback = function()
        vim.lsp.buf.format { async = false }
      end,
    })

    -- Pipe operator shortcut
    map('i', '<C-l>', ' |> ', vim.tbl_extend('force', opts, { desc = 'Insert pipe operator' }))

    -- IEx terminal
    map('n', '<leader>i', function()
      vim.cmd('split | terminal iex -S mix')
      vim.cmd('wincmd p')
    end, vim.tbl_extend('force', opts, { desc = 'Open IEx terminal' }))
  end,
})
