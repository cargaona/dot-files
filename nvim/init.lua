-- Leader key
vim.g.mapleader = "j"

require("config.lazy")
--require("config.obsidian")
require("config.git")
require("config.go")
require("config.lightline")
require("config.lsp")
require("config.mappings")
require("config.md-fenced")
require("config.nvim-tree")
require("config.schlepp")
require("config.settings")
require("config.telescope")
require("config.bufferline")
require("config.autocommands")
require("config.commands")
require("config.completion")

-- Color Scheme
vim.cmd 'colorscheme material'
vim.g.material_theme_style = "dark"
