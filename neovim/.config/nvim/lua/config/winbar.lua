local colors_loaded, colors = pcall(require, 'config/colors')
if not colors_loaded then return end
local lightMode = colors.mode == "light"

local function filename()
  local filename = vim.fn.expand("%:t")
  if filename == '' then return '' end
  if vim.bo.modified then
    filename = filename .. " %#winbarFileNameModified# ● %#Normal#"
  end
  return "%#winbarFileName# " .. filename .. " %#Normal#"
end

local function navicTags()
  local navicLoaded, nvim_navic = pcall(require, 'nvim-navic')
  if navicLoaded then
    local current_tag = nvim_navic.get_location()
    if not nvim_navic.is_available() then return '' end
   return " %#winbarTags# > " .. current_tag .. " %#Normal#"
  end
end

function MyWinbar()
  return table.concat({
    filename(),
    navicTags(),
  })
end

vim.o.winbar = "%{%v:lua.MyWinbar()%}"

local color_utils = require('config/color-utils')
local hi = color_utils.highlight

hi.winbarFileName = {
  guifg = colors.black,
  guibg = colors.neutral_purple,
  gui = 'bold',
}
hi.winbarFileNameModified = {
  guifg = colors.black,
  guibg = colors.neutral_aqua,
}
hi.winbarTags = {
  guifg = colors.white,
  guibg = colors.grey1,
}
