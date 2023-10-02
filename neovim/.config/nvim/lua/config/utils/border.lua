local borders = {}

-- the characters only work in the kitty terminal
if vim.loop.os_uname().sysname == "Linux" then
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
