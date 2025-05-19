vim.keymap.set({ "n" }, "<leader>cc", ":CopilotChatToggle<CR>", { desc = "Toggle Copilot Chat" })
return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    lazy = false,
    event = "InsertEnter",
    config = function()
      require('copilot').setup({
        panel = {
          enabled = true,
          auto_refresh = false,
          keymap = {
            jump_prev = "[[",
            jump_next = "]]",
            accept = "<CR>",
            refresh = "gr",
            open = "<M-CR>"
          },
          layout = {
            position = "bottom", -- | top | left | right | horizontal | vertical
            ratio = 0.4
          },
        },
        suggestion = {
          enabled = true,
          auto_trigger = true,
          hide_during_completion = true,
          debounce = 75,
          keymap = {
            accept = "<C-Space>",
            accept_word = false,
            accept_line = false,
            next = "<M-]>",
            prev = "<M-[>",
            dismiss = "<C-M-]>",
          },
        },
        filetypes = {
          yaml = false,
          markdown = false,
          help = false,
          gitcommit = false,
          gitrebase = false,
          hgcommit = false,
          svn = false,
          cvs = false,
          ["."] = false,
        },
        copilot_node_command = 'node', -- Node.js version must be > 18.x
        server_opts_overrides = {},
      })
      vim.keymap.set("n", "<leader>ct", "<cmd>Copilot toggle<CR>", { desc = "Toggle Copilot" })
    end,

  },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "main",
    dependencies = {
      { "zbirenbaum/copilot.lua" }, -- or github/copilot.vim
      { "nvim-lua/plenary.nvim" },  -- for curl, log wrapper
    },
    build = "make tiktoken",        -- Only on MacOS or Linux
    opts = {
      debug = false,                -- Enable debugging
      show_help = false,
      -- system_prompt = prompts.COPILOT_INSTRUCTIONS, -- System prompt to use
      model = 'gpt-4o',  -- GPT model to use, 'gpt-3.5-turbo', 'gpt-4', or 'gpt-4o'
      temperature = 0.1, -- GPT temperature
      mappings = {
        reset = {
          normal = '',
          insert = '<C-l>',
        },
      }
    }
    -- See Commands section for default commands if you want to lazy load on them
  },
}
