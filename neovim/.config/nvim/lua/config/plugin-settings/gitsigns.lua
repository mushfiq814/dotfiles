local success, gitsigns = pcall(require, 'gitsigns')
if not success then return end
local border_loaded, borders = pcall(require, 'config/utils/border')
if not border_loaded then borders = "single" end

gitsigns.setup {
  signs = {
    add          = { hl = 'GitSignsAdd'   , text = '▌', numhl='GitSignsAdd'   , linehl='GitSignsAdd'    },
    change       = { hl = 'GitSignsChange', text = '▌', numhl='GitSignsChange', linehl='GitSignsChange' },
    delete       = { hl = 'GitSignsDelete', text = '▌', numhl='GitSignsDelete', linehl='GitSignsDelete' },
    topdelete    = { hl = 'GitSignsDelete', text = '⫧', numhl='GitSignsDelete', linehl='GitSignsDelete' },
    changedelete = { hl = 'GitSignsChange', text = '▶', numhl='GitSignsChange', linehl='GitSignsChange' },
    untracked    = { hl = 'GitSignsAdd'   , text = '▌', numhl='GitSignsAdd'   , linehl='GitSignsAddLn'  },
  },
  signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`
  numhl      = true,  -- Toggle with `:Gitsigns toggle_numhl`
  linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
  word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`
  watch_gitdir = {
    interval = 1000,
    follow_files = true
  },
  attach_to_untracked = false,
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
    border = {
      { borders[1], "FloatBorder" },
      { borders[2], "FloatBorder" },
      { borders[3], "FloatBorder" },
      { borders[6], "FloatBorder" },
      { borders[9], "FloatBorder" },
      { borders[8], "FloatBorder" },
      { borders[7], "FloatBorder" },
      { borders[4], "FloatBorder" },
    },
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

keymap('n', '<leader>gb', ':lua require("gitsigns").blame_line({ full = true })<CR>', opts)
keymap('n', '<leader>gh', ':Gitsigns preview_hunk<CR>', opts)
keymap('n', '[c', ':Gitsigns prev_hunk<CR>', opts)
keymap('n', ']c', ':Gitsigns next_hunk<CR>', opts)
