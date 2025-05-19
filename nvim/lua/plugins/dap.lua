return {
  {
    "nvim-neotest/nvim-nio",
    event = "VeryLazy",
  },
  {
    "rcarriga/nvim-dap-ui",
    event = "VeryLazy",
    dependencies = "mfussenegger/nvim-dap",
    config = function()
      local dap = require "dap"
      local dapui = require "dapui"
      dapui.setup()
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      -- this closes the DAP ui once it's done executing. commented out
      --   dap.listeners.before.event_terminated["dapui_config"] = function()
      --     dapui.close()
      --   end
      --   dap.listeners.before.event_exited["dapui_config"] = function()
      --     dapui.close()
      --   end
    end,
  },
  -- nvim-dap-ui requires nvim-nio to be installed. Install from https://github.com/nvim-neotest/nvim-nio
  {
    "leoluz/nvim-dap-go",
    event = "VeryLazy",
    ft = "go",
    dependencies = "mfussenegger/nvim-dap",
    config = function(_, opts)
      require("dap-go").setup(opts)
      -- require("core.utils").load_mappings "dap_go"
    end,
  },
  {
    "mfussenegger/nvim-dap",
    event = "VeryLazy",
    config = function(_, opts)
      local set = vim.keymap.set
      set("n", "<F7>", "<cmd> DapStepInto <CR>", { desc = "Step Into (DAP)" })
      set("n", "<F8>", "<cmd> DapStepOver <CR>", { desc = "Step Over (DAP)" })
      set("n", "<F9>", "<cmd> DapStepOut <CR>", { desc = "Step Out (DAP)" })
      set("n", "<leader>db", "<cmd> DapToggleBreakpoint <CR>", { desc = "Toggle Breakpoint (DAP)" })
      set("n", "<leader>dr", "<cmd> DapContinue <CR>", { desc = "Continue (DAP)" })
      set("n", "<leader>dt", "<cmd> DapTerminate <CR>", { desc = "Terminate (DAP)" })
      set("n", "<leader>duc", function()
        require("dapui").close()
      end
      , { desc = "Close UI (DAP)" }
      )
      set("n", "<leader>dus", function()
        local widgets = require "dap.ui.widgets"
        local sidebar = widgets.sidebar(widgets.scopes)
        sidebar.open()
      end
      , { desc = "Open debugging sidebar (DAP)" }
      )
    end,
  },
}
