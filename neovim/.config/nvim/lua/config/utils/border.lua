local success, files = pcall(require, 'config/utils/file')
if not success then return end

local borders = {}
local term_emulator = nil

-- the characters only work in the kitty terminal
if vim.g.TERM_EMULATOR ~= nil and vim.g.TERM_EMULATOR == "kitty" then
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

return borders
