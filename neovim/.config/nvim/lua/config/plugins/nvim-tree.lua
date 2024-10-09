return {
  {
    'kyazdani42/nvim-tree.lua',
    dependencies = {
      'kyazdani42/nvim-web-devicons',
    },
    cmd = { 'NvimTreeOpen', 'NvimTreeToggle' },
    keys = {
      { "<C-n>", "<CMD>NvimTreeToggle<CR>",  desc = "Open/Close Nvim Tree View" },
      { "R",     "<CMD>NvimTreeRefresh<CR>", desc = "Refresh Nvim Tree View" },
    },
    opts = function()
      -- icons table
      vim.g.nvim_tree_icons = {
        default = '',
        symlink = '',
        git = {
          unstaged = '✗',
          staged = '✓',
          unmerged = '',
          renamed = '➜',
          untracked = '★',
          deleted = '',
          ignored = '◌'
        },
        folder = {
          arrow_open = '',
          arrow_closed = '',
          default = '',
          open = '',
          empty = '',
          empty_open = '',
          symlink = '',
          symlink_open = '',
        },
        lsp = {
          hint = '',
          info = '',
          warning = '',
          error = '',
        }
      }
      return {
        -- disables netrw completely
        disable_netrw = true,
        -- hijack netrw window on startup
        hijack_netrw = true,
        -- closes neovim automatically when the tree is the last **WINDOW** in the
        -- view
        open_on_tab = false,
        -- hijacks new directory buffers when they are opened.
        hijack_directories = {
          -- enable the feature
          enable = true,
          -- allow to open the tree if it was previously closed
          auto_open = true,
        },
        -- hijack the cursor in the tree to put it at the start of the filename
        hijack_cursor = false,
        -- updates the root directory of the tree on `DirChanged` (when your run
        -- `:cd` usually)
        update_cwd = false,
        -- show lsp diagnostics in the signcolumn
        diagnostics = {
          enable = true,
          icons = {
            hint = "",
            info = "",
            warning = "",
            error = "",
          }
        },
        -- update the focused file on `BufEnter`, un-collapses the folders
        -- recursively until it finds the file
        update_focused_file = {
          -- enables the feature
          enable = true,
          -- update the root directory of the tree to the one of the folder
          -- containing the file if the file is not under the current root directory
          -- only relevant when `update_focused_file.enable` is true
          update_cwd = false,
          -- list of buffer names / filetypes that will not update the cwd if the
          -- file isn't found under the current root directory only relevant when
          -- `update_focused_file.update_cwd` is true and
          -- `update_focused_file.enable` is true
          ignore_list = {}
        },
        -- configuration options for the system open command (`s` in the tree by
        -- default)
        system_open = {
          -- the command to run this, leaving nil should work in most cases
          cmd = nil,
          -- the command arguments as a list
          args = {}
        },

        view = {
          -- width of the window, can be either a number (columns) or a string in
          -- `%`, for left or right side placement
          width = 30,
          -- side of the tree, can be one of 'left' | 'right' | 'top' | 'bottom'
          side = 'left',
        },

        actions = {
          open_file = {
            -- if true the tree will resize itself after opening a file
            resize_window = true,
          },
        },
      }
    end
  },
}
