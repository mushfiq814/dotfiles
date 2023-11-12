local afterFileOpen = { "BufReadPre", "BufNewFile" }

local servers = {}
-- LSP_SERVERS is populated from env file via config/utils/read-env
for s in vim.g.LSP_SERVERS:gmatch("[^,]+") do
  table.insert(servers, s)
end

return {
  {
    -- TODO: lazy load only during specified lsp server filetypes are loaded
    "neovim/nvim-lspconfig",
    event = afterFileOpen,
    keys = {
      {
        "K",
        "<CMD>lua vim.lsp.buf.hover()<CR>",
        desc = "Display hover information about the symbol under the cursor"
      },
      {
        "<leader>K",
        "<CMD>lua vim.diagnostic.open_float()<CR>",
        desc = "Show current line diagnostic in popup window"
      },
      {
        "<leader>ka",
        "<CMD>lua vim.diagnostic.setqflist()<CR>",
        desc = "Populate quickfix list with diagnostics"
      },
      {
        "gd",
        "<CMD>lua vim.lsp.buf.definition()<CR>",
        desc = "Go to definition"
      },
      {
        "gD",
        "<CMD>lua vim.lsp.buf.declaration()<CR>",
        desc = "Go to declaration"
      },
      {
        "gi",
        "<CMD>lua vim.lsp.buf.implementation()<CR>",
        desc = "Go to implementation"
      },
      {
        "gs",
        "<CMD>lua vim.lsp.buf.signature_help()<CR>",
        desc = "Function signature help"
      },
      {
        "<leader>ff",
        "<CMD>lua vim.lsp.buf.format { async = true }<CR>",
        desc = "LSP run format"
      },
      {
        "<leader>gt",
        "<CMD>lua vim.lsp.buf.type_definition()<CR>",
        desc = "Type Definition"
      },
      {
        "<leader>rn",
        "<CMD>lua vim.lsp.buf.rename()<CR>",
        desc = "LSP rename"
      },
      {
        "<leader>ca",
        "<CMD>lua vim.lsp.buf.code_action()<CR>",
        desc = "Show code actions"
      },
      {
        "[v",
        "<CMD>lua vim.diagnostic.goto_prev()<CR>",
        desc = "Go to previous diagnostic in file"
      },
      {
        "]v",
        "<CMD>lua vim.diagnostic.goto_next()<CR>",
        desc = "Go to next diagnostic in file"
      },
    },
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "SmiteshP/nvim-navic",
    },
    config = function()
      local lspconfig_loaded, lspconfig = pcall(require, 'lspconfig')
      if not lspconfig_loaded then return end
      local navic_loaded, navic = pcall(require, 'nvim-navic')
      if not navic_loaded then return end
      local border_loaded, b = pcall(require, 'config/utils/border')
      if not border_loaded then return end

      local border = b.borders

      local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
      function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
        opts = opts or {}
        opts.border = opts.border or border
        return orig_util_open_floating_preview(contents, syntax, opts, ...)
      end

      -- global diagnostic settings
      vim.diagnostic.config({
        virtual_text = true,
        signs = true,
        underline = true,
        update_in_insert = false,
        severity_sort = false,
      })

      for _, server in ipairs(servers) do
        -- TODO: find way to enable inlay hints globally
        -- and combine all lsp setup into one loop
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
    end
  },
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    build = ":MasonUpdate",
    opts = {
      ensure_installed = servers,
      automatic_installation = false
    },
  },
  {
    "SmiteshP/nvim-navic",
    opts = {
      icons = {
        Array         = " ",
        Boolean       = ' ',
        Class         = ' ',
        Constant      = " ",
        Constructor   = " ",
        Enum          = ' ',
        EnumMember    = ' ',
        Event         = " ",
        Field         = " ",
        File          = " ",
        Function      = " ",
        Interface     = ' ',
        Key           = " ",
        Method        = " ",
        Module        = " ",
        Namespace     = " ",
        Null          = "ﳠ ",
        Number        = " ",
        Object        = " ",
        Operator      = ' ',
        Package       = ' ',
        Property      = " ",
        String        = " ",
        Struct        = ' ',
        TypeParameter = ' ',
        Variable      = ' ',
      },
      highlight = true,
      separator = " > ",
      depth_limit = 0,
      depth_limit_indicator = "..",
    },
    lazy = true,
  },
  {
    "simrat39/symbols-outline.nvim",
    cmd = "SymbolsOutline",
    opts = {},
  },
}
