return {
  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    dependencies = 'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
      require('nvim-treesitter.configs').setup({
        textobjects = {
          move = {
            enable = true,
            goto_next_start = {
              ["]f"] = "@function.outer",
              ["]a"] = "@argument.outer",
              ["]m"] = "@method.outer",
              -- ...
            },
            goto_previous_start = {
              ["[f"] = "@function.outer",
              ["[a"] = "@argument.outer",
              ["[m"] = "@method.outer",
              -- ...
            },
          },
        },
      })
    end,
  },
  {
    'jinh0/eyeliner.nvim',
    keys = { 't', 'f', 'T', 'F' },
    opts = {
      highlight_on_key = true,
      dim = true,
      default_keymaps = false,
    },
    config = function(_, opts)
      require('eyeliner').setup(opts)
      vim.api.nvim_set_hl(0, 'EyelinerPrimary', { fg = '#ff9e3b', bold = true, underline = true })
      vim.api.nvim_set_hl(0, 'EyelinerSecondary', { fg = '#fa5b60', underline = true })
    end
  },
  {
    'mawkler/demicolon.nvim',
    lazy = false,
    dependencies = {
      'jinh0/eyeliner.nvim',
      'nvim-treesitter/nvim-treesitter',
      'nvim-treesitter/nvim-treesitter-textobjects'
    },
    -- keys = { ';', ',', 't', 'f', 'T', 'F', ']', '[', ']d', '[d' },
    config = function()
      require('demicolon').setup({
        keymaps = {
          horizontal_motions = false,
        },
        -- integrations = {
        --   -- Integration with https://github.com/lewis6991/gitsigns.nvim
        --   gitsigns = {
        --     enabled = true,
        --     keymaps = {
        --       next = ']g',
        --       prev = '[g',
        --     },
        --   },
        -- },
      })

      local function eyeliner_jump(key)
        local forward = vim.list_contains({ 't', 'f' }, key)
        return function()
          require('eyeliner').highlight({ forward = forward })
          return require('demicolon.jump').horizontal_jump(key)()
        end
      end

      local nxo = { 'n', 'x', 'o' }
      local opts = { expr = true }

      vim.keymap.set(nxo, 'f', eyeliner_jump('f'), opts)
      vim.keymap.set(nxo, 'F', eyeliner_jump('F'), opts)
      vim.keymap.set(nxo, 't', eyeliner_jump('t'), opts)
      vim.keymap.set(nxo, 'T', eyeliner_jump('T'), opts)
    end
  }
}
