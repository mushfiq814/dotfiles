-- shorthand reference
local o = vim.opt
local g = vim.g
local b = vim.bo
local w = vim.wo

-- spacing and tabs
o.shiftwidth = 2 -- of spaces to use for each step of (auto)indent (>>, <<)
o.tabstop = 2 -- of spaces that a <Tab> counts for
o.softtabstop = 2 -- of spaces that a <Tab> counts while editing
o.expandtab = true -- insert mode: Disable inserting spaces for tabs

-- ui
o.number = true
o.relativenumber = false
o.showmode = false
o.showcmd = false
o.showmatch = true
o.compatible = false
o.mouse = 'a'
o.swapfile = false
o.wrap = false
o.linebreak = true
o.spell = true
o.clipboard = 'unnamed,unnamedplus'
o.foldlevelstart = 10
w.foldenable = true
o.list = true
o.listchars = {
  tab = '▶ ',
  precedes = '⋯',
  extends = '⋯',
  space = '·',
  trail = '■',
}
o.fillchars = {
  horiz = '─', -- horizontal separators |:split|
  horizup = '┴', -- upwards facing horizontal separator
  horizdown = '┬', -- downwards facing horizontal separator
  vert = '│', -- vertical separators |:vsplit|
  vertleft = '┤', -- left facing vertical separator
  vertright = '├', -- right facing vertical separator
  verthoriz = '┼', -- overlapping vertical and horizontal
  fold = '·', -- filling 'foldtext'
  foldopen = '-', -- mark the beginning of a fold
  foldclose = '▶', -- show a closed fold
  foldsep = '│', -- open fold middle marker
  diff = '-', -- deleted lines of the 'diff' option
  msgsep = ' ', -- message separator 'display'
  eob = '·', -- empty lines at the end of a buffer
  lastline = '@', -- 'display' contains lastline/truncate
}
w.cursorline = true
o.splitright = true
o.splitbelow = true

-- GUI
if vim.g.neovide then
  -- Put anything you want to happen only in Neovide here
  vim.o.guifont = "LigaSauceCodePro Nerd Font,Noto Color Emoji:h11"
  vim.g.neovide_cursor_vfx_mode = "sonicboom"
  vim.g.neovide_transparency = 0.7
end

-- searching
g.nohlsearch = true
o.incsearch = true
o.hlsearch = true
o.ignorecase = true
o.smartcase = true -- case-insensitive when using lowercase; otherwise, case-sensitive

-- file find
o.path:append('**')
o.wildmenu = true
o.wildignore:append('**/node_modules/**')
o.hidden = true
