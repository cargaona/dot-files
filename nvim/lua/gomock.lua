--local go = {}
local vfn = vim.fn

_GO_NVIM_CFG = {
  disable_defaults = false, -- either true when true disable all default settings
  log_path = vfn.expand('$HOME') .. '/tmp/gonvim.log',

  null_ls_document_formatting_disable = false, -- true: disable null-ls formatting
  -- if enable gopls to format the code and you also installed and enabled null-ls, you may
  -- want to disable null-ls by setting this to true
  -- it can be a nulls source name e.g. `golines` or a nulls query table
  --lsp_keymaps = true, -- true: use default keymaps defined in go/lsp.lua
  --lsp_codelens = true,
  diagnostic = {      -- set diagnostic to false to disable diagnostic
    hdlr = false,     -- hook diagnostic handler and send error to quickfix
    underline = true,
    -- virtual text setup
    virtual_text = { spacing = 0, prefix = '■' },
    update_in_insert = false,
    signs = true,
  },
  -- deprecated setups
  -- lsp_diag_hdlr = true, -- hook lsp diag handler
  -- lsp_diag_underline = true,
  -- -- virtual text setup
  -- lsp_diag_virtual_text = { spacing = 0, prefix = '■' },
  -- lsp_diag_signs = true,
  --lsp_inlay_hints = {
    --enable = true,
    --style = 'inlay', -- 'default: inlay', 'eol': show at end of line, 'inlay': show in the middle of the line

    ---- Note: following setup only for for style == 'eol'
    ---- Only show inlay hints for the current line
    --only_current_line = false,

    ---- Event which triggers a refresh of the inlay hints.
    ---- You can make this "CursorMoved" or "CursorMoved,CursorMovedI" but
    ---- not that this may cause higher CPU usage.
    ---- This option is only respected when only_current_line and
    ---- autoSetHints both are true.
    --only_current_line_autocmd = 'CursorHold',

    ---- whether to show variable name before type hints with the inlay hints or not
    ---- default: false
    --show_variable_name = true,

    ---- prefix for parameter hints
    --parameter_hints_prefix = '󰊕 ',
    --show_parameter_hints = true,

    ---- prefix for all the other hints (type, chaining)
    ---- default: "=>"
    --other_hints_prefix = '=> ',

    ---- whether to align to the length of the longest line in the file
    --max_len_align = false,

    ---- padding from the left if max_len_align is true
    --max_len_align_padding = 1,

    ---- whether to align to the extreme right or not
    --right_align = false,

    ---- padding from the right if right_align is true
    --right_align_padding = 6,

    ---- The color of the hints
    --highlight = 'Comment',
  --},
  --lsp_diag_update_in_insert = false,
  --lsp_fmt_async = false, -- async lsp.buf.format
  --go_boilplater_url = 'https://github.com/thockin/go-build-template.git',
  --gopls_cmd = nil, --- you can provide gopls path and cmd if it not in PATH, e.g. cmd = {  "/home/ray/.local/nvim/data/lspinstall/go/gopls" }
  --gopls_remote_auto = true,
  --gocoverage_sign = '█',
  --gocoverage_skip_covered = false,
  --sign_covered_hl = 'String', --- highlight group for test covered sign
  --sign_partial_hl = 'WarningMsg', --- highlight group for test partially covered sign
  --sign_uncovered_hl = 'Error', -- highlight group for uncovered code
  --launch_json = nil, -- the launch.json file path, default to .vscode/launch.json
  -- launch_json = vfn.getcwd() .. "/.vscode/launch.json",
  --dap_debug = true,
  --dap_debug_gui = {}, -- bool|table put your dap-ui setup here set to false to disable
  --dap_debug_keymap = true, -- true: use keymap for debugger defined in go/dap.lua
  -- false: do not use keymap in go/dap.lua.  you must define your own.
  --dap_debug_vt = { enabled_commands = true, all_frames = true }, -- bool|table put your dap-virtual-text setup here set to false to disable
  --dap_port = 38697, -- can be set to a number or -1 so go.nvim will pickup a random port
  --dap_timeout = 15, --  see dap option initialize_timeout_sec = 15,
  --dap_retries = 20, -- see dap option max_retries
  --build_tags = '',         --- you can provide extra build tags for tests or debugger
  --textobjects = true,      -- treesitter binding for text objects
  --test_runner = 'go',      -- one of {`go`, `richgo`, `dlv`, `ginkgo`, `gotestsum`}
  --verbose_tests = false,   -- set to add verbose flag to tests deprecated see '-v'
  --run_in_floaterm = false, -- set to true to run in float window.
  --floaterm = {
    --posititon = 'auto',    -- one of {`top`, `bottom`, `left`, `right`, `center`, `auto`}
    --width = 0.45,          -- width of float window if not auto
    --height = 0.98,         -- height of float window if not auto
    --title_colors = 'nord', -- table of colors for title, or a color scheme name
  --},
  --trouble = false,         -- true: use trouble to open quickfix
  --test_efm = false,        -- errorfomat for quickfix, default mix mode, set to true will be efm only

  --luasnip = false,         -- enable included luasnip
  --username = '',
  --useremail = '',
  --disable_per_project_cfg = false, -- set to true to disable load script from .gonvim/init.lua
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
    return { '-p', '-d', '-i', '-s' }
  end,
})
