local mason_lsp_config_loaded, mason_lsp_config = pcall(require, "mason-lspconfig")
if not mason_lsp_config_loaded then return end
local mason_loaded, mason = pcall(require, "mason")
if not mason_loaded then return end
local lspconfig_loaded, lspconfig = pcall(require, 'lspconfig')
if not lspconfig_loaded then return end
local navic_loaded, navic = pcall(require, 'nvim-navic')
if not navic_loaded then return end

local servers = {
    "tsserver",
    "jsonls",
    "marksman",
    "lua_ls",
}

mason_lsp_config.setup({
  ensure_installed = servers,
  automatic_installation = false
})

for _, server in ipairs(servers) do
  if server == "tsserver" then
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
  elseif server == "jsonls" then
    lspconfig.jsonls.setup {
      on_attach = function(client, bufnr)
        navic.attach(client, bufnr)
      end
    }
  elseif server == "marksman" then
    lspconfig.marksman.setup {
      on_attach = function(client, bufnr)
        navic.attach(client, bufnr)
      end
    }
  elseif server == "lua_ls" then
    lspconfig.lua_ls.setup {
      settings = {
        Lua = { diagnostics = { globals = { 'vim', 'use' } } },
      },
      on_attach = function(client, bufnr)
        navic.attach(client, bufnr)
      end
    }
  end
end
