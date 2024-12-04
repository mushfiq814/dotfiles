local function filename()
  local filename_base = vim.fn.expand("%:t")
  if filename_base == '' then filename_base = '[scratch buffer]' end
  if vim.bo.modified then
    filename_base = filename_base .. " %#winbarFileNameModified#  %#Normal#"
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
