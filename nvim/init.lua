-- Plugins
require("packer")
require("plugins") -- Plugins installed with packer
require("lsp") -- lspconfig
require("snippets") -- vsnip
require("completion") -- nvim-cmp
require("nvim-tree-config")
require("md-fenced-config")
require("treesitter-config")
require("quick-scope-config")
require("bufferline-config")
require("schlepp-config")
require("statusline") -- lualine
require("test-config")
require("finder") -- telescope
-- require("colorscheme-config")

-- Leader key
vim.g.mapleader = ","

-- Color Scheme
vim.cmd 'colorscheme material'
vim.g.material_theme_style = "ocean"
--
---- Vim Imports
vim.cmd("so ~/.config/nvim/settings.vim")
vim.cmd("so ~/.config/nvim/mappings.vim")
vim.cmd("so ~/.config/nvim/commands.vim")
vim.cmd("so ~/.config/nvim/autocomands.vim")
vim.cmd("so ~/.config/nvim/misc.vim")
