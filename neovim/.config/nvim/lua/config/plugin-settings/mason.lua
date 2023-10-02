local mason_lsp_config_loaded, mason_lsp_config = pcall(require, "mason-lspconfig")
if not mason_lsp_config_loaded then return end
local mason_loaded, mason = pcall(require, "mason")
if not mason_loaded then return end
local lspconfig_loaded, lspconfig = pcall(require, 'lspconfig')
if not lspconfig_loaded then return end
local navic_loaded, navic = pcall(require, 'nvim-navic')
if not navic_loaded then return end

mason.setup()
mason_lsp_config.setup({
  ensure_installed = {
    "tsserver",
    "jsonls",
    "marksman",
    "lua_ls",
  },
  automatic_installation = false
})

lspconfig.tsserver.setup {
  on_attach = function(client, bufnr)
    navic.attach(client, bufnr)
  end,
  init_options = {
    preferences = {
      includeInlayParameterNameHints = 'all',
      includeInlayParameterNameHintsWhenArgumentMatchesName = true,
      includeInlayFunctionParameterTypeHints = true,
      includeInlayVariableTypeHints = true,
      includeInlayPropertyDeclarationTypeHints = true,
      includeInlayFunctionLikeReturnTypeHints = true,
      includeInlayEnumMemberValueHints = true,
      importModuleSpecifierPreference = 'non-relative',
    },
  },
}
lspconfig.jsonls.setup {
  on_attach = function(client, bufnr)
    navic.attach(client, bufnr)
  end
}
lspconfig.marksman.setup {
  on_attach = function(client, bufnr)
    navic.attach(client, bufnr)
  end
}
lspconfig.lua_ls.setup {
  settings = {
    Lua = { diagnostics = { globals = { 'vim', 'use' } } },
  },
  on_attach = function(client, bufnr)
    navic.attach(client, bufnr)
  end
}
