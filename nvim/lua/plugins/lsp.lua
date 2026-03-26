-- Set rounded borders for LSP handlers
local handlers = {
  ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" }),
  ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" }),
}

-- Apply the handlers
for name, handler in pairs(handlers) do
  vim.lsp.handlers[name] = handler
end

vim.diagnostic.config({
  float = {
    border = "rounded",
  }
})

vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', { desc = "LSP - Go to Declaration" })
vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', { desc = "LSP - Go to Definition" })
vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', { desc = "LSP - Show Info" })
vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', { desc = "LSP - Go to Implementation" })
vim.keymap.set('n', '<leader>lsp', '<cmd>lua vim.lsp.buf.signature_help()<CR>', { desc = "LSP - Show signature help" })
vim.keymap.set('n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', { desc = "LSP - Add workspace folder" })
vim.keymap.set('n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', { desc = "LSP - Rm workspace folder" })
vim.keymap.set('n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', { desc = "LSP - List workspace folders" })
vim.keymap.set('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', { desc = "LSP - Code actions" })
vim.keymap.set('v', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', { desc = "LSP - Code actions" })
vim.keymap.set('n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', { desc = "LSP -Type Definition" })
vim.keymap.set('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', { desc = "LSP - Rename" })
vim.keymap.set('n', '<leader>lr', '<cmd>lua vim.lsp.buf.references()<CR>', { desc = "LSP - List references" })
-- vim.keymap.set('n', '<leader>e', '<cmd>lua vim.diagnostic.open_float()<CR>', { desc = "Open floating diagnostic" })
-- vim.keymap.set('n', '<leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', { desc = "Set diagnostic list" })
vim.keymap.set('n', '<leader>fm', '<cmd>lua vim.lsp.buf.format({ async = true })<CR>', { desc = "LSP - Format code" })

-- Inlay hints toggle
vim.keymap.set('n', '<leader>ih', '<cmd>lua vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())<CR>', { desc = "LSP - Toggle inlay hints" })

-- Diagnostic enable/disable
vim.keymap.set('n', '<leader>dd', '<cmd>lua vim.diagnostic.enable(false)<CR>', { desc = "LSP - Disable diagnostics" })
vim.keymap.set('n', '<leader>de', '<cmd>lua vim.diagnostic.enable(true)<CR>', { desc = "LSP - Enable diagnostics" })

-- commented out because demicolon takes care of this
-- vim.keymap.set('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', { desc = "" })
-- vim.keymap.set('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', { desc = "" })

-- Define capabilities with cmp_nvim_lsp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- Plugin configuration
return {
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    config = function()
      -- TSServer setup
      local function organize_imports()
        local params = {
          command = "_typescript.organizeImports",
          arguments = { vim.api.nvim_buf_get_name(0) },
        }
        vim.lsp.buf.execute_command(params)
      end

      vim.lsp.config('ts_ls', {
        capabilities = capabilities,
        handlers = handlers,
        init_options = {
          preferences = {
            disableSuggestions = true,
          },
        },
        commands = {
          OrganizeImports = {
            organize_imports,
            description = "Organize imports",
          },
        },
      })
      vim.lsp.enable('ts_ls')

      -- Pyright setup
      vim.lsp.config('pyright', {
        capabilities = capabilities,
        handlers = handlers,
      })
      vim.lsp.enable('pyright')

      -- BashLS setup
      vim.lsp.config('bashls', {
        capabilities = capabilities,
        handlers = handlers,
      })
      vim.lsp.enable('bashls')

      -- Gopls setup
      vim.lsp.config('gopls', {
        capabilities = capabilities,
        handlers = handlers,
        cmd = { "gopls" },
        root_markers = { "go.work", "go.mod", ".git" },
        settings = {
          gopls = {
            completeUnimported = true,
            usePlaceholders = true,
            analyses = {
              unusedparams = true,
            },
          },
        },
      })
      vim.lsp.enable('gopls')

      -- DockerLS setup
      vim.lsp.config('dockerls', {
        capabilities = capabilities,
        handlers = handlers,
        cmd = { "docker-langserver", "--stdio" },
        root_markers = { "Dockerfile" },
      })
      vim.lsp.enable('dockerls')

      -- Docker Compose Language Service setup
      vim.lsp.config('docker_compose_language_service', {
        capabilities = capabilities,
        handlers = handlers,
        cmd = { "docker-compose-langserver", "--stdio" },
        root_markers = { "docker-compose.yaml", "docker-compose.yml", "compose.yaml", "compose.yml" },
      })
      vim.lsp.enable('docker_compose_language_service')

      -- yaml
      vim.lsp.config('yamlls', {
        capabilities = capabilities,
        handlers = handlers,
        settings = {
          yaml = {
            schemas = {
              kubernetes = "k8s-*.yml",
              ["http://json.schemastore.org/github-workflow"] = ".github/workflows/*",
              ["http://json.schemastore.org/github-action"] = ".github/action.{yml,yaml}",
              ["http://json.schemastore.org/ansible-stable-2.9"] = "roles/tasks/*.{yml,yaml}",
              ["http://json.schemastore.org/prettierrc"] = ".prettierrc.{yml,yaml}",
              ["http://json.schemastore.org/kustomization"] = "kustomization.{yml,yaml}",
              ["http://json.schemastore.org/ansible-playbook"] = "*play*.{yml,yaml}",
              ["http://json.schemastore.org/chart"] = "Chart.{yml,yaml}",
              ["https://json.schemastore.org/dependabot-v2"] = ".github/dependabot.{yml,yaml}",
              ["https://json.schemastore.org/gitlab-ci"] = "*gitlab-ci*.{yml,yaml}",
              -- ["https://raw.githubusercontent.com/OAI/OpenAPI-Specification/main/schemas/v3.1/schema.json"] = "*api*.{yml,yaml}",
              ["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = "*docker-compose*.{yml,yaml}",
              ["https://raw.githubusercontent.com/argoproj/argo-workflows/master/api/jsonschema/schema.json"] = "*flow*.{yml,yaml}",
            },
          },
        }
      })
      vim.lsp.enable('yamlls')

      -- Terraform setup
      vim.lsp.config('tflint', {
        flags = { debounce_text_changes = 150 },
      })
      vim.lsp.enable('tflint')

      vim.lsp.config('terraformls', {
        capabilities = capabilities,
        handlers = handlers,
        cmd = { "terraform-ls", "serve" },
      })
      vim.lsp.enable('terraformls')

      -- SQL Language Server setup
      vim.lsp.config('sqlls', {
        capabilities = capabilities,
        handlers = handlers,
      })
      vim.lsp.enable('sqlls')

      -- CSS Language Server setup
      vim.lsp.config('cssls', {
        capabilities = capabilities,
        handlers = handlers,
      })
      vim.lsp.enable('cssls')

      -- CCLS setup
      vim.lsp.config('ccls', {
        capabilities = capabilities,
        handlers = handlers,
        init_options = {
          compilationDatabaseDirectory = "build",
          index = {
            threads = 0,
          },
          clang = {
            excludeArgs = { "-frounding-math" },
          },
        },
      })
      vim.lsp.enable('ccls')

      -- nix
      vim.lsp.config('nil_ls', {
        capabilities = capabilities,
        handlers = handlers,
        settings = {
          ['nil'] = {
            testSetting = 42,
            formatting = {
              command = { "nixfmt" },
            },
          },
        },
      })
      vim.lsp.enable('nil_ls')

      -- lua
      vim.lsp.config('lua_ls', {
        capabilities = capabilities,
        handlers = handlers,
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" },
              disable = { "different-requires" },
            },
          },
        },
      })
      vim.lsp.enable('lua_ls')
    end,
  },
}
