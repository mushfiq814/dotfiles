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
  extensions = {
    media_files = {
      filetypes = {"png", "jpg", "pdf", "jpeg"},
      find_cmd = "rg"
    }
  }
})

-- keymaps
local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

keymap('n', '<C-p>', ':Telescope find_files find_command=rg,--hidden,--files prompt_prefix=\\ 🔍\\ <CR>', opts)
keymap('n', '<leader>b',  ':Telescope buffers prompt_prefix=\\ 🔍\\ <CR>', opts)
keymap('n', '<leader>br', ':Telescope git_branches prompt_prefix=\\ \\ <CR>', opts)
keymap('n', '<leader>fg', ':Telescope live_grep prompt_prefix=\\ 🔍\\ <CR>', opts)
keymap('n', '<leader>gr', ':lua require(\'telescope.builtin\').lsp_references(require(\'telescope.themes\').get_ivy({}))<CR>', opts)
keymap('n', '<leader>h',  ':Telescope help_tags prompt_prefix=\\ 🆘\\ <CR>', opts)
keymap('n', '<leader>rc', ':Telescope oldfiles prompt_prefix=\\ ⏰\\ <CR>', opts)
keymap('n', '<leader>rr', ':Telescope resume prompt_prefix=\\ ⏰\\ <CR>', opts)
keymap('n', '<leader>ss', ':Telescope spell_suggest prompt_prefix=\\ ✅\\ <CR>', opts)

-- custom pickers

-- open file picker for neovim settings
keymap(
  'n',
  '<leader>v<C-p>',
  ':lua require\'telescope.builtin\'.find_files({ cwd = \'~/.config/nvim\' })<cr>',
  opts
)
-- open live grep for neovim settings
keymap(
  'n',
  '<leader>vfg',
  ':lua require\'telescope.builtin\'.live_grep({ cwd = \'~/.config/nvim\' })<cr>',
  opts
)
