local success, lspconfig = pcall(require, 'lspconfig')
if not success then return end

-- https://github.com/neovim/nvim-lspconfig/wiki/UI-Customization

-- options are 'none', 'single', 'double', 'rounded', 'solid', 'shadow'
-- see :help `nvim_open_win()`
local border = 'rounded'
-- can also be an array as follows
-- local border = {
--   {"⎾", "FloatBorder"},
--   {"▔", "FloatBorder"},
--   {"🭾", "FloatBorder"},
--   {"▕", "FloatBorder"},
--   {"🭿", "FloatBorder"},
--   {"▁", "FloatBorder"},
--   {"⌞", "FloatBorder"},
--   {"▏", "FloatBorder"},
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

lspconfig.tsserver.setup{}
lspconfig.sumneko_lua.setup{}

-- keybindings
local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

keymap('n', 'K', ':lua vim.lsp.buf.hover()<CR>', opts)
keymap('n', '<leader>K', ':lua vim.diagnostic.open_float()<CR>', opts)
keymap('n', 'gd', ':lua vim.lsp.buf.definition()<CR>', opts)
keymap('n', 'gD', ':lua vim.lsp.buf.declaration()<CR>', opts)
keymap('n', 'gi', ':lua vim.lsp.buf.implementation()<CR>', opts)
keymap('n', 'gw', ':lua vim.lsp.buf.document_symbol()<CR>', opts)
keymap('n', 'gs', ':lua vim.lsp.buf.signature_help()<CR>', opts)
-- keymap('n', 'gr', ':lua vim.lsp.buf.references()<CR>', opts)
keymap('n', '<leader>gt', ':lua vim.lsp.buf.type_definition()<CR>', opts)
keymap('n', '<leader>rn', ':lua vim.lsp.buf.rename()<CR>', opts)
keymap('n', '<leader>ca', ':lua vim.lsp.buf.code_action()<CR>', opts)
keymap('n', '[v', ':lua vim.diagnostic.goto_prev()<CR>', opts)
keymap('n', ']v', ':lua vim.diagnostic.goto_next()<CR>', opts)

