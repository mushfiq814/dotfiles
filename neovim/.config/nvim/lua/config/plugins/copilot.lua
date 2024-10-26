return {
  {
    'github/copilot.vim',
    enabled = true,
    keys = {
      {
        '<C-J>',
        'copilot#Accept("\\<CR>")',
        mode = 'i',
        desc = "Accept the next line of the current suggestion.",
        expr = true,
        replace_keycodes = false
      },
      -- {
      --   '<C-]>',
      --   '<Plug>(copilot-dismiss)',
      --   mode = 'i',
      --   desc = "Dismiss the current suggestion.",
      -- },
      {
        '<C-l>',
        '<Plug>(copilot-next)',
        mode = 'i',
        desc = "Cycle to the next suggestion, if one is available.",
      },
      {
        '<C-h>',
        '<Plug>(copilot-previous)',
        mode = 'i',
        desc = "Cycle to the previous suggestion.",
      },
      -- {
      --   '<C-h>',
      --   '<Plug>(copilot-suggest)',
      --   mode = 'i',
      --   desc = "Explicitly request a suggestion, even if Copilot is disabled.",
      -- },
      {
        '<C-Right>',
        '<Plug>(copilot-accept-word)',
        mode = 'i',
        desc = "Accept the next word of the current suggestion.",
      },
      -- {
      --   '<C-Left>',
      --   '<Plug>(copilot-accept-line)',
      --   mode = 'i',
      --   desc = "Accept the next line of the current suggestion.",
      -- },
    },
    config = function()
      vim.g.copilot_no_tab_map = true

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
    enabled = true,
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
