local success, gitsigns = pcall(require, 'gitsigns')
if not success then return end
local colors = require('theme').colors

-- color highlights
vim.cmd('hi! GitSignsAdd guifg='          .. colors.bright_green .. ' guibg=#')
vim.cmd('hi! GitSignsChange guifg='       .. colors.bright_aqua  .. ' guibg=#')
vim.cmd('hi! GitSignsDelete guifg='       .. colors.bright_red   .. ' guibg=#')
vim.cmd('hi! GitSignsChangeDelete guifg=' .. colors.bright_aqua  .. ' guibg=' .. colors.bright_red)

gitsigns.setup {
  signs = {
    add          = { hl = 'GitSignsAdd'   , text = '▌', numhl='GitSignsAdd'   , linehl='GitSignsAdd'    },
    change       = { hl = 'GitSignsChange', text = '▌', numhl='GitSignsChange', linehl='GitSignsChange' },
    delete       = { hl = 'GitSignsDelete', text = '▌', numhl='GitSignsDelete', linehl='GitSignsDelete' },
    topdelete    = { hl = 'GitSignsDelete', text = '⫧', numhl='GitSignsDelete', linehl='GitSignsDelete' },
    changedelete = { hl = 'GitSignsChange', text = '▶', numhl='GitSignsChange', linehl='GitSignsChange' },
  },
  signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`
  numhl      = true,  -- Toggle with `:Gitsigns toggle_numhl`
  linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
  word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`
  watch_gitdir = {
    interval = 1000,
    follow_files = true
  },
  attach_to_untracked = true,
  current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
    delay = 500,
    ignore_whitespace = true,
  },
  current_line_blame_formatter = '● <author>, <author_time:%Y-%m-%d> - <summary>',
  sign_priority = 6,
  update_debounce = 100,
  status_formatter = nil, -- Use default
  max_file_length = 40000,
  preview_config = {
    -- Options passed to nvim_open_win
    border = 'single',
    style = 'minimal',
    relative = 'cursor',
    row = 0,
    col = 1
  },
  yadm = {
    enable = false
  },
}

-- Key bindings
local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

keymap('n', '<leader>gb', ':Gitsigns blame_line { full = true }<CR>', opts)
keymap('n', '<leader>gh', ':Gitsigns preview_hunk<CR>', opts)
keymap('n', '[c', ':Gitsigns prev_hunk<CR>', opts)
keymap('n', ']c', ':Gitsigns next_hunk<CR>', opts)