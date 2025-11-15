local M = {}

function M.setup()
  local map = require('config.keymaps').map

  -- Comment.nvim
  local ok, comment = pcall(require, 'Comment')
  if ok then comment.setup() end

  -- nvim-autopairs
  ok = pcall(require, 'nvim-autopairs')
  if ok then require('nvim-autopairs').setup() end

  -- nvim-surround
  ok = pcall(require, 'nvim-surround')
  if ok then require('nvim-surround').setup() end

  -- Claude Code
  ok = pcall(require, 'claudecode')
  if ok then
    require('claudecode').setup({
      terminal = {
        split_side = 'right',
        split_width_percentage = 0.35,
        git_repo_cwd = true,
        provider = 'snacks',
      },
      selection = {
        track_selection = true,
        focus_after_send = true,
      },
      diff = {
        auto_close_on_accept = true,
        vertical_split = true,
      },
    })

    -- Claude Code keymaps
    map('n', '<leader>ac', '<cmd>ClaudeCode<cr>', { desc = 'Toggle Claude Code' })
    map('n', '<leader>af', '<cmd>ClaudeCodeFocus<cr>', { desc = 'Focus Claude Code' })
    map('n', '<leader>ar', '<cmd>ClaudeCode resume<cr>', { desc = 'Resume Claude session' })
    map('n', '<leader>aC', '<cmd>ClaudeCode continue<cr>', { desc = 'Continue Claude session' })
    map('n', '<leader>am', '<cmd>ClaudeCodeSelectModel<cr>', { desc = 'Select Claude model' })
    map('n', '<leader>ab', '<cmd>ClaudeCodeAdd %<cr>', { desc = 'Add current buffer to Claude' })
    map('v', '<leader>as', '<cmd>ClaudeCodeSend<cr>', { desc = 'Send selection to Claude' })
    map('n', '<leader>aa', '<cmd>ClaudeCodeDiffAccept<cr>', { desc = 'Accept Claude diff' })
    map('n', '<leader>ad', '<cmd>ClaudeCodeDiffDeny<cr>', { desc = 'Reject Claude diff' })
  end

  -- Lazygit
  map('n', '<leader>gg', '<cmd>LazyGit<cr>', { desc = 'LazyGit' })

  -- vim-fugitive
  map('n', '<leader>gs', '<cmd>Git<cr>', { desc = 'Git status' })
  map('n', '<leader>gc', '<cmd>Git commit<cr>', { desc = 'Git commit' })
  map('n', '<leader>gp', '<cmd>Git push<cr>', { desc = 'Git push' })
  map('n', '<leader>gl', '<cmd>Git log<cr>', { desc = 'Git log' })
  map('n', '<leader>gd', '<cmd>Gdiffsplit<cr>', { desc = 'Git diff split' })

  -- vim-test
  vim.g['test#strategy'] = 'neovim'
  map('n', '<leader>tn', '<cmd>TestNearest<cr>', { desc = 'Test nearest' })
  map('n', '<leader>tf', '<cmd>TestFile<cr>', { desc = 'Test file' })
  map('n', '<leader>ts', '<cmd>TestSuite<cr>', { desc = 'Test suite' })
  map('n', '<leader>tl', '<cmd>TestLast<cr>', { desc = 'Test last' })
  map('n', '<leader>tv', '<cmd>TestVisit<cr>', { desc = 'Test visit' })
end

return M
