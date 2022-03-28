-- shorthand reference
local g = vim.opt
local b = vim.bo
-- local w = vim.wo

-- theme selector
local colorsFound, colors = pcall(require, 'colors')
if not colorsFound then return end
local themes = {
  { name = 'gotham256'    , light = false , color = colors.NONE          },
  { name = 'gruvbox'      , light = false , color = colors.gruvbox       },
  { name = 'gruvbox-flat' , light = false , color = colors.gruvbox_flat  },
  { name = 'onedark'      , light = true  , color = colors.onedark_light },
}
local selectedTheme = themes[3]
COLORS = selectedTheme.color

-- theme specific highlights
if (selectedTheme.name == 'gotham256') then
  vim.cmd('hi! LineNr guibg=NONE guifg=NONE')
  vim.cmd('hi! SpellBad guibg=NONE guifg=NONE')
elseif (selectedTheme.name == 'gruvbox-flat') then
  vim.g.gruvbox_transparent = true
  vim.g.gruvbox_dark_sidebar = false
  vim.g.gruvbox_sidebars = {}
  vim.g.gruvbox_dark_float = false
  vim.g.gruvbox_hide_inactive_statusline = true
  vim.g.gruvbox_flat_style = 'hard'
elseif (selectedTheme.name == 'PaperColor') then
  vim.cmd('hi! Comment guibg=NONE guifg=#636361')
  vim.cmd('hi! NonText guibg=NONE guifg=#636361')
  vim.cmd('hi! LineNr guibg=NONE guifg=NONE')
  vim.cmd('hi! SpellBad guibg=NONE guifg=NONE')
elseif (selectedTheme.name == 'onedark') then
  vim.cmd('hi! EndOfBuffer guibg=NONE')
elseif (selectedTheme.name == 'gruvbox') then
  -- vim.cmd('hi LineNr guibg=NONE guifg=NONE')
end

-- set color scheme
local status_ok, _ = pcall(vim.cmd, 'colorscheme ' .. selectedTheme.name)
if not status_ok then vim.notify('colorscheme ' .. selectedTheme.name .. ' not found!') end

if (selectedTheme.light) then vim.cmd('set background=light') end
vim.cmd('hi! Normal guibg=NONE ctermbg=NONE')
vim.cmd('hi! SignColumn guibg=NONE')
vim.cmd('hi! LineNr guibg=' .. COLORS.grey0)
vim.cmd('hi! LineNrAbove guibg=NONE guifg=' .. COLORS.grey3)
vim.cmd('hi! LineNrBelow guibg=NONE guifg=' .. COLORS.grey3)
vim.cmd('hi! CursorLine guibg=' .. COLORS.grey0)
b.syntax = 'ON'
g.termguicolors = true

-- Neovim LSP virtual diagnostics
vim.cmd('hi! LspDiagnosticsDefaultError guifg=' .. COLORS.neutral_red)
vim.cmd('hi! LspDiagnosticsDefaultWarning guifg=' .. COLORS.neutral_yellow)
vim.cmd('hi! LspDiagnosticsDefaultInformation guifg=' .. COLORS.neutral_blue)
vim.cmd('hi! LspDiagnosticsDefaultHint guifg=' .. COLORS.neutral_aqua)

vim.cmd('sign define DiagnosticSignError text= texthl=LspDiagnosticsDefaultError       linehl= numhl=')
vim.cmd('sign define DiagnosticSignWarn  text= texthl=LspDiagnosticsDefaultWarning     linehl= numhl=')
vim.cmd('sign define DiagnosticSignInfo  text= texthl=LspDiagnosticsDefaultInformation linehl= numhl=')
vim.cmd('sign define DiagnosticSignHint  text= texthl=LspDiagnosticsDefaultHint        linehl= numhl=')

-- remove both colors from regular signcolumn
vim.cmd('hi! SignColumn guifg=# guibg=#')

return {
	colors = COLORS,
}

