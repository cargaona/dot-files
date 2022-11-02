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
  use {'fatih/vim-go'}
  use('airblade/vim-gitgutter')
  use("tpope/vim-fugitive")
  use("wbthomason/packer.nvim")
  use("vim-test/vim-test")
  use('easymotion/vim-easymotion')
  use('kaicataldo/material.vim')
  use("rktjmp/lush.nvim")
  use({
    "nvim-lualine/lualine.nvim",
    requires = { "kyazdani42/nvim-web-devicons", opt = true },
  })
  use({ "kyazdani42/nvim-tree.lua", requires = "kyazdani42/nvim-web-devicons" })
  use("akinsho/nvim-bufferline.lua")
  use({ "lewis6991/gitsigns.nvim", requires = { "nvim-lua/plenary.nvim" } })
  use("tpope/vim-markdown")
  use("hashivim/vim-terraform")
  use("neovim/nvim-lspconfig")
  use("hrsh7th/nvim-cmp")
  use("hrsh7th/cmp-buffer")
  use("knsh14/vim-github-link")
  use("hrsh7th/cmp-path")
  use("nvim-lua/lsp_extensions.nvim")
  use("hrsh7th/cmp-cmdline")
  use("hrsh7th/cmp-vsnip")
  use("hrsh7th/cmp-nvim-lsp")
  use("hrsh7th/vim-vsnip-integ")
  use("hrsh7th/vim-vsnip")
  use("rafamadriz/friendly-snippets")
  use("nvim-lua/lsp-status.nvim")
  use("onsails/lspkind-nvim")
  use("ekickx/clipboard-image.nvim")
  use("unblevable/quick-scope")
  use("zirrostig/vim-schlepp")
  use("scrooloose/nerdcommenter")
  use({
    "nvim-telescope/telescope.nvim",
    requires = { { "nvim-lua/plenary.nvim" } },
  })
  use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
end)
