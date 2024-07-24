local success, files = pcall(require, 'config/utils/file')
if not success then return end

local borders = {}
local term_emulator = nil

-- the characters only work in the kitty terminal
if not vim.g.neovide and vim.g.TERM_EMULATOR ~= nil and vim.g.TERM_EMULATOR == "kitty" then
  borders = {
    '🭽', '▔', '🭾',
    '▏', ' ', '▕',
    '🭼', '▁', '🭿',
  }
else
  borders = {
    ' ', ' ', ' ',
    ' ', ' ', ' ',
    ' ', ' ', ' ',
  }
end

return {
  default = borders,
  borderchars = {
    borders[2],
    borders[6],
    borders[8],
    borders[4],
    borders[1],
    borders[3],
    borders[9],
    borders[7],
  },
  borders = {
    { borders[1], "FloatBorder" },
    { borders[2], "FloatBorder" },
    { borders[3], "FloatBorder" },
    { borders[6], "FloatBorder" },
    { borders[9], "FloatBorder" },
    { borders[8], "FloatBorder" },
    { borders[7], "FloatBorder" },
    { borders[4], "FloatBorder" },
  },
}
