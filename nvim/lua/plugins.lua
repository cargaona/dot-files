return {
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require("lspconfig")
      lspconfig.terraformls.setup({})
end, 
}, 
  -- Git and GitHub plugins
  { 'tpope/vim-fugitive' },  -- Git integration
  { 'knsh14/vim-github-link' },  -- GitHub link generation
  { 'lewis6991/gitsigns.nvim', dependencies = { 'nvim-lua/plenary.nvim' } },  -- Git signs (git diff indicators in the gutter)

  -- LSP and Language-specific Plugins
  { 'neovim/nvim-lspconfig' },  -- LSP configurations
  { 'nvim-lua/lsp-status.nvim' },  -- LSP status display
  { 'onsails/lspkind-nvim' },  -- LSP symbols (icons)
  { 'tpope/vim-markdown' },  -- Markdown syntax support
  { 'fatih/vim-go' },  -- Go language support

  -- Completion Plugins
  { 'hrsh7th/nvim-cmp' },  -- Completion framework
  { 'hrsh7th/cmp-path' },  -- Path completion
  { 'hrsh7th/cmp-vsnip' },  -- Snippet completion (vsnip)
  { 'hrsh7th/vim-vsnip' },  -- VSnip snippets
  { 'hrsh7th/cmp-buffer' },  -- Buffer completion
  { 'hrsh7th/cmp-cmdline' },  -- Command-line completion
  { 'hrsh7th/cmp-nvim-lsp' },  -- LSP completion
  { 'hrsh7th/vim-vsnip-integ' },  -- VSnip integration
  { 'rafamadriz/friendly-snippets' },  -- Preconfigured snippets

  -- Theme and Appearance
  { 'nvim-treesitter/nvim-treesitter' },  -- Syntax highlighting and parsing
  { 'kaicataldo/material.vim' },  -- Material design theme
  { 'itchyny/lightline.vim' },  -- Lightline statusline

  -- Navigation Plugins
  { 'akinsho/nvim-bufferline.lua' },  -- Buffer line (tabline management)
  { 'easymotion/vim-easymotion' },  -- Easy motion (quick cursor movements)
  { 'kyazdani42/nvim-tree.lua', dependencies = { 'kyazdani42/nvim-web-devicons' } },  -- File tree explorer

  -- Miscellaneous
  { 'scrooloose/nerdcommenter' },  -- Easy commenting of code
  { 'nvim-telescope/telescope.nvim', version = '0.1.4', dependencies = { 'nvim-lua/plenary.nvim' } },  -- Fuzzy finder for files, buffers, etc.
}


