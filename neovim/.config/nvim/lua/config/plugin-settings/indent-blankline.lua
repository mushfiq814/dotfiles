local loaded, indent_blankline = pcall(require, 'ibl')
if not loaded then return end

vim.opt.list = true
vim.opt.termguicolors = true

indent_blankline.setup {
  -- Special Characters: '│' '█' '▏'
  show_current_context = true,
  show_current_context_start = true,
  use_treesitter = true, -- Enable tree sitter to detect current indent level. Needs Treesitter installed
  disable_with_nolist = true, -- When true, automatically turns this plugin off when |nolist| is set.
  char = "▏",
  context_char = "▏",
  context_char_blankline = "▏",
  space_char = " ",
  space_char_blankline = " ",
}
