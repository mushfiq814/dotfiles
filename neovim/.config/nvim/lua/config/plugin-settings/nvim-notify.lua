local success, notify = pcall(require, 'notify')
if not success then return end
local colorsLoaded, colors = pcall(require, 'config/colors')
if not colorsLoaded then return end

-- set nvim-notify as default notify function for other plugins
vim.notify = notify

vim.opt.termguicolors = true

-- hightlights
vim.cmd('highlight NotifyERRORBorder guifg=' .. colors.faded_red)
vim.cmd('highlight NotifyWARNBorder  guifg=' .. colors.faded_orange)
vim.cmd('highlight NotifyINFOBorder  guifg=' .. colors.faded_aqua)
vim.cmd('highlight NotifyDEBUGBorder guifg=' .. colors.grey2)
vim.cmd('highlight NotifyTRACEBorder guifg=' .. colors.neutral_purple)
vim.cmd('highlight NotifyERRORIcon   guifg=' .. colors.bright_purple)
vim.cmd('highlight NotifyWARNIcon    guifg=' .. colors.bright_orange)
vim.cmd('highlight NotifyINFOIcon    guifg=' .. colors.bright_green)
vim.cmd('highlight NotifyDEBUGIcon   guifg=' .. colors.grey2)
vim.cmd('highlight NotifyTRACEIcon   guifg=' .. colors.bright_purple)
vim.cmd('highlight NotifyERRORTitle  guifg=' .. colors.neutral_purple)
vim.cmd('highlight NotifyWARNTitle   guifg=' .. colors.bright_orange)
vim.cmd('highlight NotifyINFOTitle   guifg=' .. colors.bright_green)
vim.cmd('highlight NotifyDEBUGTitle  guifg=' .. colors.grey2)
vim.cmd('highlight NotifyTRACETitle  guifg=' .. colors.bright_purple)

vim.cmd('highlight link NotifyERRORBody' .. ' Normal')
vim.cmd('highlight link NotifyWARNBody' .. ' Normal')
vim.cmd('highlight link NotifyINFOBody' .. ' Normal')
vim.cmd('highlight link NotifyDEBUGBody' .. ' Normal')
vim.cmd('highlight link NotifyTRACEBody' .. ' Normal')

notify.setup({
  background_colour = "#000000",
  fps = 60,
  stages = "fade",
})

-- keybindings
-- dismiss notifications
vim.api.nvim_set_keymap(
  'n',
  '<leader>dd',
  ':lua require("notify").dismiss()<CR>',
  { noremap = true, silent = true }
)
