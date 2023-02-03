-- Plugins
require("packer")
require("plugins") -- Plugins installed with packer
require("lsp") -- lspconfig
require("completion") -- nvim-cmp
require("nvim-tree-config")
require("md-fenced-config")
require("bufferline-config")
require("schlepp-config")
require("statusline") -- lualine
require("treesitter")

-- Leader key
vim.g.mapleader = "j"

-- Color Scheme
--
vim.cmd 'colorscheme material'
vim.g.material_theme_style = "dark"

---- Vim Imports
vim.cmd("so ~/.config/nvim/lua/vim-go.vim")
vim.cmd("so ~/.config/nvim/settings.vim")
vim.cmd("so ~/.config/nvim/mappings.vim")
vim.cmd("so ~/.config/nvim/commands.vim")
vim.cmd("so ~/.config/nvim/autocomands.vim")
vim.cmd("so ~/.config/nvim/misc.vim")
