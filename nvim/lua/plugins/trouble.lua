return {
  {
    "folke/trouble.nvim",
    lazy = true,
    event = "VeryLazy",
    opts = {}, -- for default options, refer to the configuration section for custom setup.
    cmd = "Trouble",
    keys = {
      {
        "<leader>vx",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics (Trouble)",
      },
      {
        "<leader>vX",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Buffer Diagnostics (Trouble)",
      },
      {
        "<leader>cs",
        "<cmd>Trouble symbols toggle focus=false<cr>",
        desc = "Symbols (Trouble)",
      },

      {
        "<leader>cl",
        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        desc = "LSP Sidebar",
      },
      {
        "<leader>vva",
        "<cmd>Trouble lsp toggle<cr>",
        desc = "LSP Definitions / references / ... (Trouble)",
      },
       
      {
        "<leader>vj",
        "<cmd>Trouble toggle lsp_incoming_calls<cr>",
        desc = "LSP Incoming Calls",
      },
      {
        "<leader>vo",
        "<cmd>Trouble toggle lsp_outgoing_calls<cr>",
        desc = "LSP Outgoing Calls",
      },
      {
        "<leader>vi",
        "<cmd>Trouble toggle lsp_implementations<cr>",
        desc = "LSP Implementation",
      },
      {
        "<leader>vr",
        "<cmd>Trouble toggle lsp_references<cr>",
        desc = "LSP References",
      },

      {
        "<leader>vL",
        "<cmd>Trouble loclist toggle<cr>",
        desc = "Location List (Trouble)",
      },
      {
        "<leader>vQ",
        "<cmd>Trouble qflist toggle<cr>",
        desc = "Quickfix List (Trouble)",
      },
    },
  },
}
