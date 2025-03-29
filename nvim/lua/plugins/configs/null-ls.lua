local null_ls = require "null-ls"
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local opts = {
  sources = {
    -- python
    null_ls.builtins.formatting.black,
    null_ls.builtins.diagnostics.mypy,

    -- go
    null_ls.builtins.formatting.gofumpt,
    null_ls.builtins.formatting.goimports_reviser, -- TODO: using go's official tooling only
    null_ls.builtins.formatting.golines, -- TODO: using go's official tooling only

    -- js/ts
    null_ls.builtins.formatting.biome,

    -- sql
    null_ls.builtins.formatting.pg_format,

    -- dockerfile (not compose)
    null_ls.builtins.diagnostics.hadolint,

    -- html
    null_ls.builtins.diagnostics.tidy.with {
      filetypes = { "html"},
    },

    -- misc
    null_ls.builtins.formatting.prettier.with {
      filetypes = { "html", "json", "yaml", "markdown", "css" },
    },

    -- nix
    null_ls.builtins.formatting.nixfmt,
    null_ls.builtins.diagnostics.statix,
    null_ls.builtins.code_actions.statix,

    -- shell
    null_ls.builtins.formatting.shellharden,
    null_ls.builtins.formatting.shfmt,

    -- c
    null_ls.builtins.formatting.clang_format,
  },

  on_attach = function(client, bufnr)
    if client.supports_method "textDocument/formatting" then
      vim.api.nvim_clear_autocmds {
        group = augroup,
        buffer = bufnr,
      }
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format { bufnr = bufnr }
        end,
      })
    end
  end,
}
return opts
