-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

local lspconfig = require "lspconfig"
local nvlsp = require "nvchad.configs.lspconfig"

-- language servers
lspconfig.servers = {
  "ts_ls",
  "tailwindcss",
  "eslint",
  "html",
  "gopls",
}

lspconfig.gopls.setup(require "configs.gopls")

-- lsps with default config
for _, lsp in ipairs(lspconfig.servers) do
  lspconfig[lsp].setup {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  }
end

lspconfig.eslint.setup {
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
  settings = {
    packageManager = "npm",
    rulePaths = {},
    useESLintClass = false,
    experimental = { useFlatConfig = false },
    codeActionOnSave = { enable = true, mode = "all" },
  },
}

lspconfig.ts_ls.setup {
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
  filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
  settings = {
    typescript = {
      preferences = {
        importModuleSpecifierEnding = "auto",
        importModuleSpecifier = "relative",
        quoteStyle = "auto",
      },
      inlayHints = {
        includeInlayParameterNameHints = "all",
        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayEnumMemberValueHints = true,
      },
    },
    javascript = {
      preferences = {
        importModuleSpecifierEnding = "auto",
        importModuleSpecifier = "relative",
        quoteStyle = "auto",
      },
      inlayHints = {
        includeInlayParameterNameHints = "all",
        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayEnumMemberValueHints = true,
      },
    },
    diagnostics = {
      ignoredCodes = { 2307 },
    },
  },
}
