-- Special Characters: '│' '█' '▏'
vim.g.indent_blankline_char = '▏'
vim.g.indent_blankline_space_char = ' '
vim.g.indent_blankline_space_char_blankline = '▏'

-- Enable tree sitter to detect current indent level. Needs Treesitter installed
vim.g.indent_blankline_use_treesitter = true

-- When true, automatically turns this plugin off when |nolist| is set.
vim.g.indent_blankline_disable_with_nolist = true
