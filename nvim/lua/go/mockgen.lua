-- local ts_utils = require 'nvim-treesitter.ts_utils'
local utils = require("go.utils")
local log = utils.log
local vfn = vim.fn
local mockgen = "mockgen" -- GoMock f *Foo io.Writer

-- this is being used by GoMockGen, and was imported from go.nvim. 
-- TODO clean this code and use only what is needed
_GO_NVIM_CFG = {
  disable_defaults = false, -- either true when true disable all default settings
  log_path = vfn.expand('$HOME') .. '/tmp/gonvim.log',
  --null_ls_document_formatting_disable = false, -- true: disable null-ls formatting
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
  end, -- callback for jobexit, output : string
  --iferr_vertical_shift = 4, -- defines where the cursor will end up vertically from the begining of if err statement after GoIfErr command
}

-- use ts to get name
local function get_interface_name()
  local name = require("go.ts.go").get_interface_node_at_pos()
  if name == nil then
    return nil
  end
  utils.log(name)
  if name == nil then
    return ""
  end
  local node_name = name.name
  -- let move the cursor to end of line of struct name
  local dim = name.dim.e
  -- let move cursor
  local r, c = dim.r, dim.c
  utils.log("move cusror to ", r, c)
  vim.api.nvim_win_set_cursor(0, { r, c })
  return node_name
end

local run = function(opts)
  require("go.install").install(mockgen)

  local long_opts = {
    package = "p",
    source = "s",
    destination = "d",
    interface = "i",
  }

  local getopt = require("go.alt_getopt")
  local short_opts = "p:d:i:s"
  local args = opts.fargs or {}
  log(args)

  local optarg, _, reminder = getopt.get_opts(args, short_opts, long_opts)
  local mockgen_cmd = { mockgen }
  utils.log(arg, reminder)

  local sep = require("go.utils").sep()

  local ifname = get_interface_name()
  log(ifname)

  if optarg["i"] ~= nil and #optarg["i"] > 0 then
    ifname = optarg["i"]
  end

  if optarg["s"] ~= nil then
    ifname = ""
  end
  local fpath = utils.rel_path(true) -- rel/path/only
  log(fpath, mockgen_cmd)
  local sname = vfn.expand("%:t") -- name.go only

  if fpath ~= "" then
    fpath = fpath .. sep
  end

  if ifname == "" or ifname == nil then
    -- source mode default
    table.insert(mockgen_cmd, "-source")
    table.insert(mockgen_cmd, fpath .. sname)
  else
    log("interface ", ifname)
    -- need to get the import path
    local bufnr = vim.api.nvim_get_current_buf()

    local pkg = require("go.package").pkg_from_path(nil, bufnr)
    if pkg ~= nil and type(pkg) == "table" and pkg[1] then
      table.insert(mockgen_cmd, pkg[1])
    else
      utils.notify("no package found, using .")
      table.insert(mockgen_cmd, '.')
    end
    table.insert(mockgen_cmd, ifname)
  end

  local pkgname = optarg["p"] or "mocks"
  table.insert(mockgen_cmd, "-package")
  table.insert(mockgen_cmd, pkgname)

  local dname = fpath .. pkgname .. sep .. "mock_" .. sname
  table.insert(mockgen_cmd, "-destination")
  table.insert(mockgen_cmd, dname)

  log(mockgen_cmd)

  utils.log(mockgen_cmd)
  -- vim.cmd("normal! $%") -- do a bracket match. changed to treesitter
  local mock_opts = {
    on_exit = function(code, signal, data)
      if code ~= 0 or signal ~= 0 then
        -- there will be error popup from runner
        -- utils.warn("mockgen failed" .. vim.inspect(data))
        return
      end
      data = vim.split(data, "\n")
      data = utils.handle_job_data(data)
      if not data then
        return
      end
      --
      vim.schedule(function()
        utils.info(vfn.join(mockgen_cmd, " ") .. " finished " .. vfn.join(data, " "))
      end)
    end,
  }
  local runner = require("go.runner")
  runner.run(mockgen_cmd, mock_opts)
  vim.print(mockgen_cmd)
  vim.print(mock_opts)
  return mockgen_cmd
end

return { run = run }
