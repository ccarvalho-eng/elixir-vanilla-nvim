return function(use)
  -- Plugin manager
  use 'wbthomason/packer.nvim'

  -- UI & Syntax
  use {
    'navarasu/onedark.nvim',
    config = function()
      local ok = pcall(vim.cmd, 'colorscheme onedark')
      if not ok then vim.cmd 'colorscheme default' end
    end
  }
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }

  -- LSP & Completion
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'L3MON4D3/LuaSnip'
  use 'saadparwaiz1/cmp_luasnip'

  -- Fuzzy Finder
  use { 'nvim-telescope/telescope.nvim', requires = { 'nvim-lua/plenary.nvim' } }
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }

  -- Git
  use 'lewis6991/gitsigns.nvim'
  use 'tpope/vim-fugitive'
  use 'kdheepak/lazygit.nvim'

  -- Editor Enhancements
  use 'numToStr/Comment.nvim'
  use 'windwp/nvim-autopairs'
  use 'kylechui/nvim-surround'

  -- Language-Specific
  use 'vim-test/vim-test'
  use { 'elixir-tools/elixir-tools.nvim', requires = { 'nvim-lua/plenary.nvim' } }

  -- AI Assistant
  use 'folke/snacks.nvim'
  use { 'coder/claudecode.nvim', requires = { 'folke/snacks.nvim' } }
end
