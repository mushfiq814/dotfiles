local loaded, indent_blankline = pcall(require, 'ibl')
if not loaded then return end

vim.opt.list = true
vim.opt.termguicolors = true

indent_blankline.setup({
  debounce = 100,
  -- Special Characters: '│' '█' '▏'
  indent = { char = "▏" },
  whitespace = { highlight = { "Whitespace", "NonText" } },
})
