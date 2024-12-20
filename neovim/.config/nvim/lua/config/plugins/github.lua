local colorsFound, colors = pcall(require, 'config/colors')

if not colorsFound then
  vim.notify('please generate colors file using the colorscheme script')
  return
end

return {
  {
    'pwntester/octo.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
      'nvim-tree/nvim-web-devicons',
    },
    opts = {
      colors = {
        white = colors.white,
        grey = colors.grey0,
        black = colors.black,
        red = colors.bright_red,
        dark_red = colors.neutral_red,
        green = colors.bright_green,
        dark_green = colors.neutral_green,
        yellow = colors.bright_yellow,
        dark_yellow = colors.neutral_yellow,
        blue = colors.bright_blue,
        dark_blue = colors.neutral_blue,
        purple = colors.bright_purple,
      },
    },
  },
}
