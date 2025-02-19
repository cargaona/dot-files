-- LSP Commands
vim.api.nvim_create_user_command("Def", function() vim.lsp.buf.definition() end, {}) -- Go to definition
vim.api.nvim_create_user_command("Fmt", function() vim.lsp.buf.format() end, {}) -- Format code
vim.api.nvim_create_user_command("Imp", function() vim.lsp.buf.implementation() end, {}) -- Go to implementation
vim.api.nvim_create_user_command("Ref", function() vim.lsp.buf.references() end, {}) -- Show references
vim.api.nvim_create_user_command("Info", function() vim.lsp.buf.hover() end, {}) -- Show hover info
vim.api.nvim_create_user_command("Diagnose", function() vim.diagnostic.open_float() end, {}) -- Show diagnostics in floating window
vim.api.nvim_create_user_command("CodeAction", function() vim.lsp.buf.code_action() end, {}) -- Show available code actions
vim.api.nvim_create_user_command("Rename", function() vim.lsp.buf.rename() end, {}) -- Rename symbol
vim.api.nvim_create_user_command("LspLog", function() vim.cmd('sp '..vim.lsp.get_log_path()) end, {}) -- Open LSP log
vim.api.nvim_create_user_command("Err", function() vim.diagnostic.setqflist() end, {}) -- Send diagnostics to quickfix list
vim.api.nvim_create_user_command("ReloadNvim", function() vim.cmd("so $CODE_PATH/dot-files/nvim/init.lua") end, {}) -- Reload Neovim config

-- Disable Go default mappings
vim.g.go_def_mapping_enabled = 0

-- Auto commands
vim.api.nvim_create_augroup("quickfix", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  group = "quickfix",
  pattern = "qf",
  command = "setlocal wrap",
})

vim.api.nvim_create_augroup("go", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  group = "go",
  pattern = "go",
  callback = function()
    -- Go alternate commands for switching between source and test files
    vim.api.nvim_create_user_command("A", "call go#alternate#Switch(0, 'edit')", {})
    vim.api.nvim_create_user_command("AV", "call go#alternate#Switch(0, 'vsplit')", {})
    vim.api.nvim_create_user_command("AS", "call go#alternate#Switch(0, 'split')", {})
    vim.api.nvim_create_user_command("AT", "call go#alternate#Switch(0, 'tabe')", {})
    -- Debugging keymaps
    vim.api.nvim_set_keymap("n", "bb", ":GoDebugBreakpoint<CR>", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("n", "<leader>stop", ":GoDebugStop<CR>", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("n", "<leader>deb", ":GoDebugStart<CR>", { noremap = true, silent = true })
    -- Code testing and coverage
    vim.api.nvim_set_keymap("n", "cov", ":GoCoverageToggle<CR>", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("n", "tt", ":GoTestFunc<CR>", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("n", "df", ":GoDebugTestFunc<CR>", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("n", "gt", ":GoDefType<CR>", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("n", "ff", ":GoFillStruct<CR>", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("n", "err", ":GoIfErr<CR>", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("n", "imp", ":GoImplements<CR>", { noremap = true, silent = true })
  end,
})

-- Command to sort lines by length
vim.api.nvim_create_user_command("SortLen", "'<,'>!awk '{ print length(), $0 | \"sort -n | cut -d\\  -f2-\" }'", { range = true }) -- Sort lines by length

-- Command to make background transparent
vim.api.nvim_create_user_command("Trans", function()
  vim.cmd("highlight NonText guibg=NONE")
  vim.cmd("highlight Normal guibg=NONE")
end, {}) -- Make background transparent

