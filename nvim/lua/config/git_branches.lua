local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local conf = require("telescope.config").values
local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"

local M = {}

-- Get list of git branches
local function get_branches()
  local handle = io.popen "git branch -a"
  local result = handle:read "*a"
  handle:close()

  local branches = {}
  for line in result:gmatch "[^\n]+" do
    -- Remove leading * and spaces
    local branch = line:gsub("^%*?%s+", "")
    -- Remove 'remotes/' prefix if present
    branch = branch:gsub("^remotes/", "")
    table.insert(branches, branch)
  end

  return branches
end

-- Create new branch
local function create_branch()
  local ok, branch_name = vim.ui.input(
    { prompt = "New branch name: " },
    function(input)
      return input
    end
  )

  -- If input was cancelled, branch_name will be nil
  if not branch_name or branch_name == "" then
    return
  end

  -- Create the branch
  local cmd = "git checkout -b " .. branch_name
  local handle = io.popen(cmd .. " 2>&1")
  local result = handle:read "*a"
  handle:close()

  if result:find "error" or result:find "fatal" then
    vim.notify("Error creating branch: " .. result, vim.log.levels.ERROR)
  else
    vim.notify("Branch created: " .. branch_name, vim.log.levels.INFO)
  end
end

-- Git branch picker
M.git_branches = function(opts)
  opts = opts or {}

  local branches = get_branches()

  pickers.new(opts, {
    prompt_title = "Git Branches",
    finder = finders.new_table {
      results = branches,
    },
    previewer = conf.file_previewer(opts),
    sorter = conf.generic_sorter(opts),
    attach_mappings = function(prompt_bufnr, map)
      -- Checkout branch
      actions.select_default:replace(function()
        actions.close(prompt_bufnr)
        local selection = action_state.get_selected_entry()
        local branch = selection.value

        -- Handle remote branches
        if branch:find "origin/" then
          branch = branch:gsub("origin/", "")
          vim.cmd("!git checkout --track origin/" .. branch)
        else
          vim.cmd("!git checkout " .. branch)
        end

        vim.notify("Switched to branch: " .. branch, vim.log.levels.INFO)
      end)

      -- Create new branch with Ctrl+N
      map("i", "<C-n>", function()
        actions.close(prompt_bufnr)
        create_branch()
      end)

      map("n", "<C-n>", function()
        actions.close(prompt_bufnr)
        create_branch()
      end)

      return true
    end,
  }):find()
end

return M
