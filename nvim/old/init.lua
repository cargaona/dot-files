 --Plugins
require("packer")
require("plugins")
require("go-config")
require("git-config")
require("lsp-config")
require("schlepp-config")
require("lightline-config")
require("md-fenced-config")
require("nvim-tree-config")
require("telescope-config")
require("bufferline-config")
require("completion-config")
require("treesitter-config")

-- Leader key
vim.g.mapleader = "j"

-- Color Scheme
vim.cmd 'colorscheme material'
vim.g.material_theme_style = "dark"

-- Vim Imports
vim.cmd("so ~/.config/nvim/mappings.vim")
vim.cmd("so ~/.config/nvim/settings.vim")
vim.cmd("so ~/.config/nvim/commands.vim")
vim.cmd("so ~/.config/nvim/autocomands.vim")
vim.cmd("so ~/.config/nvim/misc.vim")
