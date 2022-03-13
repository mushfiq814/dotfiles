require'nvim-treesitter.configs'.setup {
	ensure_installed = 'maintained',
	highlight = { enable = true },
	indent = { enable = true }
}

vim.o.foldmethod = 'expr'
vim.o.foldexpr = 'nvim_treesitter#foldexpr()'
