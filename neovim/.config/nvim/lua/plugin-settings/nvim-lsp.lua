require('lspconfig').tsserver.setup{}
require('lspconfig').sumneko_lua.setup{}

local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- Lsp
keymap('n', 'K', ':lua vim.lsp.buf.hover()<CR>', opts)
keymap('n', '<leader>K', ':lua vim.diagnostic.open_float()<CR>', opts)
keymap('n', 'gd', ':lua vim.lsp.buf.definition()<CR>', opts)
keymap('n', 'gD', ':lua vim.lsp.buf.declaration()<CR>', opts)
keymap('n', 'gi', ':lua vim.lsp.buf.implementation()<CR>', opts)
keymap('n', 'gw', ':lua vim.lsp.buf.document_symbol()<CR>', opts)
keymap('n', 'gs', ':lua vim.lsp.buf.signature_help()<CR>', opts)
keymap('n', 'gr', ':lua vim.lsp.buf.references()<CR>', opts)
keymap('n', '<leader>gt', ':lua vim.lsp.buf.type_definition()<CR>', opts)
keymap('n', '<leader>rn', ':lua vim.lsp.buf.rename()<CR>', opts)
keymap('n', '<leader>ca', ':lua vim.lsp.buf.code_action()<CR>', opts)
keymap('n', '[v', ':lua vim.diagnostic.goto_prev()<CR>', opts)
keymap('n', ']v', ':lua vim.diagnostic.goto_next()<CR>', opts)

