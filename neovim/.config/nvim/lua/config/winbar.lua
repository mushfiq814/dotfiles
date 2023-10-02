local colors_loaded, colors = pcall(require, 'config/colors')
if not colors_loaded then return end

local function filename()
  local filename_base = vim.fn.expand("%:t")
  if filename_base == '' then filename_base = '[scratch buffer]' end
  if vim.bo.modified then
    filename_base = filename_base .. " %#winbarFileNameModified# ● %#Normal#"
  end
  return "%#winbarFileName# " .. filename_base .. " %#Normal#"
end

local function navicTags()
  local navicLoaded, nvim_navic = pcall(require, 'nvim-navic')
  if navicLoaded then
    local current_tag = nvim_navic.get_location()
    if not nvim_navic.is_available() then return '' end
    return " %#winbarTags# > " .. current_tag .. "%#winbarTags# %#Normal#"
  end
end

function MyWinbar()
  return table.concat({
    filename(),
    navicTags(),
  })
end

vim.o.winbar = "%{%v:lua.MyWinbar()%}"

local color_utils = require('config/utils/color-utils')
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

local function winbarTagHighlight (group, guifg)
  hi[group] = { guibg = colors.grey1, guifg = guifg }
end
local function winbarTagHighlightIcon (group)
  hi[group] = { guibg = colors.grey1, guifg = colors.bright_green }
end

winbarTagHighlight("winbarTags", colors.white)
winbarTagHighlight("NavicText", colors.white)
winbarTagHighlight("NavicSeparator", colors.bright_orange)

winbarTagHighlightIcon("NavicIconsArray")
winbarTagHighlightIcon("NavicIconsBoolean")
winbarTagHighlightIcon("NavicIconsClass")
winbarTagHighlightIcon("NavicIconsConstant")
winbarTagHighlightIcon("NavicIconsConstructor")
winbarTagHighlightIcon("NavicIconsEnum")
winbarTagHighlightIcon("NavicIconsEnumMember")
winbarTagHighlightIcon("NavicIconsEvent")
winbarTagHighlightIcon("NavicIconsField")
winbarTagHighlightIcon("NavicIconsFile")
winbarTagHighlightIcon("NavicIconsFunction")
winbarTagHighlightIcon("NavicIconsInterface")
winbarTagHighlightIcon("NavicIconsKey")
winbarTagHighlightIcon("NavicIconsMethod")
winbarTagHighlightIcon("NavicIconsModule")
winbarTagHighlightIcon("NavicIconsNamespace")
winbarTagHighlightIcon("NavicIconsNull")
winbarTagHighlightIcon("NavicIconsNumber")
winbarTagHighlightIcon("NavicIconsObject")
winbarTagHighlightIcon("NavicIconsOperator")
winbarTagHighlightIcon("NavicIconsPackage")
winbarTagHighlightIcon("NavicIconsProperty")
winbarTagHighlightIcon("NavicIconsString")
winbarTagHighlightIcon("NavicIconsStruct")
winbarTagHighlightIcon("NavicIconsTypeParameter")
winbarTagHighlightIcon("NavicIconsVariable")
