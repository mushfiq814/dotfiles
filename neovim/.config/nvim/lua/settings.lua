-- shorthand reference
local o = vim.opt
local g = vim.g
local b = vim.bo
local w = vim.wo

-- spacing and tabs
o.shiftwidth = 2    -- of spaces to use for each step of (auto)indent (>>, <<)
o.tabstop = 2       -- of spaces that a <Tab> counts for
o.softtabstop = 2   -- of spaces that a <Tab> counts while editing
o.expandtab = true -- insert mode: Disable inserting spaces for tabs

-- ui
o.number = true
o.relativenumber = true
o.showmode = false
o.showcmd = false
o.showmatch = true
o.compatible = false
o.mouse = 'a'
o.swapfile = false
o.wrap = false
o.linebreak = true
o.spell = true
o.clipboard = 'unnamed'
o.foldenable = true
o.foldlevelstart = 10
o.list = true
o.listchars = {
	tab = '▶ ',
	precedes = '↪',
	extends = '↪',
	space = '•',
	trail = '■',
}
w.foldenable = true
o.foldlevelstart = 10

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


