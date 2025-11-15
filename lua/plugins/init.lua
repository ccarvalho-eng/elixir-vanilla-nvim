return function(use)
  use 'wbthomason/packer.nvim'
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use { 'navarasu/onedark.nvim', config = function() vim.cmd 'colorscheme onedark' end }

  -- Git tools
  use 'lewis6991/gitsigns.nvim'
  use 'tpope/vim-fugitive'
  use 'kdheepak/lazygit.nvim'

  -- Completion
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'L3MON4D3/LuaSnip'
  use 'saadparwaiz1/cmp_luasnip'

  -- Telescope
  use { 'nvim-telescope/telescope.nvim', requires = { 'nvim-lua/plenary.nvim' } }
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }

  -- Editor enhancements
  use 'numToStr/Comment.nvim'
  use 'windwp/nvim-autopairs'
  use 'kylechui/nvim-surround'

  -- Elixir-specific
  use 'vim-test/vim-test'
  use { 'elixir-tools/elixir-tools.nvim', requires = { 'nvim-lua/plenary.nvim' } }

  -- Claude Code
  use 'folke/snacks.nvim'
  use { 'coder/claudecode.nvim', requires = { 'folke/snacks.nvim' } }
end
