local success, notify = pcall(require, 'notify')
if not success then return end
local colors = require('theme').colors

-- set nvim-notify as default notify function for other plugins
vim.notify = notify

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
vim.cmd('highlight link NotifyERRORBody Normal')
vim.cmd('highlight link NotifyWARNBody  Normal')
vim.cmd('highlight link NotifyINFOBody  Normal')
vim.cmd('highlight link NotifyDEBUGBody Normal')
vim.cmd('highlight link NotifyTRACEBody Normal')
