return {
  {
    -- lazy load only during specified treesitter parser filetypes are loaded
    'nvim-treesitter/nvim-treesitter',
    event = 'VeryLazy',
    config = function()
      local success, nvim_treesitter = pcall(require, 'nvim-treesitter.configs')
      if not success then return end

      vim.wo.foldmethod = 'expr'
      vim.wo.foldexpr = 'nvim_treesitter#foldexpr()'
      vim.wo.foldenable = false

      nvim_treesitter.setup {
        ensure_installed = {
          'typescript',
          'javascript',
          'lua',
          'query',
          'jsdoc',
          'json',
          'jsonc',
          'markdown',
          'markdown_inline',
          'bash',
          'yaml',
          'comment',
          'diff',
          'go',
          'gomod',
          'gosum',
          'python',
          'vimdoc',
          'http',
          'html',
        },
        highlight = {
          enable = true,
        },
        incremental_selection = { enable = true },
        indent = { enable = true },
      }
      vim.treesitter.language.register('markdown', 'octo')
    end
  },
  {
    'nvim-treesitter/playground',
    cmd = { 'TSPlaygroundToggle', 'TSHighlightCapturesUnderCursor' },
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
    },
  },
}
