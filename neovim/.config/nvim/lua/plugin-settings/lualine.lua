local colors = require('theme').colors
local theme = {
  normal = {
    a = { bg = colors.bright_aqua,   fg = colors.black, gui = 'bold', },
    b = { bg = colors.black,         fg = colors.white, },
    c = { bg = colors.grey0,         fg = colors.grey4, }
  },

  insert = {
    a = { bg = colors.bright_blue,   fg = colors.black, gui = 'bold', },
    b = { bg = colors.black,         fg = colors.white, },
    c = { bg = colors.grey0,         fg = colors.grey4, }
  },

  visual = {
    a = { bg = colors.bright_yellow, fg = colors.black, gui = 'bold', },
    b = { bg = colors.black,         fg = colors.white, },
    c = { bg = colors.grey0,         fg = colors.grey4, }
  },

  replace = {
    a = { bg = colors.bright_red,    fg = colors.black, gui = 'bold', },
    b = { bg = colors.black,         fg = colors.white, },
    c = { bg = colors.grey0,         fg = colors.grey4, }
  },

  command = {
    a = { bg = colors.bright_orange, fg = colors.black, gui = 'bold', },
    b = { bg = colors.black,         fg = colors.white, },
    c = { bg = colors.grey0,         fg = colors.grey4, }
  },

  inactive = {
    a = { bg = colors.grey3,         fg = colors.black, gui = 'bold', },
    b = { bg = colors.black,         fg = colors.grey3, },
    c = { bg = colors.grey0,         fg = colors.grey4, }
  },

  terminal = {
    a = { bg = colors.bright_purple, fg = colors.black, gui = 'bold', },
    b = { bg = colors.black,         fg = colors.white, },
    c = { bg = colors.grey0,         fg = colors.grey4, }
  },
}

local success, lualine = pcall(require, 'lualine')
if not success then return end

local function allowAtOrAboveVersion (version)
  local vimVersion = vim.version();
  local fullVersion = tonumber(vimVersion.major .. '.' .. vimVersion.minor);
  return fullVersion >= tonumber(version);
end

local function inactiveText() return [[INACTIVE]] end

lualine.setup {
  options = {
    globalstatus = allowAtOrAboveVersion('0.7'),
    theme = theme,
    -- section_separators = { '', '' },
    -- section_separators = { '', '' },
    -- section_separators = { '▌', '▐' },
    section_separators = { '', '' },
    component_separators = { '•', '•' },
    -- component_separators = { ' ', ' ' },
    icons_enabled = true,
    disabled_filetypes = { 'alpha', 'NvimTree' },
  },
  sections = {
    lualine_a = {
      {
        'mode',
        upper = true,
      },
    },
    lualine_b = {
      {
        'diff',
        color_added = colors.green,
        color_modified = colors.cyan,
        color_removed = colors.red
      },
    },
    lualine_c = {
      {
        'filename',
        file_status = true,
        path = 1,
      },
    },
    lualine_x = {
      {
        'diagnostics',
        sources = { 'nvim_lsp', },
        symbols = { error = '●', warn = '●', info = '●' },
        -- symbols = { error = '●', warn = '●', info = '●', },
        color_error = colors.red,
        color_warn = colors.yellow,
        color_info = colors.blue
      },
      'encoding',
      'fileformat',
      'filetype'
    },
    lualine_y = { 'progress' },
    lualine_z = { 'location'  },
  },
  inactive_sections = {
    lualine_a = { inactiveText },
    lualine_b = { 'filename' },
    lualine_c = { },
    lualine_x = { },
    lualine_y = { },
    lualine_z = { 'location' },
  },
  extensions = { 'fzf' }
}

