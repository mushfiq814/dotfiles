local success, notify = pcall(require, 'notify')
if not success then return end

local border_loaded, borders = pcall(require, 'config/utils/border')
if not border_loaded then return end

-- set nvim-notify as default notify function for other plugins
vim.notify = notify

vim.opt.termguicolors = true

-- highlights
notify.setup({
  fps = 60,
  stages = "fade",
  render = "compact",
  on_open = function(win)
    if vim.api.nvim_win_is_valid(win) then
      vim.api.nvim_win_set_config(win, {
        border = {
          borders[1],
          borders[2],
          borders[3],
          borders[6],
          borders[9],
          borders[8],
          borders[7],
          borders[4],
        }
      })
    end
  end,
})

-- keybindings
-- dismiss notifications
vim.api.nvim_set_keymap(
  'n',
  '<leader>dd',
  ':lua require("notify").dismiss()<CR>',
  { noremap = true, silent = true }
)
