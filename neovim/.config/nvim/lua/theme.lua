-- shorthand reference
local g = vim.opt
local b = vim.bo
local w = vim.wo

-- theme selector
-- local theme = 'gotham256' ; local light = false
local theme = 'gruvbox' ; local light = false
-- local theme = 'onedark' ; local light = true

COLORS = {
	black    = '#1d2021',
	grey0    = '#282828',
	grey1    = '#504945',
	grey2    = '#7c6f64',
	grey3    = '#a89984',
	grey4    = '#ebdbb2',
	white    = '#fbf1c7',

	bright_red     = '#fb4934',
	bright_green   = '#b8bb26',
	bright_yellow  = '#fabd2f',
	bright_blue    = '#83a598',
	bright_purple  = '#d3869b',
	bright_aqua    = '#8ec07c',
	bright_orange  = '#fe8019',

	neutral_red    = '#cc241d',
	neutral_green  = '#98971a',
	neutral_yellow = '#d79921',
	neutral_blue   = '#458588',
	neutral_purple = '#b16286',
	neutral_aqua   = '#689d6a',
	neutral_orange = '#d65d0e',

	faded_red      = '#9d0006',
	faded_green    = '#79740e',
	faded_yellow   = '#b57614',
	faded_blue     = '#076678',
	faded_purple   = '#8f3f71',
	faded_aqua     = '#427b58',
	faded_orange   = '#af3a03',
}
-- light theme
-- COLORS = {
--   black   = '#fafafa',
--   grey0   = '#e6e6e6',
--   grey1   = '#dcdcdc',
--   grey2   = '#c9c9c9',
--   grey3   = '#a0a1a7',
--   grey4   = '#818387',
--   white   = '#101012',
--   blue    = '#4078f2',
--   red     = '#e45649',
--   orange  = '#c18401',
--   yellow  = '#986801',
--   green   = '#50a14f',
--   purple  = '#a626a4',
--   cyan    = '#0184bc',
--   blue2   = '#2c485f',
--   red2    = '#833b3b',
--   orange2 = '#7c5c20',
--   yellow2 = '#7c5c20',
--   green2  = '#282b26',
--   purple2 = '#79428a',
--   cyan2   = '#2b5d63',
-- }

-- color schemes
local status_ok, _ = pcall(vim.cmd, 'colorscheme ' .. theme)
if not status_ok then vim.notify('colorscheme ' .. theme .. ' not found!') end

if (light) then vim.cmd('set background=light') end
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

-- theme specific highlights
if (theme == 'gotham256') then
  vim.cmd('hi! LineNr guibg=NONE guifg=NONE')
  vim.cmd('hi! SpellBad guibg=NONE guifg=NONE')
elseif (theme == 'PaperColor') then
  vim.cmd('hi! Comment guibg=NONE guifg=#636361')
  vim.cmd('hi! NonText guibg=NONE guifg=#636361')
  vim.cmd('hi! LineNr guibg=NONE guifg=NONE')
  vim.cmd('hi! SpellBad guibg=NONE guifg=NONE')
elseif (theme == 'onedark') then
  vim.cmd('hi! EndOfBuffer guibg=NONE')
elseif (theme == 'gruvbox') then
  -- vim.cmd('hi LineNr guibg=NONE guifg=NONE')
end

return {
	colors = COLORS,
}

