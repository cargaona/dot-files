local cmp = require "cmp"

local ls = require "luasnip"

local lspkind = require "lspkind"
lspkind.init {}

local options = {
  sources = {
    { name = "nvim_lsp" },
    { name = "nvim_lua" },
    { name = "buffer",  max_item_count = 3 },
    { name = "path" },
    { name = "luasnip" },
  },

  completion = {
    completeopt = "menu,menuone,noselect",
  },

  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },

  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },

  mapping = {
    ["<C-D>"] = cmp.mapping.scroll_docs(-4),
    ["<C-F>"] = cmp.mapping.scroll_docs(4),

    ["<C-J>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
    ["<C-K>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
    ["<C-L>"] = cmp.mapping.confirm { behavior = cmp.ConfirmBehavior.Insert, select = true },
    ["<C-H>"] = cmp.mapping.complete(),

    ["<C-E>"] = cmp.mapping.close(),
  },
}


vim.keymap.set({ "i", "s" }, "<M-C-L>", function() ls.jump(1) end, { desc = "Snippet jump forward", silent = true })
vim.keymap.set({ "i", "s" }, "<M-C-H>", function() ls.jump(-1) end, { desc = "Snippet jump backward", silent = true })

return options
