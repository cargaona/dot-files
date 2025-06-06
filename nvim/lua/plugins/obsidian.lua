return {
  "epwalsh/obsidian.nvim",
  version = "*", -- recommended, use latest release instead of latest commit
  lazy = true,
  -- ft = "markdown",
  -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
  event = {
    -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
    -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
    -- refer to `:h file-pattern` for more examples
    "BufReadPre " .. vim.fn.expand "~" .. "/docs/obsidian/*.md",
    "BufNewFile  " .. vim.fn.expand "~" .. "/docs/obsidian/*.md",
  },
  dependencies = {
    -- Required.
    "nvim-lua/plenary.nvim",
    -- autocompletion
    "hrsh7th/nvim-cmp",
    -- picker
    "nvim-telescope/telescope.nvim",
  },
  keys = {
    {
      "<leader>fn",
      "<cmd>ObsidianQuickSwitch<CR>",
      desc = "Find notes"
    },
    {
      "<leader>fgn",
      "<cmd>ObsidianSearch<CR>",
      desc = "Find notes"
    },
    {
      "<leader>nn",
      "<cmd>ObsidianNew<CR>",
      desc = "New note",
    },
    {
      "<leader>nt",
      "<cmd>ObsidianNewFromTemplate<CR>",
      desc = "New note from template",
    },
  },
  opts = {
    workspaces = {
      {
        name = "notes",
        path = vim.fn.expand("~") .. "/docs/obsidian",
      },
    },
    ui = {
      enable = true,
    }
  },
}
