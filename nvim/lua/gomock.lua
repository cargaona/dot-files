--local go = {}
local vfn = vim.fn

_GO_NVIM_CFG = {
  disable_defaults = false, -- either true when true disable all default settings
  log_path = vfn.expand('$HOME') .. '/tmp/gonvim.log',

  null_ls_document_formatting_disable = false, -- true: disable null-ls formatting
  --diagnostic = {      -- set diagnostic to false to disable diagnostic
    --hdlr = false,     -- hook diagnostic handler and send error to quickfix
    --underline = true,
    ---- virtual text setup
    --virtual_text = { spacing = 0, prefix = '■' },
    --update_in_insert = false,
    --signs = true,
  --},
  on_jobstart = function(cmd)
    _ = cmd
  end, -- callback for stdout
  on_stdout = function(err, data)
    _, _ = err, data
  end, -- callback when job started
  on_stderr = function(err, data)
    _, _ = err, data
  end, -- callback for stderr
  on_exit = function(code, signal, output)
    _, _, _ = code, signal, output
  end,                      -- callback for jobexit, output : string
  --iferr_vertical_shift = 4, -- defines where the cursor will end up vertically from the begining of if err statement after GoIfErr command
}

local create_cmd = function(cmd, func, opt)
  opt = vim.tbl_extend('force', { desc = 'go.nvim ' .. cmd }, opt or {})
  vim.api.nvim_create_user_command(cmd, func, opt)
end

create_cmd('GoMockGen', require('go.mockgen').run, {
  nargs = '*',
  bang = true,
  complete = function(_, _, _)
    -- return completion candidates as a list-like table
    return { '-package', '-destination', '-i', '-source' }
  end,
})
