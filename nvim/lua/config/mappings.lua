-- Shift + Arrow keys for visual selection movement
vim.api.nvim_set_keymap('i', '<S-Right>', '<Esc>V<Right>', { noremap = true })
vim.api.nvim_set_keymap('i', '<S-Left>', '<Esc>V<Left>', { noremap = true })
vim.api.nvim_set_keymap('i', '<S-Down>', '<Esc>V<Down>', { noremap = true })
vim.api.nvim_set_keymap('n', '<S-Right>', 'v<Right>', { noremap = true })
vim.api.nvim_set_keymap('v', '<S-Right>', '<Right>', { noremap = true })
vim.api.nvim_set_keymap('n', '<S-Down>', 'V<Down>', { noremap = true })
vim.api.nvim_set_keymap('n', '<S-Left>', 'v<Left>', { noremap = true })
vim.api.nvim_set_keymap('v', '<S-Down>', '<Down>', { noremap = true })
vim.api.nvim_set_keymap('v', '<S-Left>', '<Left>', { noremap = true })
vim.api.nvim_set_keymap('n', '<S-Up>', 'V<Up>', { noremap = true })
vim.api.nvim_set_keymap('v', '<S-Up>', '<Up>', { noremap = true })

-- Ctrl + Shift + Arrow keys for visual selection
vim.api.nvim_set_keymap('n', '<C-S-Right>', '<Esc>v', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-S-Left>', '<Esc>v', { noremap = true })

-- Toggle NvimTree
vim.api.nvim_set_keymap('n', '<C-t>', ':NvimTreeToggle<CR>', { noremap = true, silent = true })

-- Quick access to Neovim config directory
vim.api.nvim_set_keymap('n', '<leader>ee', ':e $CODE_PATH/dot-files/nvim/<CR>', { noremap = true, silent = true })

-- Show LSP diagnostics for current line
vim.api.nvim_set_keymap('n', '<leader>wd', 'vim.lsp.diagnostic.show_line_diagnostics()', { noremap = true, silent = true })

-- LSP related mappings
vim.api.nvim_set_keymap('n', 'ren', ':Rename<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', 'ca', ':Ref<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', 'imp', ':Imp<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', 'gi', ':Info<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', 'gd', ':Def<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', 'fmt', ':Fmt<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', 'co', ':CodeAction<CR>', { noremap = true })

-- Reload Neovim configuration
vim.api.nvim_set_keymap('n', '<leader>r', ':ReloadNvim<CR>', { noremap = true, silent = true })

-- Copy/Paste/Cut settings
vim.opt.clipboard = 'unnamed,unnamedplus'
if vim.fn.has('macunix') == 1 then
  vim.api.nvim_set_keymap('v', '<C-x>', ':!pbcopy<CR>', { noremap = true })
  vim.api.nvim_set_keymap('v', '<C-c>', ':w !pbcopy<CR><CR>', { noremap = true })
end

-- Move through words with Ctrl + Arrow keys
vim.api.nvim_set_keymap('n', '<C-Right>', 'e<Right>', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-Left>', 'b', { noremap = true })

-- Commenting (NERDCommenter)
vim.api.nvim_set_keymap('n', '<C-]>', '<Plug>NERDCommenterToggle<Down>', {})
vim.api.nvim_set_keymap('v', '<C-]>', '<Plug>NERDCommenterToggle<CR>gv', {})

-- Move and duplicate lines
vim.api.nvim_set_keymap('v', '<C-d>', '<Plug>SchleppDup', {})
vim.api.nvim_set_keymap('v', '<C-Up>', '<Plug>SchleppIndentUp', {})
vim.api.nvim_set_keymap('v', '<C-Down>', '<Plug>SchleppIndentDown', {})

-- Git commands
vim.api.nvim_set_keymap('n', '<Leader>ga', ':Gwrite<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>gbl', ':Git blame<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>gca', ':Git commit --amend<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>gcm', ':Git commit<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>gd', ':Gvdiff<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>gf', ':Git fetch<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>gl', ':Git pull<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>gp', ':Git push<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>gr', ':Gremove<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>gs', ':Git<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>log', ':Git log<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>co', '<cmd>Telescope git_branches<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>sh', '<cmd>Telescope git_commits<CR>', { noremap = true, silent = true })

-- Telescope mappings
vim.api.nvim_set_keymap('n', '<Leader>b', '<cmd>Telescope buffers<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>t', '<cmd>Telescope<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>h', '<cmd>Telescope help_tags<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>gg', '<cmd>Telescope live_grep<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>f', '<cmd>Telescope find_files find_command=rg,--ignore,--hidden,--files<CR>', { noremap = true, silent = true })

-- Undo/Redo shortcuts
vim.api.nvim_set_keymap('n', '<C-r>', ':redo<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-z>', 'u', { noremap = true })

-- Remove search highlights
vim.api.nvim_set_keymap('n', '<leader><space>', ':noh<CR>', { noremap = true, silent = true })

-- Buffer navigation
vim.api.nvim_set_keymap('n', '<A-Tab>', ':bn<CR>', { noremap = true, silent = true })

-- Buffer Navigation
vim.api.nvim_set_keymap('n', '<C-n>', ':bnext<CR>', { noremap = true })
-- TODO: make :bp mapping work
vim.api.nvim_set_keymap('n', '<A-S-Tab>', ':bprevious<CR>', { noremap = true })

-- Close buffer
vim.api.nvim_set_keymap('n', '<C-q>', ':bw<CR>', { noremap = true })

-- Split windows
vim.api.nvim_set_keymap('n', '<Leader>h', ':<C-u>split<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>v', ':<C-u>vsplit<CR>', { noremap = true })

-- Window navigation
vim.api.nvim_set_keymap('n', '<C-h>', '<C-w>h', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-k>', '<C-w>k', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-l>', '<C-w>l', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-j>', '<C-w>j', { noremap = true, silent = true })

-- End of line navigation
vim.api.nvim_set_keymap('n', '<End>', '<End><Right>', { noremap = true })
vim.api.nvim_set_keymap('n', '$', '$<Right>', { noremap = true })

-- EasyMotion configuration
vim.g.EasyMotion_do_mapping = 0 -- Disable default mappings
vim.api.nvim_set_keymap('n', '<leader>em', '<Plug>(easymotion-overwin-f2)', {})

-- Escape from insert mode with "jk"
vim.api.nvim_set_keymap('i', 'jk', '<ESC>', { noremap = true })

-- Quit and write mappings
vim.api.nvim_set_keymap('n', 'jq', ':q!<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', 'jwq', ':wq!<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', 'jw', ':w!<CR>', { noremap = true })

-- Command abbreviations
vim.api.nvim_exec([[
  cnoreabbrev W! w!
  cnoreabbrev Q! q!
  cnoreabbrev Qall! qall!
  cnoreabbrev Wq wq
  cnoreabbrev Wa wa
  cnoreabbrev wQ wq
  cnoreabbrev WQ wq
  cnoreabbrev W w
  cnoreabbrev Q q
  cnoreabbrev Qall qall
]], false)

local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- Map Ctrl+S to save the current file
map("n", "<C-S>", ":update<CR>", opts)
map("v", "<C-S>", "<C-C>:update<CR>", opts)
map("i", "<C-S>", "<C-O>:update<CR>", opts)

-- Tmux integration (handles xterm-style key sequences inside tmux)
--if vim.fn.match(vim.o.term, '^tmux') ~= -1 then
  --vim.cmd([[
    --set <xRight>=\e[1;*C
    --set <xDown>=\e[1;*B
    --set <xLeft>=\e[1;*D
    --set <xUp>=\e[1;*A
  --]])
--end

