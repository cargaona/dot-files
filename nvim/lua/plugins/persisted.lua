vim.keymap.set("n", "<leader>ss", "<cmd>SessionSave<CR>", { desc = "Save Session" })
return {
  {
    "olimorris/persisted.nvim",
    lazy = true, -- make sure the plugin is always loaded at startup
    config = true
  }
}
