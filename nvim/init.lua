-- Plugins
require("plugins") -- Plugins installed with packer
require("packer")
require("lsp") -- lspconfig
require("finder") -- telescope
require("snippets") -- vsnip
require("completion") -- nvim-cmp
require("statusline") -- lualine
require("nvim-tree-config")
require("md-fenced-config")
require("treesitter-config")
require("quick-scope-config")
require("bufferline-config")
require("schlepp-config")
require("colorscheme-config")

-- Leader key
vim.g.mapleader = ","

-- Color Scheme
vim.cmd 'colorscheme material'
vim.g.material_style = "darker"

---- Vim Imports
vim.cmd("so ~/.config/nvim/settings.vim")
vim.cmd("so ~/.config/nvim/mappings.vim")
vim.cmd("so ~/.config/nvim/commands.vim")
vim.cmd("so ~/.config/nvim/autocomands.vim")
vim.cmd("so ~/.config/nvim/misc.vim")
