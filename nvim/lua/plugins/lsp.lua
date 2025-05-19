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

vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', { desc = "Go to Declaration" })
vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', { desc = "Go to Definition" })
vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', { desc = "Show LSP Info" })
vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', { desc = "Go to Implementation" })
vim.keymap.set('n', '<leader>lsp', '<cmd>lua vim.lsp.buf.signature_help()<CR>', { desc = "Show signature help" })
vim.keymap.set('n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', { desc = "Add workspace folder" })
vim.keymap.set('n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', { desc = "Rm workspace folder" })
vim.keymap.set('n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', { desc = "List workspace folders" })
vim.keymap.set('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', { desc = "LSP Code actions" })
vim.keymap.set('v', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', { desc = "LSP Code actions" })
vim.keymap.set('n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', { desc = "Type Definition" })
vim.keymap.set('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', { desc = "LSP Rename" })
vim.keymap.set('n', '<leader>lr', '<cmd>lua vim.lsp.buf.references()<CR>', { desc = "List references" })
vim.keymap.set('n', '<leader>e', '<cmd>lua vim.diagnostic.open_float()<CR>', { desc = "Open floating diagnostic" })
vim.keymap.set('n', '<leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', { desc = "Set diagnostic list" })
vim.keymap.set('n', '<leader>fm', '<cmd>lua vim.lsp.buf.format({ async = true })<CR>', { desc = "Format code" })

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
      local lspconfig = require("lspconfig")

      -- TSServer setup
      local function organize_imports()
        local params = {
          command = "_typescript.organizeImports",
          arguments = { vim.api.nvim_buf_get_name(0) },
        }
        vim.lsp.buf.execute_command(params)
      end

      lspconfig.ts_ls.setup {
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
      }

      -- Pyright setup
      lspconfig.pyright.setup {
        capabilities = capabilities,
        handlers = handlers,
        filetypes = { "python" },
      }

      -- BashLS setup
      lspconfig.bashls.setup {
        capabilities = capabilities,
        handlers = handlers,
        filetypes = { "shell", "bash", "zsh", "sh" },
      }

      -- Gopls setup
      lspconfig.gopls.setup {
        capabilities = capabilities,
        handlers = handlers,
        filetypes = { "go", "gomod", "gowork", "gotmpl" },
        cmd = { "gopls" },
        root_dir = require("lspconfig/util").root_pattern("go.work", "go.mod", ".git"),
        settings = {
          gopls = {
            completeUnimported = true,
            usePlaceholders = true,
            analyses = {
              unusedparams = true,
            },
          },
        },
      }

      -- DockerLS setup
      lspconfig.dockerls.setup {
        capabilities = capabilities,
        handlers = handlers,
        cmd = { "docker-langserver", "--stdio" },
        filetypes = { "dockerfile" },
        root_dir = require("lspconfig/util").root_pattern "Dockerfile",
        single_file_support = true,
      }

      -- Docker Compose Language Service setup
      lspconfig.docker_compose_language_service.setup {
        capabilities = capabilities,
        handlers = handlers,
        cmd = { "docker-compose-langserver", "--stdio" },
        filetypes = { "yaml.docker-compose", "docker-compose.yaml", "docker-compose.yml" },
        root_dir = require("lspconfig/util").root_pattern("docker-compose.yaml", "docker-compose.yml", "compose.yaml", "compose.yml"),
        single_file_support = true,
      }

      -- yaml
      lspconfig.yamlls.setup {
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
      }

      -- Terraform setup
      lspconfig.tflint.setup{
        flags = { debounce_text_changes = 150 },
      }

      lspconfig.terraformls.setup{
        capabilities = capabilities,
        handlers = handlers,
        on_attach = function(client)
          client.server_capabilities.document_formatting = true
        end,
        cmd = { "terraform-ls", "serve" },
        filetypes = { "tf", "terraform", "tfvars" },
      }

      -- SQL Language Server setup
      lspconfig.sqlls.setup {
        capabilities = capabilities,
        handlers = handlers,
        filetypes = { "sql", "pgsql", "mysql" },
        root_dir = function(_)
          return vim.loop.cwd()
        end,
      }

      -- CSS Language Server setup
      lspconfig.cssls.setup {
        capabilities = capabilities,
        handlers = handlers,
      }

      -- CCLS setup
      lspconfig.ccls.setup {
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
      }

      -- nix
      lspconfig.nil_ls.setup {
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
      }


      -- lua
      lspconfig.lua_ls.setup({
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
    end,
  },
}
