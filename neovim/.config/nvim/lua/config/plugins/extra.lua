return {
  {
    -- TODO: remove popup.nvim
    'nvim-lua/popup.nvim',
    enabled = false,
    lazy = true,
  },
  {
    -- TODO: remove vim-checkbox
    'jkramer/vim-checkbox',
    keys = '<leader>tt',
    enabled = false
  },
  {
    'godlygeek/tabular',
    keys = '<leader>a',
    cmd = 'Tabularize',
  },
}
