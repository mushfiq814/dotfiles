return {
  {
    -- TODO: find lua/lighter alternative
    'tpope/vim-fugitive',
    cmd = { 'G', 'Gvdiffsplit' },
  },
  {
    'numToStr/Comment.nvim',
    opts = function()
      return {
        ---Add a space b/w comment and the line
        padding = true,
        ---Whether the cursor should stay at its position
        sticky = true,
        ---Lines to be ignored while (un)comment
        ignore = nil,
        ---LHS of toggle mappings in NORMAL mode
        toggler = {
          ---Line-comment toggle keymap
          line = 'gcc',
          ---Block-comment toggle keymap
          block = 'gbc',
        },
        ---LHS of operator-pending mappings in NORMAL and VISUAL mode
        opleader = {
          ---Line-comment keymap
          line = 'gc',
          ---Block-comment keymap
          block = 'gb',
        },
        ---LHS of extra mappings
        extra = {
          ---Add comment on the line above
          above = 'gcO',
          ---Add comment on the line below
          below = 'gco',
          ---Add comment at the end of line
          eol = 'gcA',
        },
        ---Enable keybindings
        ---NOTE: If given `false` then the plugin won't create any mappings
        mappings = {
          ---Operator-pending mapping; `gcc` `gbc` `gc[count]{motion}` `gb[count]{motion}`
          basic = true,
          ---Extra mapping; `gco`, `gcO`, `gcA`
          extra = true,
          ---Extended mapping; `g>` `g<` `g>[count]{motion}` `g<[count]{motion}`
          extended = false,
        },
        ---Function to call before (un)comment
        pre_hook = nil,
        ---Function to call after (un)comment
        post_hook = nil,
      }
    end,
    keys = {
      { 'gc', mode = { "n", "v" } },
      { 'gcc', mode = { "n" } },
    }
  },
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
          add = {
            hl = 'GitSignsAdd',
            text = '▌',
            numhl = 'GitSignsAdd',
            linehl = 'GitSignsAdd'
          },
          change = {
            hl = 'GitSignsChange',
            text = '▌',
            numhl = 'GitSignsChange',
            linehl = 'GitSignsChange'
          },
          delete = {
            hl = 'GitSignsDelete',
            text = '▌',
            numhl = 'GitSignsDelete',
            linehl = 'GitSignsDelete'
          },

          topdelete = {
            hl = 'GitSignsDelete',
            text = '⫧',
            numhl = 'GitSignsDelete',
            linehl = 'GitSignsDelete'
          },

          changedelete = {
            hl = 'GitSignsChange',
            text = '▶',
            numhl = 'GitSignsChange',
            linehl = 'GitSignsChange'
          },

          untracked = {
            hl = 'GitSignsAdd',
            text = '▌',
            numhl = 'GitSignsAdd',
            linehl = 'GitSignsAddLn'
          },

        },
        signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
        numhl = true,      -- Toggle with `:Gitsigns toggle_numhl`
        linehl = false,    -- Toggle with `:Gitsigns toggle_linehl`
        word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
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
          border = b.borders,
          style = 'minimal',
          relative = 'cursor',
          row = 0,
          col = 1
        },
        yadm = {
          enable = false
        },
      }
    end,
  },
}
