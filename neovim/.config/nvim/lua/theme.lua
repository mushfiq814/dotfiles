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
	blue     = '#83a598',
	red      = '#fb4934',
	orange   = '#fe8019',
	yellow   = '#fabd2f',
	green    = '#b8bb26',
	purple   = '#d3869b',
	cyan     = '#8ec07c',
	blue2    = '#458588',
	red2     = '#cc241d',
	orange2  = '#d65d0e',
	yellow2  = '#d79921',
	green2   = '#98971a',
	purple2  = '#b16286',
	cyan2    = '#689d6a',
}
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
vim.cmd('hi! LineNr guibg=#2d2d2d')
vim.cmd('hi! LineNrAbove guibg=NONE')
vim.cmd('hi! LineNrBelow guibg=NONE')
b.syntax = 'ON'
g.termguicolors = true

-- Neovim LSP virtual diagnostics
vim.cmd('hi! LspDiagnosticsDefaultError guifg=' .. COLORS.red2)
vim.cmd('hi! LspDiagnosticsDefaultWarning guifg=' .. COLORS.yellow2)
vim.cmd('hi! LspDiagnosticsDefaultInformation guifg=' .. COLORS.blue2)
vim.cmd('hi! LspDiagnosticsDefaultHint guifg=' .. COLORS.cyan2)

vim.cmd('sign define DiagnosticSignError text= texthl=LspDiagnosticsDefaultError       linehl= numhl=')
vim.cmd('sign define DiagnosticSignWarn  text= texthl=LspDiagnosticsDefaultWarning     linehl= numhl=')
vim.cmd('sign define DiagnosticSignInfo  text= texthl=LspDiagnosticsDefaultInformation linehl= numhl=')
vim.cmd('sign define DiagnosticSignHint  text= texthl=LspDiagnosticsDefaultHint        linehl= numhl=')

-- GitGutter
vim.cmd('hi! GitGutterAdd guifg=' .. COLORS.green .. ' guibg=#')
vim.cmd('hi! GitGutterChange guifg=' .. COLORS.cyan .. ' guibg=#')
vim.cmd('hi! GitGutterDelete guifg=' .. COLORS.red .. ' guibg=#')
vim.cmd('hi! GitGutterChangeDelete guifg=' .. COLORS.cyan .. ' guibg=' .. COLORS.red)
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

