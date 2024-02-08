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

local function hex_to_rgb(hex)
  return
      M.HEX_DIGITS[string.sub(hex, 1, 1)] * 16 + M.HEX_DIGITS[string.sub(hex, 2, 2)],
      M.HEX_DIGITS[string.sub(hex, 3, 3)] * 16 + M.HEX_DIGITS[string.sub(hex, 4, 4)],
      M.HEX_DIGITS[string.sub(hex, 5, 5)] * 16 + M.HEX_DIGITS[string.sub(hex, 6, 6)]
end

local function rgb_to_hex(r, g, b)
  return bit.tohex(bit.bor(bit.lshift(r, 16), bit.lshift(g, 8), b), 6)
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
    if (next(args) == nil) then
      vim.cmd(('hi! link %s NONE'):format(hlgroup))
      return
    end

    if (args.link) then
      vim.cmd(('hi! link %s %s'):format(hlgroup, args.link))
      return
    end

    local fg = args.fg or nil
    local bg = args.bg or nil
    local sp = args.sp or nil

    local gui = {}
    if args.bold or false then table.insert(gui, "bold") end
    if args.standout or false then table.insert(gui, "standout") end
    if args.underline or false then table.insert(gui, "underline") end
    if args.undercurl or false then table.insert(gui, "undercurl") end
    if args.underdouble or false then table.insert(gui, "underdouble") end
    if args.underdotted or false then table.insert(gui, "underdotted") end
    if args.underdashed or false then table.insert(gui, "underdashed") end
    if args.strikethrough or false then table.insert(gui, "strikethrough") end
    if args.italic or false then table.insert(gui, "italic") end
    if args.reverse or false then table.insert(gui, "reverse") end
    if args.nocombine or false then table.insert(gui, "nocombine") end
    local guistr = table.concat(gui, ',')

    local cmd = { 'hi!', hlgroup }
    if fg then table.insert(cmd, 'guifg=' .. fg) end
    if bg then table.insert(cmd, 'guibg=' .. bg) end
    if sp then table.insert(cmd, 'guisp=' .. sp) end
    if #guistr > 0 then table.insert(cmd, 'gui=' .. guistr) end
    vim.cmd(table.concat(cmd, ' '))
  end
})

-- TODO: implement
M.highlight_new = setmetatable({}, {
  __newindex = function(_, hlgroup, args)
    vim.api.nvim_set_hl(0, hlgroup, args)
  end
})

return M
