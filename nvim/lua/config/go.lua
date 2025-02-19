vim.api.nvim_set_keymap('n', '<leader>gb', ':lua build_go_files()<CR>', { noremap = true, silent = true })

local function build_go_files()
  local file = vim.fn.expand('%')
  if file:match('^.+_test%.go$') then
    vim.fn['go#test#Test'](0, 1)
  elseif file:match('^.+%.go$') then
    vim.fn['go#cmd#Build'](0)
  end
end

local create_cmd = function(cmd, func, opt)
  opt = vim.tbl_extend('force', { desc = 'command ' .. cmd }, opt or {})
  vim.api.nvim_create_user_command(cmd, func, opt)
end

-- GoMockGen config
create_cmd('GoMockGen', require('go.mockgen').run, {
  nargs = '*',
  bang = true,
  complete = function(_, _, _)
    -- return completion candidates as a list-like table
    return { '-package', '-destination', '-i', '-source' }
  end,
})

--return {
--"fatih/vim-go",
--config = function()
---- Auto build or test based on file type
--vim.api.nvim_create_autocmd("BufWritePost", {
--pattern = "*.go",
--callback = function()
--local file = vim.fn.expand("%")
--if file:match("_test%.go$") then
--vim.cmd("GoTestCompile")
--else
--vim.cmd("GoBuild")
--end
--end,
--})

-- General settings
vim.g.go_debug = { "shell-commands", "debugger-commands" }
vim.g.go_gopls_enabled = 1
vim.g.go_def_mode = "gopls"
vim.g.go_auto_type_info = 1
vim.g.go_info_mode = "gopls"
vim.g.go_list_type = "quickfix"
vim.g.go_referrers_mode = "gopls"
vim.g.go_gopls_options = { "-remote=auto" }
vim.g.go_debug_log_output = "debugger"

-- Formatting
vim.g.go_fmt_command = "goimports"
vim.g.go_fmt_fail_silently = 1
vim.g.go_fmt_autosave = 1

-- Syntax highlighting
vim.g.go_highlight_types = 1
vim.g.go_highlight_fields = 1
vim.g.go_highlight_methods = 1
vim.g.go_highlight_structs = 1
vim.g.go_highlight_functions = 1
vim.g.go_highlight_operators = 1
vim.g.go_highlight_extra_types = 1
vim.g.go_highlight_generate_tags = 1
vim.g.go_highlight_format_strings = 1
vim.g.go_highlight_function_calls = 1
vim.g.go_highlight_space_tab_error = 1
vim.g.go_highlight_build_constraints = 1
vim.g.go_highlight_function_parameters = 1
vim.g.go_highlight_array_whitespace_error = 1
vim.g.go_highlight_trailing_whitespace_error = 0
vim.g.go_debug_mappings = {
    ['(go-debug-continue)']   = { key = 'c' },
    ['(go-debug-print)']      = { key = 'p' },
    ['(go-debug-breakpoint)'] = { key = 'b' },
    ['(go-debug-next)']       = { key = 'n' },
    ['(go-debug-step)']       = { key = 's' },
    ['(go-debug-stop)']       = { key = 'e' },
}

--return {
--  "fatih/vim-go",
--  config = function()
--
---- Neovim configuration for Go development using vim-go
----vim.g.go_debug = { 'shell-commands', 'debugger-commands' }
--vim.g.go_gopls_enabled = 1
--vim.g.go_def_mode = 'gopls'
--vim.g.go_auto_type_info = 1
--vim.g.go_info_mode = 'gopls'
--vim.g.go_list_type = "quickfix"
--vim.g.go_referrers_mode = 'gopls'
--vim.g.go_gopls_options = { '-remote=auto' }
----vim.g.go_debug_log_output = 'debugger'
--vim.g.go_debug_log_output = ''
--
--vim.g.go_fmt_command = "goimports"
--vim.g.go_fmt_fail_silently = 1
--vim.g.go_fmt_autosave = 1
--
--vim.g.go_highlight_types = 1
--vim.g.go_highlight_fields = 1
--vim.g.go_highlight_methods = 1
--vim.g.go_highlight_structs = 1
--vim.g.go_highlight_functions = 1
--vim.g.go_highlight_operators = 1
--vim.g.go_highlight_extra_types = 1
--vim.g.go_highlight_generate_tags = 1
--vim.g.go_highlight_format_strings = 1
--vim.g.go_highlight_function_calls = 1
--vim.g.go_highlight_space_tab_error = 1
--vim.g.go_highlight_build_constraints = 1
--vim.g.go_highlight_function_parameters = 1
--vim.g.go_highlight_array_whitespace_error = 1
--vim.g.go_highlight_trailing_whitespace_error = 0
--
--
--
