local success, nvim_treesitter = pcall(require, 'nvim-treesitter.configs')
if not success then return end

nvim_treesitter.setup {
	highlight = { enable = true },
	indent = { enable = true }
}

vim.o.foldmethod = 'expr'
vim.o.foldexpr = 'nvim_treesitter#foldexpr()'
