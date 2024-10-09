return {
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
