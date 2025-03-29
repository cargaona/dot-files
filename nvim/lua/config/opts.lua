-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Tabs vs spaces
vim.o.tabstop = 2 -- A TAB character looks like 4 spaces
vim.o.expandtab = true -- Pressing the TAB key will insert spaces instead of a TAB character
vim.o.softtabstop = 2 -- Number of spaces inserted instead of a TAB character
vim.o.shiftwidth = 2 -- Number of spaces inserted when indenting


vim.opt.clipboard = "unnamedplus"
vim.opt.cursorline = true

-- line numbers
vim.opt.number = true
-- vim.opt.relativenumber = true
vim.opt.numberwidth = 4
vim.opt.ruler = true

-- beam-shaped cursor when in cmd mode otherwise is a block that is way too
-- thick for kitty's cursor trail

vim.opt.guicursor="n-v-sm:block,i-ci-c-ve:ver25,r-cr-o:hor200"

-- scrolloff
vim.opt.scrolloff = 10
vim.opt.sidescrolloff = 20

-- linewrap
vim.opt.wrap = false

vim.opt.colorcolumn = "80"

-- conceal level (only relevant to me bc of markview)
vim.opt.conceallevel = 1

-- Enable mouse mode
vim.o.mouse = "a"

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.o.clipboard = "unnamedplus"

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = "yes"

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = "menuone,noselect"

-- Set terminal gui colors to true
vim.o.termguicolors = true

vim.o.grepprg = 'rg --vimgrep --smart-case'

vim.cmd('packadd! cfilter')
