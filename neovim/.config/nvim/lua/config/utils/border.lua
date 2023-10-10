local success, files = pcall(require, 'config/utils/file')
if not success then return end

local borders = {}
local term_emulator = nil

local lines = files.lines_from("/Users/mumahmud/dotfiles/.env")
for _, v in ipairs(lines) do
  term_emulator = v:match("^TERM_EMULATOR=\"(.+)\"")
  if term_emulator then break end
end

-- the characters only work in the kitty terminal
if term_emulator ~= nil and term_emulator == "kitty" then
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
