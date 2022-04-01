local success, zenmode = pcall(require, 'zen-mode')
if not success then return end

zenmode.setup {
  window = {
    backdrop = 0.95, -- shade the backdrop of the Zen window. Set to 1 to keep the same as Normal
    -- height and width can be:
    -- * an absolute number of cells when > 1
    -- * a percentage of the width / height of the editor when <= 1
    -- * a function that returns the width or the height
    width = 80, -- width of the Zen window
    height = 1, -- height of the Zen window
    -- by default, no options are changed for the Zen window
    -- uncomment any of the options below, or add other vim.wo options you want to apply
    options = {
      signcolumn = 'no', -- disable/enable signcolumn
      number = false, -- disable/enable number column
      relativenumber = false, -- disable/enable relative numbers
      cursorline = false, -- disable/enable cursorline
      cursorcolumn = false, -- disable/enable cursor column
      foldcolumn = '0', -- disable/enable fold column
      list = false, -- disable/enable whitespace characters
    },
  },
  plugins = {
    -- disable some global vim options (vim.o...)
    options = {
      enabled = true,
      ruler = false, -- disables the ruler text in the cmd line area
      showcmd = false, -- disables the command in the last line of the screen
    },
    -- twilight = { enabled = true }, -- enable to start Twilight when zen mode opens
    gitsigns = { enabled = false }, -- disables/enables git signs
    tmux = { enabled = true }, -- disables the tmux statusline
  },
  -- callback where you can add custom code when the Zen window opens
  -- on_open = function(win) end,
  -- callback where you can add custom code when the Zen window closes
  -- on_close = function() end,
}

-- keybindings
local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- toggle zenmode
keymap('n', '<leader>x', ':ZenMode<CR>', opts)

