local servers = vim.split(vim.g.LSP_SERVERS, ",")

return {
  {
    "neovim/nvim-lspconfig",
    event = "VeryLazy",
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
        "<leader>df",
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
      {
        "<leader>lh",
        "<CMD>lua vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())<CR>",
        desc ="Toggle [l]sp inlay [h]ints",
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
        if server == "denols" then
          lspconfig.denols.setup {
            on_attach = function(client, bufnr)
              navic.attach(client, bufnr)
            end,
            root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc"),
          }
        -- TODO: find way to enable inlay hints globally
        -- and combine all lsp setup into one loop
        elseif server == "ts_ls" then
          lspconfig.ts_ls.setup {
            on_attach = function(client, bufnr)
              navic.attach(client, bufnr)
            end,
            root_dir = lspconfig.util.root_pattern("package.json"),
            single_file_support = false,
            init_options = {
              preferences = {
                importModuleSpecifierPreference = 'non-relative',
                includeInlayEnumMemberValueHints = false,
                includeInlayFunctionLikeReturnTypeHints = false,
                includeInlayFunctionParameterTypeHints = false,
                ---@type "all" | "none" | "literals"
                includeInlayParameterNameHints = 'all',
                includeInlayParameterNameHintsWhenArgumentMatchesName = true,
                includeInlayPropertyDeclarationTypeHints = false,
                includeInlayVariableTypeHints = false,
                includeInlayVariableTypeHintsWhenTypeMatchesName = false,
              },
            },
          }
        elseif server == "eslint" then
          lspconfig.eslint.setup {}
        elseif server == "graphql" then
          lspconfig.graphql.setup {
            filetypes = { "gql", "graphql" },
          }
        elseif server == "gopls" then
          lspconfig.gopls.setup {
            on_attach = function(client, bufnr)
              navic.attach(client, bufnr)
            end
          }
        elseif server == "pylsp" then
          lspconfig.pylsp.setup {
            on_attach = function(client, bufnr)
              navic.attach(client, bufnr)
            end
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
              Lua = { diagnostics = { globals = { 'vim', 'use', 'bit' } } },
            },
            on_attach = function(client, bufnr)
              navic.attach(client, bufnr)
            end
          }
        elseif server == "gopls" then
          lspconfig.gopls.setup {
            on_attach = function(client, bufnr)
              navic.attach(client, bufnr)
            end
          }
        elseif server == "bashls" then
          lspconfig.bashls.setup {
            on_attach = function(client, bufnr)
              navic.attach(client, bufnr)
            end,
            filetypes = { "sh", "zsh", "bash" },
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
