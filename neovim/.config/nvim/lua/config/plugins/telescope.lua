return {
  {
    'nvim-telescope/telescope.nvim',
    dependencies = {
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = "make",
      },
      'nvim-lua/plenary.nvim',
    },
    keys = {
      {
        '<C-p>',
        '<CMD>Telescope find_files prompt_prefix=\\ 🔍\\ <CR>',
        desc = "Search files in cwd",
      },
      {
        '<leader>bb',
        '<CMD>Telescope buffers prompt_prefix=\\ 🔍\\ <CR>',
        desc = "Show buffers",
      },
      {
        '<leader>br',
        '<CMD>Telescope git_branches prompt_prefix=\\ \\ <CR>',
        desc = "Show git branches",
      },
      {
        '<leader>fgg',
        '<CMD>Telescope live_grep prompt_prefix=\\ 🔍\\ <CR>',
        desc = "Telescope live grep: search cwd with regex",
      },
      {
        '<leader>fgf',
        '<CMD>Telescope grep_string prompt_prefix=\\ 🔍\\ <CR>',
        desc = "Telescope grep string: search string under cursor with regex",
      },
      {
        '<leader>gr',
        '<CMD>lua require(\'telescope.builtin\').lsp_references(require(\'telescope.themes\').get_ivy({}))<CR>',
        desc = "Go to LSP references",
      },
      {
        '<leader>fh',
        '<CMD>Telescope help_tags prompt_prefix=\\ 🆘\\ <CR>',
        desc = "Show help topics",
      },
      {
        '<leader>rc',
        '<CMD>Telescope oldfiles prompt_prefix=\\ ⏰\\  prompt_title=Recent\\ Files<CR>',
        desc = "Show recent files",
      },
      {
        '<leader>rr',
        '<CMD>Telescope resume prompt_prefix=\\ ⏰\\ <CR>',
        desc = "Resume last Telescope session",
      },
      {
        '<leader>ss',
        '<CMD>Telescope spell_suggest prompt_prefix=\\ ✅\\ <CR>',
        desc = "Show spell suggestions",
      },
      {
        '<leader>v<C-p>',
        ':lua require\'telescope.builtin\'.find_files({ cwd = \'~/dotfiles/neovim/.config/nvim\' })<cr>',
        desc = "Open file picker for neovim settings",
      },
      {
        '<leader>vfg',
        ':lua require\'telescope.builtin\'.live_grep({ cwd = \'~/dotfiles/neovim/.config/nvim\' })<cr>',
        desc = "Open live grep for neovim settings",
      },
      {
        '<leader>pr',
        ':lua require\'telescope.builtin\'.find_files({ cwd = \'~/dotfiles\' })<cr>',
        desc = "Open project directory",
      },
    },
    lazy = true,
    cmd = "Telescope",
    opts = function()
      local border_loaded, b = pcall(require, 'config/utils/border')
      if not border_loaded then return end
      return {
        defaults = {
          layout_config = {
            vertical = { width = 0.9 },
            horizontal = { width = 0.9 },
          },
          borderchars = b.borderchars,
        },
        pickers = {
          find_files = {
            find_command = {
              "rg",
              "--hidden",         -- include hidden files
              "--glob", "!.git/", -- don't include .git directory
              "--glob", "!packages/deprecated/",
              "--files",          -- include only files
            },
          },
          live_grep = {
            additional_args = {
              "--hidden",         -- include hidden files
              "--glob", "!.git/", -- don't include .git directory
              "--glob", "!packages/deprecated/",
              "--glob", "!yarn.lock",
            },
          },
        },
      }
    end,
  },
}
