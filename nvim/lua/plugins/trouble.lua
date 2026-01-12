return {
  {
    "folke/trouble.nvim",
    lazy = true,
    event = "VeryLazy",
    opts = {}, -- for default options, refer to the configuration section for custom setup.
    cmd = "Trouble",
    keys = {
      {
        "<leader>tdv",
        "<cmd>Trouble diagnostics toggle win.position=right<cr>",
        desc = "Diagnostics (Trouble)",
      },
      {
        "<leader>tdb",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Buffer Diagnostics (Trouble)",
      },
      {
        "<leader>tsy",
        "<cmd>Trouble symbols toggle focus=false<cr>",
        desc = "Symbols (Trouble)",
      },

      {
        "<leader>tlv",
        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        desc = "LSP Sidebar",
      },
      {
        "<leader>tl",
        "<cmd>Trouble lsp toggle<cr>",
        desc = "LSP Definitions / references / ... (Trouble)",
      },
      {
        "<leader>tli",
        "<cmd>Trouble toggle lsp_incoming_calls<cr>",
        desc = "LSP Incoming Calls",
      },
      {
        "<leader>tlo",
        "<cmd>Trouble toggle lsp_outgoing_calls<cr>",
        desc = "LSP Outgoing Calls",
      },
      {
        "<leader>tlimp",
        "<cmd>Trouble toggle lsp_implementations<cr>",
        desc = "LSP Implementation",
      },
      {
        "<leader>tlref",
        "<cmd>Trouble toggle lsp_references<cr>",
        desc = "LSP References",
      },

      {
        "<leader>tlloc",
        "<cmd>Trouble loclist toggle<cr>",
        desc = "Location List (Trouble)",
      },
      {
        "<leader>tlq",
        "<cmd>Trouble qflist toggle<cr>",
        desc = "Quickfix List (Trouble)",
      },
    },
  },
}
