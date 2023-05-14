local success, notify = pcall(require, 'notify')
if not success then return end
local colorsLoaded, colors = pcall(require, 'config/colors')
if not colorsLoaded then return end

-- set nvim-notify as default notify function for other plugins
vim.notify = notify

vim.opt.termguicolors = true

-- hightlights
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
