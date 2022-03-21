local status_ok, alpha = pcall(require, 'alpha')
if not status_ok then return end
local dashboard = require 'alpha.themes.dashboard'

dashboard.section.buttons.val = {
  dashboard.button("e", "📃  New file", ":enew<CR>"),
	dashboard.button("f", "🔍  Find file", ":Telescope find_files<CR>"),
	dashboard.button("v", "💼  Vim Options", ":Telescope vim_options<CR>"),
	dashboard.button("r", "🚀  Recent", ":Telescope oldfiles<CR>"),
	dashboard.button("s", "🔧  Settings", ":e $MYVIMRC | :cd %:p:h | split . | wincmd k | pwd<CR>"),
	dashboard.button("q", "❌  Quit", ":qa<CR>"),
}

-- get fortune footer
local handle = io.popen('fortune')
local fortune = handle:read("*a")
handle:close()
dashboard.section.footer.val = fortune

dashboard.config = {
  layout = {
    {
      type = "padding",
      val = 2
    },
    dashboard.section.header,
    {
      type = "padding",
      val = 2
    },
    dashboard.section.buttons,
    {
      type = "padding",
      val = 3
    },
    dashboard.section.footer,
  },
  opts = {
    margin = 5,
    noautocmd = true,
  },
}

dashboard.section.header.val = require('utils/ascii_art')

alpha.setup(dashboard.config)
