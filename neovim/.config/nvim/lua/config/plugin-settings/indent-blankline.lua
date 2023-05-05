local loaded, indent_blankline = pcall(require, 'indent_blankline')
if not loaded then return end

local colorsFound, colors = pcall(require, 'config/colors')
if not colorsFound then
  vim.notify('please generate colors file using the colorscheme script')
  return
end

local utils = require('config/utils/color-utils')
local hi = utils.highlight

vim.opt.list = true
vim.opt.termguicolors = true

hi.IndentBlanklineChar               = { guifg = colors.grey2 , gui = 'nocombine' }
hi.IndentBlanklineSpaceChar          = { guifg = colors.grey2 , gui = 'nocombine' }
hi.IndentBlanklineContextChar        = { guifg = colors.white , gui = 'bold,nocombine' }
hi.IndentBlanklineSpaceCharBlankline = { guifg = colors.white , gui = 'nocombine' }

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
