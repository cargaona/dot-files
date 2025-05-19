return {
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    commit = "3af6493bf69e4a857a8b1fab36f333629d413a18",
    tag = "v3.8.1",
    ---@module "ibl"
    ---@type ibl.config
    opts = {
      exclude = {
        filetypes = {
          "markdown",
        },
      },
      indent = {
        char = { "│" },
        tab_char = { "│" },
      },
      scope = { enabled = false, }
    },
    config = function(_, opts)
      require('ibl').setup(opts)
    end
  }
}
