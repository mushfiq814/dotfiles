local fileReaderLoaded, files = pcall(require, 'config/utils/file')
if not fileReaderLoaded then return end
local colorUtilsLoaded, colorUtils = pcall(require, 'config/utils/color-utils')
if not colorUtilsLoaded then return end

local M = {}

function M.generate()
  local colorschemeFile = vim.fn.expand('%:p')
  local colorschemeName = vim.fn.expand('%:t')
  local lines = files.lines_from(colorschemeFile)

  local colorscheme = {
    name = colorschemeName,
    mode = "dark",
    black = nil,
    white = nil,
    colors = {
      red = nil,
      orange = nil,
      yellow = nil,
      green = nil,
      aqua = nil,
      blue = nil,
      purple = nil,
    }
  }

  local gen = {}

  -- read colorscheme file
  for _, v in ipairs(lines) do
    local x0 = v:match("^MODE=\"(.+)\"")
    if x0 ~= nil then colorscheme.mode = x0 end
    local x1 = v:match("^BLACK=\"(.+)\"")
    if x1 ~= nil then colorscheme.black = x1 end
    local x2 = v:match("^WHITE=\"(.+)\"")
    if x2 ~= nil then colorscheme.white = x2 end
    local x3 = v:match("^NEUTRAL_RED=\"(.+)\"")
    if x3 ~= nil then colorscheme.colors.red = x3 end
    local x4 = v:match("^NEUTRAL_ORANGE=\"(.+)\"")
    if x4 ~= nil then colorscheme.colors.orange = x4 end
    local x5 = v:match("^NEUTRAL_YELLOW=\"(.+)\"")
    if x5 ~= nil then colorscheme.colors.yellow = x5 end
    local x6 = v:match("^NEUTRAL_GREEN=\"(.+)\"")
    if x6 ~= nil then colorscheme.colors.green = x6 end
    local x7 = v:match("^NEUTRAL_AQUA=\"(.+)\"")
    if x7 ~= nil then colorscheme.colors.aqua = x7 end
    local x8 = v:match("^NEUTRAL_BLUE=\"(.+)\"")
    if x8 ~= nil then colorscheme.colors.blue = x8 end
    local x9 = v:match("^NEUTRAL_PURPLE=\"(.+)\"")
    if x9 ~= nil then colorscheme.colors.purple = x9 end
  end

  table.insert(gen, "NAME=\"" .. colorscheme.name .. "\"")
  table.insert(gen, "MODE=\"" .. colorscheme.mode .. "\"")
  table.insert(gen, "BLACK=\"" .. colorscheme.black .. "\"")

  -- generate greys
  if colorscheme.black and colorscheme.white then
    local greys = colorUtils.colorInterpolate(colorscheme.black, colorscheme.white, 6)
    for i, grey in ipairs(greys) do
      table.insert(gen, "GREY" .. (i - 1) .. "=\"" .. grey .. "\"")
    end
  end

  table.insert(gen, "WHITE=\"" .. colorscheme.white .. "\"")

  -- for each other color, get light and dark shade
  for color, val in pairs(colorscheme.colors) do
    local lighter = colorUtils.lighten(val, 0.20)
    local darker = colorUtils.darken(val, 0.20)

    -- switch brighter and faded colors depending on mode
    if colorscheme.mode == "dark" then
      table.insert(gen, "BRIGHT_" .. color:upper() .. "=\"" .. lighter .. "\"")
      table.insert(gen, "NEUTRAL_" .. color:upper() .. "=\"" .. val .. "\"")
      table.insert(gen, "FADED_" .. color:upper() .. "=\"" .. darker .. "\"")
    else
      table.insert(gen, "BRIGHT_" .. color:upper() .. "=\"" .. darker .. "\"")
      table.insert(gen, "NEUTRAL_" .. color:upper() .. "=\"" .. val .. "\"")
      table.insert(gen, "FADED_" .. color:upper() .. "=\"" .. lighter .. "\"")
    end
  end

  -- handle missing orange
  if colorscheme.colors.orange == nil then
    local orange = colorUtils.colorMidpoint(colorscheme.colors.red, colorscheme.colors.yellow)
    vim.notify("orange not found...generating new orange: " .. orange)
    table.insert(gen, "BRIGHT_ORANGE=\"" .. colorUtils.lighten(orange, 0.20) .. "\"")
    table.insert(gen, "NEUTRAL_ORANGE=\"" .. orange .. "\"")
    table.insert(gen, "FADED_ORANGE=\"" .. colorUtils.darken(orange, 0.20) .. "\"")
  end

  -- append generated values to current file
  vim.api.nvim_buf_set_lines(0, -1, -1, true, gen)
end

return M
