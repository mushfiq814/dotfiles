return {
  {
    -- TODO: remove popup.nvim
    'nvim-lua/popup.nvim',
    enabled = false,
    lazy = true,
  },
  {
    'jkramer/vim-checkbox',
    keys = '<leader>tt'
  },
  {
    'godlygeek/tabular',
    keys = '<leader>a',
    cmd = 'Tabularize',
  },
}
