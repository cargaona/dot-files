return {
  {
    "lewis6991/gitsigns.nvim",
    lazy = false,
    opts = function()
      return require("plugins.configs.others").gitsigns
    end,
    config = function(_, opts)
      require("gitsigns").setup(opts)
      vim.keymap.set("n", "<leader>ghr", ":Gitsigns reset_hunk<CR>")
      vim.keymap.set("n", "<leader>ghs", ":Gitsigns stage_hunk<CR>")
      vim.keymap.set("n", "<leader>ghu", ":Gitsigns undo_stage_hunk<CR>")

      vim.keymap.set("n", "<leader>gb", ":Gitsigns blame_line<CR>")

      vim.keymap.set("n", "<leader>gd", ":Gitsigns diffthis<CR>")

      -- commented out because demicolon takes care of this now
      -- vim.keymap.set("n", "]g", ":Gitsigns next_hunk<CR>")
      -- vim.keymap.set("n", "[g", ":Gitsigns prev_hunk<CR>")
      vim.keymap.set("n", "<leader>gp", ":Gitsigns preview_hunk<CR>")
      vim.keymap.set("n", "<leader>ghv", ":Gitsigns select_hunk<CR>")
    end,
  },
}
