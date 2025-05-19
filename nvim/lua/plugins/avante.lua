return {
  "yetone/avante.nvim",
  event = "VeryLazy",
  version = false, -- Never set this value to "*"! This ensures compatibility with the plugin's latest stable version.
  opts = {
    provider = "copilot",
    copilot = {
      endpoint = "https://api.githubcopilot.com",
      -- model = "gpt-4o", -- your desired model (or use gpt-4o, etc.)
      timeout = 30000, -- Timeout in milliseconds. Ensure this value is sufficient for reasoning models but not excessively high.
      temperature = 0, -- 0 is deterministic (cold) 1 is random (hot). 
      max_completion_tokens = 1000000, -- Maximum tokens for reasoning models. Adjust based on your use case to balance performance and cost.
      reasoning_effort = "high", -- low|medium|high, only used for reasoning models
    },
  },
  -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
  build = "make", -- Default build command for Unix-based systems. Uncomment the Windows-specific build command below if needed.
  -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- Uncomment this for Windows systems.
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "stevearc/dressing.nvim",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
      --- The below dependencies are optional. They enable additional features and integrations:
    "echasnovski/mini.pick", -- Optional: Enables file selection using the mini.pick provider.
    "nvim-telescope/telescope.nvim", -- Optional: Enables file selection using the telescope provider.
    "hrsh7th/nvim-cmp", -- Optional: Provides autocompletion for Avante commands and mentions.
    "ibhagwan/fzf-lua", -- Optional: Enables file selection using the fzf provider.
    "nvim-tree/nvim-web-devicons", -- Optional: Adds file icons. Alternatively, use echasnovski/mini.icons.
    "zbirenbaum/copilot.lua", -- for providers='copilot'
    {
      -- support for image pasting
      "HakonHarnes/img-clip.nvim",
      event = "VeryLazy",
      opts = {
        -- recommended settings
        default = {
          embed_image_as_base64 = false,
          prompt_for_file_name = false,
          drag_and_drop = {
            insert_mode = true,
          },
          -- required for Windows users
          use_absolute_path = true,
        },
      },
    },
    {
      -- Make sure to set this up properly if you have lazy=true
      'MeanderingProgrammer/render-markdown.nvim',
      opts = {
        file_types = { "markdown", "Avante" },
      },
      ft = { "markdown", "Avante" },
    },
  },
}
