local set = vim.keymap.set

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

set('i', '<C-H>', "<Nop>", {})
set('i', '<C-J>', "<Nop>", {})
set('i', '<C-K>', "<Nop>", {})
set('i', '<C-L>', "<Nop>", {})

set('n', '<Esc>', "<cmd> noh <CR>", { desc = "Clear highlights" })
set('n', '<C-c>', "<cmd> %y+ <CR>", { desc = "Copy whole file" })
-- set('n', '<leader>tn', "<cmd> set nu! <CR>", { desc = "Toggle line number" }) under what circumstances would you ever wanna disable this?
set('n', '<leader>trn', "<cmd> set rnu! <CR>", { desc = "Toggle relative line number" })

-- buffers
set("n", "<right>", "<cmd> bnext <CR>", { desc = "Next buffer" })
set("n", "<left>", "<cmd> bprevious <CR>", { desc = "Previous buffer" })
set("n", "<leader>bd", "<cmd> bd <CR>", { desc = "Close buffer" })
set("n", "<leader>bD", "<cmd> bd! <CR>", { desc = "Close buffer with unsaved changes" })

-- tabs
set("n", "<S-right>", "<cmd> tabnext <CR>", { desc = "Next tab" })
set("n", "<S-left>", "<cmd> tabprevious <CR>", { desc = "Previous tab" })
set("n", "<leader>tn", "<cmd> tabnew <CR>", { desc = "New tab" })
set("n", "<leader>td", "<cmd> tabclose <CR>", { desc = "Close tab" })

-- QF navigation
set('n', '<leader>,', "<cmd> cprev <CR>", { desc = "Previous QF list element" })
set('n', '<leader>.', "<cmd> cnext <CR>", { desc = "Next QF list element" })

-- resizing splits
set("n", "<M-,>", "<c-w>5<")
set("n", "<M-.>", "<c-w>5>")
set("n", "<M-u>", "<c-w>-")
set("n", "<M-d>", "<c-w>+")

-- jumping forward (opposite of C-o)
set('n', '<Tab>', '<C-i>')

-- https://www.reddit.com/r/neovim/comments/vlc9sc/how_to_define_a_user_command_to_partially_stage
local function gitsigns_visual_op(op)
  return function()
    return require('gitsigns')[op]({ vim.fn.line("."), vim.fn.line("v") })
  end
end

set('v', '<leader>ghs', gitsigns_visual_op"stage_hunk", { desc = "Stage visual selection" })

-- bind to delete element from QF list with x
vim.api.nvim_exec([[
  function! s:QfRemoveAtCursor() abort
    let currline = line('.')
    let items = getqflist()->filter({ index -> (index + 1) != currline })
    call setqflist(items, 'r')
    execute 'normal ' . currline . 'G'
  endfunction

  augroup quickfix
    autocmd!
    autocmd FileType qf nnoremap <buffer><silent> x :call <SID>QfRemoveAtCursor()<CR>
  augroup END
]], false)
