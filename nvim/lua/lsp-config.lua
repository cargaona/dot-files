local lspconfig = require("lspconfig")
local lsp_status = require("lsp-status")
lsp_status.register_progress()
local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- LSP settings (for overriding per client)
local signs = { Error = "❌", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- Diagnosticis Signs
local border = {
  { "╭", "FloatBorder" },
  { "─", "FloatBorder" },
  { "╮", "FloatBorder" },
  { "│", "FloatBorder" },
  { "╯", "FloatBorder" },
  { "─", "FloatBorder" },
  { "╰", "FloatBorder" },
  { "│", "FloatBorder" },
}

local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
  opts = opts or {}
  opts.border = opts.border or border
  return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

-- LSP settings (for overriding per client)
local handlers = {
  ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border }),
  ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = border }),
}
vim.diagnostic.config({
  virtual_text = {
    prefix = " ",
    spacing = 0,
  },
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = false,
})

-- Linters, Prettiers and Checkers for EFM
-----------------------------
-- ES Linter -- npm i -g eslint_d
local eslint = {
  lintCommand = "eslint_d -f visualstudio --stdin --stdin-filename ${INPUT}",
  lintIgnoreExitCode = true,
  lintStdin = true,
  lintFormats = { "%f(%l,%c): %tarning %m", "%f(%l,%c): %rror %m" },
  lintSource = "eslint",
}

-- General prettier -- npm i -g prettier
local prettier = {
  formatCommand = "prettier --stdin-filepath ${INPUT}",
  formatStdin = true,
}

-- Yaml linter -- brew install yamllint
local yamllint = {
  lintCommand = "yamllint --format parsable ${INPUT}",
  formatCommand = "prettier --parser yaml --no-bracket-spacing ${INPUT}",
  lintStdin = true,
}

local shell = {
  formatCommand = "shfmt ${-i:tabWidth}",
  lintCommand = "shellcheck -f gcc -x -",
  lintStdin = true,
  lintFormats = {
    "%f:%l:%c: %trror: %m",
    "%f:%l:%c: %tarning: %m",
    "%f:%l:%c: %tote: %m",
  },
}

lspconfig.nil_ls.setup({})

lspconfig.jsonls.setup({ capabilities = capabilities })

lspconfig.lua_ls.setup {
  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim' }
      }
    }
  }
}

lspconfig.rust_analyzer.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "rs", "rust" },
  settings = {
    ["rust-analyzer"] = {
      checkOnSave = {
        command = "clippy",
      },
      imports = {
        granularity = {
          group = "module",
        },
        prefix = "self",
      },
      cargo = {
        buildScripts = {
          enable = true,
        },
      },
      procMacro = {
        enable = true
      },
    }
  }
})

-- Python
lspconfig.anakin_language_server.setup({ capabilities = capabilities, handlers = handlers })

-- Go 
lspconfig.gopls.setup({ capabilities = capabilities, cmd = { 'gopls', '--remote=auto' } })

-- C
--lspconfig.ccls.setup({
--capabilities = capabilities,
----cmd = { 'ccls' },
----filetypes = { 'c', 'cpp', 'objc', 'objcpp' },
----offset_encoding = 'utf-32',
------ ccls does not support sending a null root directory
----single_file_support = false,
--})

lspconfig.clangd.setup({
  --capabilities = capabilities,
})

lspconfig.ruby_lsp.setup {}

--- vlang
lspconfig.vls.setup {}

-- Terraform
lspconfig.tflint.setup({
  flags = { debounce_text_changes = 150 },
})

vim.cmd([[silent! autocmd! filetypedetect BufRead,BufNewFile *.tf]])
vim.cmd([[autocmd BufRead,BufNewFile *.hcl set filetype=hcl]])
vim.cmd([[autocmd BufRead,BufNewFile .terraformrc,terraform.rc set filetype=hcl]])
vim.cmd([[autocmd BufRead,BufNewFile *.tf,*.tfvars set filetype=terraform]])
vim.cmd([[autocmd BufRead,BufNewFile *.tfstate,*.tfstate.backup set filetype=json]])

lspconfig.terraformls.setup({
  --capabilities = capabilities,
  --on_attach = function(client)
    --client.server_capabilities.document_formatting = true
  --end,
  --cmd = { "terraform-ls", "serve" },
  ----cmd = { "terraform-lsp"},
  --filetypes = { "tf", "terraform" },
})

-- SQL  -- go install github.com/lighttiger2505/sqls@latest
lspconfig.sqlls.setup({
  --cmd = { "/path/to/sqls", "-config", vim.loop.os_homedir()..".config/sqls/config.yml" },
  capabilities = capabilities,
})

-- Typescript
lspconfig.tsserver.setup({
  capabilities = capabilities,
  --filetypes = "html",
}
)

lspconfig.html.setup({
  cmd = { 'vscode-html-language-server', '--stdio' },
  filetypes = { 'html' },
  --root_dir = util.root_pattern('package.json', '.git'),
  single_file_support = true,
  settings = {},
  init_options = {
    provideFormatter = true,
    embeddedLanguages = { css = true, javascript = true },
    configurationSection = { 'html', 'css', 'javascript' },
  },
}
)
-- Languages setup
local languages = {
  typescript = { prettier, eslint },
  javascript = { prettier, eslint },
  yaml = { yamllint },
  --lua = { luafmt },
  html = { prettier },
  scss = { prettier },
  css = { prettier },
  markdown = { prettier },
  sh = { shell },
  zsh = { shell },
}

