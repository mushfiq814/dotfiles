local success, lspconfig = pcall(require, 'lspconfig')
if not success then return end

-- https://github.com/neovim/nvim-lspconfig/wiki/UI-Customization

-- options are 'none', 'single', 'double', 'rounded', 'solid', 'shadow'
-- see :help `nvim_open_win()`
local border = 'rounded'
-- can also be an array as follows
local borders = {
  "⎾", "▔", "🭾",
  "▏", " ", "▕",
  "⌞", "▁", "🭿",
}
-- local border = {
--   {borders[1], "FloatBorder"},
--   {borders[2], "FloatBorder"},
--   {borders[3], "FloatBorder"},
--   {borders[6], "FloatBorder"},
--   {borders[9], "FloatBorder"},
--   {borders[8], "FloatBorder"},
--   {borders[7], "FloatBorder"},
--   {borders[4], "FloatBorder"},
-- }
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

local navic_success, navic = pcall(require, 'nvim-navic')
if not navic_success then return end

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
lspconfig.lua_ls.setup {
  settings = {
    Lua = { diagnostics = { globals = { 'vim', 'use' } } },
  },
  on_attach = function(client, bufnr)
    navic.attach(client, bufnr)
  end
}
lspconfig.jsonls.setup {
  on_attach = function(client, bufnr)
    navic.attach(client, bufnr)
  end
}
lspconfig.marksman.setup {}

-- keybindings
local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

keymap('n', 'K', ':lua vim.lsp.buf.hover()<CR>', opts)
keymap('n', '<leader>K', ':lua vim.diagnostic.open_float()<CR>', opts)
keymap('n', '<leader>ka', ':lua vim.diagnostic.setqflist()<CR>', opts)

keymap('n', 'gd', ':lua vim.lsp.buf.definition()<CR>', opts)
keymap('n', 'gD', ':lua vim.lsp.buf.declaration()<CR>', opts)
keymap('n', 'gi', ':lua vim.lsp.buf.implementation()<CR>', opts)
keymap('n', 'gs', ':lua vim.lsp.buf.signature_help()<CR>', opts)
keymap('n', '<leader>ff', ':lua vim.lsp.buf.format { async = true }<CR>', opts)
-- this is done in telescope keybinds now
-- keymap('n', 'gr', ':lua vim.lsp.buf.references()<CR>', opts)
keymap('n', '<leader>gt', ':lua vim.lsp.buf.type_definition()<CR>', opts)
keymap('n', '<leader>rn', ':lua vim.lsp.buf.rename()<CR>', opts)
keymap('n', '<leader>ca', ':lua vim.lsp.buf.code_action()<CR>', opts)
keymap('n', '[v', ':lua vim.diagnostic.goto_prev()<CR>', opts)
keymap('n', ']v', ':lua vim.diagnostic.goto_next()<CR>', opts)
