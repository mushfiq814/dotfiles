local alpha = require 'alpha'
local dashboard = require 'alpha.themes.dashboard'

dashboard.section.buttons.val = {
	dashboard.button("f", "🔍  Find file", ":Telescope find_files<CR>"),
	dashboard.button("v", "💼  Vim Options", ":Telescope vim_options<CR>"),
	dashboard.button("r", "🚀  Recent", ":Telescope oldfiles<CR>"),
	dashboard.button("s", "🔧  Settings", ":e $MYVIMRC | :cd %:p:h | split . | wincmd k | pwd<CR>"),
	dashboard.button("q", "❌  Quit NVIM", ":qa<CR>"),
}

local handle = io.popen('fortune')
local fortune = handle:read("*a")
handle:close()
dashboard.section.footer.val = ' \r \r \r \r' .. fortune

dashboard.config.opts.noautocmd = true

dashboard.section.header.val = require('utils/ascii_art')

alpha.setup(dashboard.config)
