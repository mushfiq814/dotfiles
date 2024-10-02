return {
  {
    "vhyrro/luarocks.nvim",
    priority = 1001, -- this plugin needs to run before anything else
    opts = {
      rocks = { "magick" },
    },
  },
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
  {
    'rcarriga/nvim-notify',
    keys = {
      { "<leader>dd", "<CMD>lua require(\"notify\").dismiss()<CR>", desc = "Dismiss notifcation" },
    },
    event = 'VeryLazy',
    opts = function()
      local border_loaded, b = pcall(require, 'config/utils/border')
      if not border_loaded then return end

      -- set nvim-notify as default notify function for other plugins
      vim.notify = require("notify")
      vim.opt.termguicolors = true

      return {
        fps = 60,
        stages = "fade",
        render = "compact",
        on_open = function(win)
          if vim.api.nvim_win_is_valid(win) then
            vim.api.nvim_win_set_config(win, {
              border = b.borders,
            })
          end
        end,
      }
    end
  },
  {
    'lukas-reineke/indent-blankline.nvim',
    enabled = false,
    main = "ibl",
    event = 'VeryLazy',
    opts = function()
      vim.opt.list = true
      vim.opt.termguicolors = true

      return {
        debounce = 100,
        -- Special Characters: '│' '█' '▏'
        indent = { char = "▏", highlight = { "Whitespace", "NonText" }, },
        whitespace = { highlight = { "Whitespace", "NonText" } },
        exclude = {
          filetypes = { "help", "alpha", "dashboard", "Trouble", "lazy" },
        },
      }
    end
  },
  {
    'folke/twilight.nvim',
    enabled = false,
    opts = {
      {
        dimming = {
          alpha = 0.50, -- amount of dimming
          -- we try to get the foreground from the highlight groups or fallback color
          color = { "Normal", "#ffffff" },
          term_bg = "#dbdbdb", -- if guibg=NONE, this will be used to calculate text color
          inactive = false, -- when true, other windows will be fully dimmed (unless they contain the same buffer)
        },
        context = 10,    -- amount of lines we will try to show around the current line
        treesitter = true, -- use treesitter when available for the filetype
        -- treesitter is used to automatically expand the visible text,
        -- but you can further control the types of nodes that should always be fully expanded
        expand = { -- for treesitter, we we always try to expand to the top-most ancestor with these types
          "function",
          "method",
          "table",
          "if_statement",
        },
        exclude = {}, -- exclude these filetypes
      }
    }
  },
  {
    'folke/zen-mode.nvim',
    keys = {
      { "<leader>x", "<CMD>ZenMode<CR>", desc = "Toggle ZenMode" },
    },
    opts = {
      window = {
        backdrop = 0.95, -- shade the backdrop of the Zen window. Set to 1 to keep the same as Normal
        -- height and width can be:
        -- * an absolute number of cells when > 1
        -- * a percentage of the width / height of the editor when <= 1
        -- * a function that returns the width or the height
        width = 80, -- width of the Zen window
        height = 1, -- height of the Zen window
        -- by default, no options are changed for the Zen window
        -- uncomment any of the options below, or add other vim.wo options you want to apply
        options = {
          signcolumn = 'no',      -- disable/enable signcolumn
          number = false,         -- disable/enable number column
          relativenumber = false, -- disable/enable relative numbers
          cursorline = false,     -- disable/enable cursorline
          cursorcolumn = false,   -- disable/enable cursor column
          foldcolumn = '0',       -- disable/enable fold column
          list = false,           -- disable/enable whitespace characters
          wrap = true,            -- disable/enable line wrap
        },
      },
      plugins = {
        -- disable some global vim options (vim.o...)
        options = {
          enabled = true,
          ruler = false,                -- disables the ruler text in the cmd line area
          showcmd = false,              -- disables the command in the last line of the screen
        },
        gitsigns = { enabled = false }, -- disables/enables git signs
        tmux = { enabled = true },      -- disables the tmux statusline
      },
      -- callback where you can add custom code when the Zen window opens
      -- on_open = function(win) end,
      -- callback where you can add custom code when the Zen window closes
      -- on_close = function() end,
    },
  },
  {
    -- lazy load only after filetypes defined inside config for this
    'NvChad/nvim-colorizer.lua',
    event = 'VeryLazy',
    opts = {
      filetypes = {
        "markdown",
        "shell",
        "sh",
        "json",
        "jsonc",
        "javascript",
        "typescript",
        "javascriptreact",
        "css",
        "html",
        "lua",
      },
      user_default_options = {
        RGB = true,           -- #RGB hex codes
        RRGGBB = true,        -- #RRGGBB hex codes
        names = false,        -- "Name" codes like Blue or blue
        RRGGBBAA = false,     -- #RRGGBBAA hex codes
        AARRGGBB = true,      -- 0xAARRGGBB hex codes
        rgb_fn = true,        -- CSS rgb() and rgba() functions
        hsl_fn = false,       -- CSS hsl() and hsla() functions
        css = false,          -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
        css_fn = false,       -- Enable all CSS *functions*: rgb_fn, hsl_fn
        -- Available modes for `mode`: foreground, background,  virtualtext
        mode = "virtualtext", -- Set the display mode.
        virtualtext = "",
        -- Available methods are false / true / "normal" / "lsp" / "both"
        -- True is same as normal
        tailwind = false,                              -- Enable tailwind colors
        -- parsers can contain values used in |user_default_options|
        sass = { enable = false, parsers = { css }, }, -- Enable sass colors
      },
      -- all the sub-options of filetypes apply to buftypes
      buftypes = {},
    },
  },
  {
    'edluffy/hologram.nvim',
    lazy = true,
    opts = function()
      return {
        auto_display = true
      }
    end
  },
  {
    '3rd/image.nvim',
    lazy = true,
    event = 'VeryLazy',
    dependencies = { "luarocks.nvim" },
    opts = {
      backend = 'kitty',
      integrations = {
        markdown = {
          enabled = true,
          clear_in_insert_mode = false,
          download_remote_images = true,
          only_render_image_at_cursor = true,
          filetypes = { "markdown", "vimwiki" }, -- markdown extensions (ie. quarto) can go here
        },
        neorg = {
          enabled = false,
        },
        html = {
          enabled = false,
        },
        css = {
          enabled = false,
        },
      },
      max_width = nil,
      max_height = nil,
      max_width_window_percentage = nil,
      max_height_window_percentage = 50,
      window_overlap_clear_enabled = false,                                               -- toggles images when windows are overlapped
      window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
      editor_only_render_when_focused = false,                                            -- auto show/hide images when the editor gains/looses focus
      tmux_show_only_in_active_window = false,                                            -- auto show/hide images in the correct Tmux window (needs visual-activity off)
      hijack_file_patterns = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp", "*.avif" }, -- render image files as images when opened
    }
  },
  {
    'goolord/alpha-nvim',
    enabled = false,
    event = 'VimEnter',
    opts = function()
      local dashboard = require 'alpha.themes.dashboard'

      dashboard.section.buttons.val = {
        dashboard.button("i", "  New file", ":enew<CR>"),
        dashboard.button("f", "  Find file", ":Telescope find_files<CR>"),
        dashboard.button("v", "הּ  Vim Options", ":Telescope vim_options<CR>"),
        dashboard.button("r", "  Recent", ":Telescope oldfiles<CR>"),
        dashboard.button("s", "  Settings", ":e $MYVIMRC | :cd %:p:h | split . | wincmd k | pwd<CR>"),
        dashboard.button("q", "  Quit", ":qa<CR>"),
      }

      local function padding(value)
        return {
          type = "padding",
          val = value,
        }
      end

      dashboard.config = {
        layout = {
          padding(2),
          dashboard.section.header,
          padding(2),
          dashboard.section.buttons,
          padding(3),
          dashboard.section.footer,
        },
        opts = {
          margin = 5,
          noautocmd = true,
        },
      }

      dashboard.section.header.val = require('config/utils/ascii_art')
      return dashboard.config
    end
  },
  {
    'nvimdev/dashboard-nvim',
    event = 'VimEnter',
    opts = function()
      vim.cmd [[ highlight link DashboardHeader ColorYellow ]]
      vim.cmd [[ highlight link DashboardProjectTitle ColorBlue ]]
      vim.cmd [[ highlight link DashboardMruTitle ColorBlue ]]

      local logo = require('config/utils/ascii_art')
      table.insert(logo, "")
      table.insert(logo, "")

      return {
        theme = 'hyper',
        config = {
          hide = {
            statusline = true,
            tabline = true,
            winbar = true,
          },
          header = logo,
          project = {
            enable = true,
            limit = 10,
            icon = " ",
            label = "Recent Projects",
            action = "edit ",
          },
          packages = {
            enable = true,
          },
          mru = {
            limit = 10,
            icon = " ",
            label = "Recent Files",
          },
          shortcut = {
            {
              desc = 'Update Packages',
              icon = '  ',
              group = 'Include',
              action = 'Lazy sync',
              key = 'u',
            },
            {
              icon = ' ',
              desc = 'dotfiles',
              group = 'Constant',
              action =
              [[ lua require("telescope.builtin").find_files({ cwd = "~/dotfiles", prompt_prefix = " ", prompt_title = "Dotfiles Search" }) ]],
              key = 'd',
            },
          },
          footer = {},
        },
      }
    end,
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    }
  },
}
