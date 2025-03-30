return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    lazy = true,
    event = "VeryLazy",
    cmd = "Telescope",
    config = function()
      require("telescope").load_extension("persisted")
    end,
    init = function()
      local builtin = require('telescope.builtin')
      local wk = require('which-key')
      wk.add({
        -- { "<leader>F",  group = "Find" },
        { "<leader>/",  builtin.current_buffer_fuzzy_find,             desc = "Find in current buffer" },
        { "<leader>fb", builtin.buffers,                               desc = "Find Buffer" },
        { "<leader>fc", builtin.git_commits,                           desc = "Find Git commits" },
        { "<leader>ff", builtin.find_files,                desc = "Find File" },
        { "<leader>fj", "<cmd> Telescope frecency workspace=CWD <CR>", desc = "Find Frecency" },
        { "<leader>fg", builtin.git_files,                             desc = "Find Git tracked files" },
        { "<leader>fh", builtin.help_tags,                             desc = "Find Help" },
        { "<leader>fo", builtin.oldfiles,                              desc = "Find previous files" },
        { "<leader>fs", "<cmd> Telescope persisted <CR>",              desc = "Find sessions" },
        { "<leader>fgg", builtin.live_grep,                             desc = "Find with Grep" },
        { "<leader>gt", builtin.git_status,                            desc = "Git status" },
        {
          "<leader>fd",
          function()
            require('telescope.builtin').lsp_document_symbols({ symbols = 'function' })
          end,
          desc = "Find functions"
        },
        {
          "<leader>fy",
          function()
            require('telescope.builtin').lsp_document_symbols()
          end,
          desc = "Find symbols"
        },
        {
          "<leader>fa",
          function()
            require('telescope.builtin').find_files({ hidden = true, no_ignore = true, })
          end,
          desc = "Find all files"
        },
      })
    end,
    opts = function()
      return {
        defaults = {
          vimgrep_arguments = {
            "rg",
            "-L",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
          },
          previewer = true,
          file_previewer = require 'telescope.previewers'.vim_buffer_cat.new,
          grep_previewer = require 'telescope.previewers'.vim_buffer_vimgrep.new,
          qflist_previewer = require 'telescope.previewers'.vim_buffer_qflist.new,
        },
      }
    end,
  },
  {
    "nvim-telescope/telescope-frecency.nvim",
    lazy = true,
    event = "VeryLazy",
    version = "*",
    config = function()
      require("telescope").load_extension "frecency"
    end
  },
}
