local success, telescope = pcall(require, 'telescope')
if not success then return end

telescope.setup({
  defaults = {
    layout_config = {
      vertical = { width = 0.9 },
      horizontal = { width = 0.9 },
      -- other layout configuration here
    },
    -- other defaults configuration here
  },
  -- other configuration values here
})

-- keymaps
local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

keymap('n', '<C-p>', ':Telescope find_files find_command=rg,--hidden,--files prompt_prefix=\\ 🔍\\ <CR>', opts)
keymap('n', '<leader>ff', ':Telescope git_files prompt_prefix=\\ 🔍\\ <CR>', opts)
keymap('n', '<leader>fg', ':Telescope live_grep prompt_prefix=\\ 🔍\\ <CR>', opts)
keymap('n', '<leader>b', ':Telescope buffers prompt_prefix=\\ 🔍\\ <CR>', opts)
keymap('n', '<leader>h', ':Telescope help_tags prompt_prefix=\\ 🔍\\ <CR>', opts)
keymap('n', '<leader>s', ':Telescope spell_suggest prompt_prefix=\\ ✅\\ <CR>', opts)
keymap('n', '<leader>rc', ':Telescope oldfiles prompt_prefix=\\ ⏰\\ <CR>', opts)
keymap('n', '<leader>gr', ':lua require(\'telescope.builtin\').lsp_references(require(\'telescope.themes\').get_ivy({}))<CR><ESC>', opts)
keymap('n', '<leader>rr', ':Telescope resume prompt_prefix=\\ ♦️\\ <CR>', opts)

-- custom pickers

-- open file picker for neovim settings
keymap(
  'n',
  '<leader><C-p>',
  ':lua require\'telescope.builtin\'.find_files({ cwd = \'~/.config/nvim\' })<cr>',
  opts
)
