-- Plugins
require("packer")
require("plugins")
require("lsp")
require("finder")
require("completion")
require("git-config")
require("statusline")
require("treesitter")
require("schlepp-config")
require("md-fenced-config")
require("nvim-tree-config")
require("bufferline-config")

-- Leader key
vim.g.mapleader = "j"

-- Color Scheme
vim.cmd 'colorscheme material'
vim.g.material_theme_style = "dark"

-- Vim Imports
vim.cmd("so ~/.config/nvim/mappings.vim")
vim.cmd("so ~/.config/nvim/lua/vim-go.vim")
vim.cmd("so ~/.config/nvim/settings.vim")
vim.cmd("so ~/.config/nvim/commands.vim")
vim.cmd("so ~/.config/nvim/autocomands.vim")
vim.cmd("so ~/.config/nvim/misc.vim")
