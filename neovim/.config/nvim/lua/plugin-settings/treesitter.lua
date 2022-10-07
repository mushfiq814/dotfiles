local success, nvim_treesitter = pcall(require, 'nvim-treesitter.configs')
if not success then return end

nvim_treesitter.setup {
  ensure_installed = {
    'typescript',
    'javascript',
    'lua',
    'json',
    'jsonc',
    'markdown',
    'markdown_inline',
  },
  highlight = { enable = true },
  incremental_selection = { enable = true },
  indent = { enable = true },
}

vim.wo.foldmethod = 'expr'
vim.wo.foldexpr = 'nvim_treesitter#foldexpr()'
