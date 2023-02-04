--local colors = require 'material.colors'
local material = require 'material'

material.setup{
    plugins = { -- Uncomment the plugins that you use to highlight them
        "gitsigns",
        "nvim-cmp",
        "telescope",
    },

    disable = {
        colored_cursor = false, -- Disable the colored cursor
        borders = false, -- Disable borders between verticaly split windows
        background = false, -- Prevent the theme from setting the background (NeoVim then uses your terminal background)
        term_colors = false, -- Prevent the theme from setting terminal colors
        eob_lines = false -- Hide the end-of-buffer lines
    },

    high_visibility = {
        lighter = true, -- Enable higher contrast text for lighter style
        darker = true -- Enable higher contrast text for darker style
    },

    lualine_style = "stealth", -- Lualine style ( can be 'stealth' or 'default' )

    async_loading = true, -- Load parts of the theme asyncronously for faster startup (turned on by default)

    custom_highlights = {},

    --    custom_colors = function(colors)
    --        colors.editor.bg = "#223322"
    --    end
}
