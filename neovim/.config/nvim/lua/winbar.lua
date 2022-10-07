local colors_loaded, colors = pcall(require, 'theme')
if not colors_loaded then return end
local theme = colors.colors
local background = theme.black
local foreground = theme.white

local function filename()
  local filename = vim.fn.expand("%:t")
  if filename == '' then return '' end
  if vim.bo.modified then filename = filename .. " ● " end
  return "%#winbarFileName# " .. filename .. " %#Normal#"
end

local function navicTags()
  local navicLoaded, nvim_navic = pcall(require, 'nvim-navic')
  if navicLoaded then
    local current_tag = nvim_navic.get_location()
    if current_tag == "" then return '' end
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

local function highlights()
  -- 
  vim.cmd(
    "highlight! winbarFileName gui=bold guifg="
    .. theme.white
    .. " guibg="
    .. theme.faded_purple
  )
  -- 
  vim.cmd(
    "highlight! winbarTags guifg="
    .. foreground
    .. " guibg="
    .. theme.grey0
  )
end
highlights()
