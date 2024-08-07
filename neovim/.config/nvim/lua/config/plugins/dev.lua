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
      { 'gc',  mode = { "n", "v" } },
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
  {
    'github/copilot.vim',
    config = function()
      vim.keymap.set('i', '<C-J>', 'copilot#Accept("\\<CR>")', {
        expr = true,
        replace_keycodes = false
      })
      vim.g.copilot_no_tab_map = true
      vim.keymap.set('i', '<C-]>', '<Plug>(copilot-dismiss)')         -- Dismiss the current suggestion.
      vim.keymap.set('i', '<C-i>', '<Plug>(copilot-next)')            -- Cycle to the next suggestion, if one is available.
      vim.keymap.set('i', '<C-u>', '<Plug>(copilot-previous)')        -- Cycle to the previous suggestion.
      vim.keymap.set('i', '<C-h>', '<Plug>(copilot-suggest)')         -- Explicitly request a suggestion, even if Copilot is disabled.
      vim.keymap.set('i', '<C-Right>', '<Plug>(copilot-accept-word)') -- Accept the next word of the current suggestion.
      vim.keymap.set('i', '<C-Left>', '<Plug>(copilot-accept-line)')  -- Accept the next line of the current suggestion.

      -- copilot_workspace_folders
      --   A list of "workspace folders" or project roots that
      --   Copilot may use to improve to improve the quality of
      --   suggestions.
      --
      --   let g:copilot_workspace_folders =
      --          \ ["~/Projects/myproject"]
      --
      --   You can also set b:workspace_folder for an individual
      --   buffer and newly seen values will be added
      --   automatically.

      -- vim.api.nvim_set_hl(0, 'CopilotSuggestion', {
      --   fg = '#555555',
      --   ctermfg = 8,
      --   force = true
      -- })
    end,
  },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    event = "VeryLazy",
    branch = "canary",
    dependencies = {
      { "github/copilot.vim" },
      { "nvim-lua/plenary.nvim" },
    },
    opts = {
      debug = true,
      show_help = "yes",
      model = 'gpt-4', -- GPT model to use, 'gpt-3.5-turbo' or 'gpt-4'
      temperature = 0.1, -- GPT temperature
      question_header = '## Mushfiq ', -- Header to use for user questions
      answer_header = '## Copilot Chat ', -- Header to use for AI answers
      error_header = '## Error ', -- Header to use for errors
      separator = '───', -- Separator to use in chat
      prompts = {
        Explain = {
          prompt = '/COPILOT_EXPLAIN Write an explanation for the active selection as paragraphs of text.',
        },
        Review = {
          prompt = '/COPILOT_REVIEW Review the selected code.',
        },
        Fix = {
          prompt = '/COPILOT_GENERATE There is a problem in this code. Rewrite the code to show it with the bug fixed.',
        },
        Optimize = {
          prompt = '/COPILOT_GENERATE Optimize the selected code to improve performance and readablilty.',
        },
        Docs = {
          prompt = '/COPILOT_GENERATE Please add documentation comment for the selection.',
        },
        Tests = {
          prompt = '/COPILOT_GENERATE Please generate tests for my code.',
        },
        FixDiagnostic = {
          prompt = 'Please assist with the following diagnostic issue in file:',
        },
      },
    },
    config = function(_, opts)
      local chat = require("CopilotChat")
      local select = require("CopilotChat.select")

      -- Override the git prompts message
      local prompt =
      'Write commit message for the change with commitizen convention. Make sure the title has maximum 50 characters and message is wrapped at 72 characters. Wrap the whole message in code block with language gitcommit.'
      opts.prompts.CommitVisual = {
        prompt = prompt,
        selection = select.visual,
      }
      opts.prompts.Commit = {
        prompt = prompt,
        selection = select.gitdiff,
      }
      opts.prompts.CommitStaged = {
        prompt = prompt,
        selection = function(source)
          return select.gitdiff(source, true)
        end,
      }

      chat.setup(opts)
    end,
  },
}
