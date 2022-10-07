-- shorthand reference
local g = vim.opt
local b = vim.bo
-- local w = vim.wo

-- theme selector
local colorsFound, colors = pcall(require, 'colors')
if not colorsFound then return end
local themes = {
  { name = 'gruvbox'      , light = false , color = colors.gruvbox       },
  { name = 'gruvbox-flat' , light = false , color = colors.gruvbox_flat  },
  { name = 'onedark'      , light = true  , color = colors.onedark_light },
  { name = 'catppuccin'   , light = false , color = colors.catppuccin    },
}
local selectedTheme = themes[1]
COLORS = selectedTheme.color

-- theme specific highlights
if (selectedTheme.name == 'gruvbox-flat') then
  -- vim.g.gruvbox_transparent = true
  -- vim.g.gruvbox_dark_sidebar = false
  -- vim.g.gruvbox_sidebars = {}
  -- vim.g.gruvbox_dark_float = false
  -- vim.g.gruvbox_hide_inactive_statusline = true
  -- vim.g.gruvbox_flat_style = 'hard'
  vim.cmd('hi! Folded guibg=' .. COLORS.black .. ' guifg=' .. COLORS.neutral_blue)
elseif (selectedTheme.name == 'onedark') then
  vim.cmd('hi! EndOfBuffer guibg=NONE')
elseif (selectedTheme.name == 'gruvbox') then
  -- vim.cmd('hi LineNr guibg=NONE guifg=NONE')
end

-- set color scheme
local status_ok, _ = pcall(vim.cmd, 'colorscheme ' .. selectedTheme.name)
if not status_ok then vim.notify('colorscheme ' .. selectedTheme.name .. ' not found!') end

if (selectedTheme.light) then
  vim.cmd('set background=light')
  vim.cmd('hi! NormalFloat guibg=white')
  vim.cmd('hi! Normal guibg=white')
  vim.cmd('hi! EndOfBuffer guibg=none')
else
  vim.cmd('set background=dark')
  vim.cmd('hi! NormalFloat guibg=NONE')
  vim.cmd('hi! Normal guibg=NONE ctermbg=NONE')
  vim.cmd('hi! FloatBorder guibg=NONE guifg=' .. COLORS.white)
  vim.cmd('hi! WinSeparator guibg=NONE guifg=' .. COLORS.grey1)
  vim.cmd('hi! NvimTreeWinSeparator guibg=NONE guifg=' .. COLORS.grey1)
end
-- vim.cmd('hi! Pmenu guibg=NONE')
vim.cmd('hi! SignColumn guibg=NONE')
-- vim.cmd('hi! LineNr guibg=' .. COLORS.grey0)
-- vim.cmd('hi! LineNrAbove guibg=NONE guifg=' .. COLORS.grey3)
-- vim.cmd('hi! LineNrBelow guibg=NONE guifg=' .. COLORS.grey3)
-- vim.cmd('hi! CursorLine guibg=' .. COLORS.grey0)
-- vim.cmd('hi! Folded guibg=' .. COLORS.grey2 .. ' guifg=' .. COLORS.white)
b.syntax = 'ON'
g.termguicolors = true

-- Neovim LSP virtual diagnostics
vim.cmd('hi! LspDiagnosticsDefaultError guifg=' .. COLORS.bright_red)
vim.cmd('hi! LspDiagnosticsDefaultWarning guifg=' .. COLORS.neutral_yellow)
vim.cmd('hi! LspDiagnosticsDefaultInformation guifg=' .. COLORS.neutral_blue)
vim.cmd('hi! LspDiagnosticsDefaultHint guifg=' .. COLORS.neutral_aqua)

vim.cmd('sign define DiagnosticSignError text= texthl=LspDiagnosticsDefaultError       linehl= numhl=')
vim.cmd('sign define DiagnosticSignWarn  text= texthl=LspDiagnosticsDefaultWarning     linehl= numhl=')
vim.cmd('sign define DiagnosticSignInfo  text= texthl=LspDiagnosticsDefaultInformation linehl= numhl=')
vim.cmd('sign define DiagnosticSignHint  text= texthl=LspDiagnosticsDefaultHint        linehl= numhl=')

-- remove both colors from regular signcolumn
-- vim.cmd('hi! SignColumn guifg=# guibg=#')

return {
	colors = COLORS,
}
