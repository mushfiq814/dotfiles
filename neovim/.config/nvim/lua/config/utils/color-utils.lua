-- edited from https://github.com/RRethy/nvim-base16/

local M = {}

M.hex_re = vim.regex('#\\x\\x\\x\\x\\x\\x')

M.HEX_DIGITS = {
  ['0'] = 0,
  ['1'] = 1,
  ['2'] = 2,
  ['3'] = 3,
  ['4'] = 4,
  ['5'] = 5,
  ['6'] = 6,
  ['7'] = 7,
  ['8'] = 8,
  ['9'] = 9,
  ['a'] = 10,
  ['b'] = 11,
  ['c'] = 12,
  ['d'] = 13,
  ['e'] = 14,
  ['f'] = 15,
  ['A'] = 10,
  ['B'] = 11,
  ['C'] = 12,
  ['D'] = 13,
  ['E'] = 14,
  ['F'] = 15,
}

local function rgb(c)
  c = string.lower(c)
  return { tonumber(c:sub(2, 3), 16), tonumber(c:sub(4, 5), 16), tonumber(c:sub(6, 7), 16) }
end

function M.blend(foreground, alpha, background)
  alpha = type(alpha) == "string" and (tonumber(alpha, 16) / 0xff) or alpha
  local bg = rgb(background)
  local fg = rgb(foreground)

  local blendChannel = function(i)
    local ret = (alpha * fg[i] + ((1 - alpha) * bg[i]))
    return math.floor(math.min(math.max(0, ret), 255) + 0.5)
  end

  return string.format("#%02x%02x%02x", blendChannel(1), blendChannel(2), blendChannel(3))
end

local function hex_to_rgb(hex)
  return
      M.HEX_DIGITS[string.sub(hex, 1, 1)] * 16 + M.HEX_DIGITS[string.sub(hex, 2, 2)],
      M.HEX_DIGITS[string.sub(hex, 3, 3)] * 16 + M.HEX_DIGITS[string.sub(hex, 4, 4)],
      M.HEX_DIGITS[string.sub(hex, 5, 5)] * 16 + M.HEX_DIGITS[string.sub(hex, 6, 6)]
end

local function rgb_to_hex(r, g, b)
  return bit.tohex(bit.bor(bit.lshift(r, 16), bit.lshift(g, 8), b), 6)
end

function M.lightenForMode(mode, hex, pct)
  if mode == 'dark' then
    return M.lighten(hex, pct)
  else
    return M.darken(hex, pct)
  end
end

function M.darkenForMode(mode, hex, pct)
  if mode == 'dark' then
    return M.darken(hex, pct)
  else
    return M.lighten(hex, pct)
  end
end

function M.lighten(hex, pct)
  local r, g, b = hex_to_rgb(string.sub(hex, 2))
  r = math.min(math.floor(r * (1 + pct)), 255)
  g = math.min(math.floor(g * (1 + pct)), 255)
  b = math.min(math.floor(b * (1 + pct)), 255)
  return string.format("#%s", rgb_to_hex(r, g, b))
end

function M.darken(hex, pct)
  pct = 1 - pct
  local r, g, b = hex_to_rgb(string.sub(hex, 2))
  r = math.floor(r * pct)
  g = math.floor(g * pct)
  b = math.floor(b * pct)
  return string.format("#%s", rgb_to_hex(r, g, b))
end

--- get the midpoint color between 2 colors
--- use as colorMidpoint("#ff0000", "#0000ff")
--- should return "#800080"
--- @param c1 string should be a valid hex color value starting with #
--- @param c2 string should be a valid hex color value starting with #
--- @return string
function M.colorMidpoint(c1, c2)
  local c = "#"
  for i = 2, 7, 2 do
    local avg = (tonumber(c1:sub(i, i + 1), 16) + tonumber(c2:sub(i, i + 1), 16)) / 2
    c = c .. string.format("%02x", math.ceil(avg))
  end
  return c
end

--- get in-between colors between 2 colors
--- use as colorInterpolate("#ff0000", "#0000ff", 6)
--- should return { "#db0025", "#b70049", "#92006e", "#6e0092", "#4900b7", "#2500db" }
--- @param c1 string should be a valid hex color value starting with #
--- @param c2 string should be a valid hex color value starting with #
--- @param n integer the number of interpolations in the middle
--- @return table<string>
function M.colorInterpolate(c1, c2, n)
  local midColors = {}
  for i = 1, n, 1 do
    -- 't' should be a value between 0 and 1 that defines the current
    -- distance from the first color value
    local t = 1 / (n + 1) * i
    local c = "#"

    -- do for each color channel "R", "G", "B"
    for j = 2, 7, 2 do
      local x1 = tonumber(c1:sub(j, j + 1), 16)
      local x2 = tonumber(c2:sub(j, j + 1), 16)
      local val = x1 + (x2 - x1) * t
      c = c .. string.format("%02x", math.ceil(val))
    end
    table.insert(midColors, c)
  end
  return midColors
end

M.highlight = setmetatable({}, {
  __newindex = function(_, hlgroup, args)
    if ('string' == type(args)) then
      vim.cmd(('hi! link %s %s'):format(hlgroup, args))
      return
    end

    local guifg, guibg, gui, guisp = args.guifg or nil, args.guibg or nil, args.gui or nil, args.guisp or nil
    local cmd = { 'hi!', hlgroup }
    if guifg then table.insert(cmd, 'guifg=' .. guifg) end
    if guibg then table.insert(cmd, 'guibg=' .. guibg) else table.insert(cmd, 'guibg=NONE') end
    if gui then table.insert(cmd, 'gui=' .. gui) end
    if guisp then table.insert(cmd, 'guisp=' .. guisp) end
    vim.cmd(table.concat(cmd, ' '))
  end
})

function M.hexToRGB(hex)
    local r = tonumber(hex:sub(2, 3), 16)
    local g = tonumber(hex:sub(4, 5), 16)
    local b = tonumber(hex:sub(6, 7), 16)
    return r, g, b
end

function M.rgbToHSL(r, g, b)
  r = r / 255
  g = g / 255
  b = b / 255

  local max = math.max(r, g, b)
  local min = math.min(r, g, b)
  local h, s, l = 0, 0, (max + min) / 2

  if max == min then
    h = 0
    s = 0
  else
    local delta = max - min
    s = l > 0.5 and delta / (2 - max - min) or delta / (max + min)
    if max == r then
        h = (g - b) / delta + (g < b and 6 or 0)
    elseif max == g then
        h = (b - r) / delta + 2
    elseif max == b then
        h = (r - g) / delta + 4
    end
    h = h * 60
  end

  return h, s * 100, l * 100
end

function M.hueToRGB(p, q, t)
  if t < 0 then t = t + 1 end
  if t > 1 then t = t - 1 end
  if t < 1 / 6 then return p + (q - p) * 6 * t end
  if t < 1 / 2 then return q end
  if t < 2 / 3 then return p + (q - p) * (2 / 3 - t) * 6 end
  return p
end

function M.hslToRGB(h, s, l)
  s = s / 100
  l = l / 100

  local r, g, b
  if s == 0 then
    r, g, b = l, l, l
  else
    local q = l < 0.5 and l * (1 + s) or l + s - l * s
    local p = 2 * l - q
    r = M.hueToRGB(p, q, h / 360 + 1 / 3)
    g = M.hueToRGB(p, q, h / 360)
    b = M.hueToRGB(p, q, h / 360 - 1 / 3)
  end

  return math.floor(r * 255), math.floor(g * 255), math.floor(b * 255)
end

--- Adjusts a color in hex format by modifying its hue, saturation, and luminance.
--- @param hex string The color in hex format (#RRGGBB).
--- @param hueAdjust number The amount to adjust the hue (in degrees, can be negative).
--- @param saturationAdjust number The amount to adjust the saturation (percentage, can be negative).
--- @param luminanceAdjust number The amount to adjust the luminance (percentage, can be negative).
--- @return string _ The adjusted color in hex format (#RRGGBB).
function M.adjustColor(hex, hueAdjust, saturationAdjust, luminanceAdjust)
    local r, g, b = M.hexToRGB(hex)
    local h, s, l = M.rgbToHSL(r, g, b)

    -- Adjust HSL values
    h = (h + hueAdjust) % 360
    s = math.min(100, math.max(0, s + saturationAdjust))
    l = math.min(100, math.max(0, l + luminanceAdjust))

    -- Convert back to RGB
    r, g, b = M.hslToRGB(h, s, l)

    -- Convert RGB to hex
    return string.format("#%02X%02X%02X", r, g, b)
end

return M
