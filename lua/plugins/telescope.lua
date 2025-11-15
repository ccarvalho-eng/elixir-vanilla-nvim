local M = {}

function M.setup()
  local ok, telescope = pcall(require, 'telescope')
  if not ok then return end

  telescope.setup {
    defaults = {
      mappings = {
        i = {
          ['<C-u>'] = false,
          ['<C-d>'] = false,
        },
      },
    },
  }

  pcall(telescope.load_extension, 'fzf')
end

function M.keymaps()
  local map = require('config.keymaps').map
  local builtin = require('telescope.builtin')

  map('n', '<leader>ff', builtin.find_files, { desc = 'Find files' })
  map('n', '<leader>fg', builtin.live_grep, { desc = 'Live grep' })
  map('n', '<leader>fb', builtin.buffers, { desc = 'Find buffers' })
  map('n', '<leader>fh', builtin.help_tags, { desc = 'Help tags' })
  map('n', '<leader>fs', builtin.lsp_document_symbols, { desc = 'LSP symbols' })
  map('n', '<leader>fr', builtin.lsp_references, { desc = 'LSP references' })
end

return M
