-- Leader key
vim.g.mapleader = "j"

require("config.lazy")
require("config.go")
require("config.git")
require("config.lsp")
require("config.schlepp")
require("config.lightline")
require("config.md-fenced")
require("config.nvim-tree")
require("config.telescope")
require("config.bufferline")
require("config.completion")
require("config.autocommands")
require("config.commands")
require("config.mappings")
require("config.settings")

-- Color Scheme
vim.cmd 'colorscheme material'
vim.g.material_theme_style = "dark"
