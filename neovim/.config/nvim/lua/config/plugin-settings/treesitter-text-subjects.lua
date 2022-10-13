local success, nvim_treesitter = pcall(require, 'nvim-treesitter.configs')
if not success then return end

nvim_treesitter.setup {
  textsubjects = {
    enable = true,
    prev_selection = ',', -- (Optional) keymap to select the previous selection
    keymaps = {
      ['.'] = 'textsubjects-smart',
      [';'] = 'textsubjects-container-outer',
      ['i;'] = 'textsubjects-container-inner',
    },
  },
}
