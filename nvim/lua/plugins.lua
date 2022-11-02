-- Install Packer
--local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

--if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
--vim.fn.system({
--"git",
--"clone",
--"--depth",
--"1",
--"https://github.com/wbthomason/packer.nvim",
--install_path,
--})
--vim.api.nvim_command("packadd packer.nvim")
--end

-- Use Packer
local packer = require("packer")
local use = packer.use

return require("packer").startup(function()
  -- Plugin Manager
  use("wbthomason/packer.nvim")
  -- LSP and Language specific
  use("hashivim/vim-terraform")
  use("nvim-lua/lsp-status.nvim")
  use("nvim-lua/lsp_extensions.nvim") -- deprecated: only used for rust. 
  use("onsails/lspkind-nvim")
  use("tpope/vim-markdown")
  use('fatih/vim-go')
  -- Completion
  use("hrsh7th/cmp-buffer")
  use("hrsh7th/cmp-cmdline")
  use("hrsh7th/cmp-nvim-lsp")
  use("hrsh7th/cmp-path")
  use("hrsh7th/cmp-vsnip")
  use("hrsh7th/nvim-cmp")
  use("hrsh7th/vim-vsnip")
  use("hrsh7th/vim-vsnip-integ")
  use("rafamadriz/friendly-snippets")
  -- Git
  use("knsh14/vim-github-link")
  use("tpope/vim-fugitive")
  use('airblade/vim-gitgutter')
  use({ "lewis6991/gitsigns.nvim", requires = { "nvim-lua/plenary.nvim" } })
  -- Theme and appearance
  use("akinsho/nvim-bufferline.lua")
  use('kaicataldo/material.vim')
  use({ "nvim-lualine/lualine.nvim", requires = { "kyazdani42/nvim-web-devicons", opt = true } })
  -- Navigation
  use("neovim/nvim-lspconfig")
  use("zirrostig/vim-schlepp")
  use('easymotion/vim-easymotion')
  use({ "kyazdani42/nvim-tree.lua", requires = "kyazdani42/nvim-web-devicons" })
  use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
  use({ "nvim-telescope/telescope.nvim", requires = { { "nvim-lua/plenary.nvim" } } })
  -- Misc
  use("ekickx/clipboard-image.nvim")
  use("scrooloose/nerdcommenter")
end)
