return {
  {
    'lewis6991/gitsigns.nvim',
    event = "VeryLazy",
    opts = function()
      local border_loaded, b = pcall(require, 'config/utils/border')
      if not border_loaded then b = "single" end

      -- Key bindings
      local keymap = vim.api.nvim_set_keymap
      local opts = { noremap = true, silent = true }

      keymap('n', '<leader>gb', ':lua require("gitsigns").blame_line({ full = true })<CR>', opts)
      keymap('n', '<leader>gh', ':Gitsigns preview_hunk<CR>', opts)
      keymap('n', '[c', ':Gitsigns prev_hunk<CR>', opts)
      keymap('n', ']c', ':Gitsigns next_hunk<CR>', opts)

      return {
        signs = {
          add = { text = '▌' },
          change = { text = '▌' },
          delete = { text = '_' },
          topdelete = { text = '‾' },
          changedelete = { text = '▶' },
          untracked = { text = '┆' },
        },
        signs_staged = {
          add = { text = '▌' },
          change = { text = '▌' },
          delete = { text = '_' },
          topdelete = { text = '‾' },
          changedelete = { text = '▶' },
          untracked = { text = '┆' },
        },
        signs_staged_enable = true,
        signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
        numhl = true,      -- Toggle with `:Gitsigns toggle_numhl`
        linehl = false,    -- Toggle with `:Gitsigns toggle_linehl`
        word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
        watch_gitdir = {
          interval = 1000,
          follow_files = true
        },
        auto_attach = true,
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
          border = b.borders,
          style = 'minimal',
          relative = 'cursor',
          row = 0,
          col = 1
        },
      }
    end,
  },
}
