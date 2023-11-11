local success, files = pcall(require, 'config/utils/file')
if not success then return end

-- read vars from env file and store them globally
local lines = files.lines_from(os.getenv("HOME") .. "/dotfiles/.env")
for _, v in ipairs(lines) do
  for key,val in v:gmatch("([A-Z_]+)=\"?([^\"]+)\"?") do
    if (key ~= nil and val ~= nil) then
      vim.g[key] = val
    end
  end
end
