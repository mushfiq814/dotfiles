function sum_cols()
  vim.cmd([[echo eval(join(split(@", '\_s\+'), '+'))]])
end

-- edited from https://git.sr.ht/~henriquehbr/dots/tree/main/item/nvim/.config/nvim/lua/config/commands.lua
function reload_config()
  for package_name, _ in pairs(package.loaded) do
    -- NOTE: for this to work, all custom lua modules need
    -- to be specified/loaded under the `lua/config` directory
    local prefix = "config"
    if package_name:match("^" .. prefix) then
      package.loaded[package_name] = nil
    end
  end

  vim.cmd("luafile " .. vim.env.MYVIMRC)
  -- vim.cmd("luafile " .. vim.env.MYVIMRC)
  vim.cmd "doautocmd VimEnter"
  vim.cmd("redraw!")
  vim.cmd("edit")
  vim.notify("Reloaded config")
end

vim.cmd [[
function! FollowMarkdownLink() abort
lua << EOF
-- get text of current line
local txt = vim.api.nvim_get_current_line()
-- get markdown link
local link = txt:match("%[.*%]%((.*)%)")

if link ~= nil then
  -- if the link exists, get current buffer filepath and append markdown link
  local buf = vim.api.nvim_exec("echo expand('%:p:h').\"/"..link.."\"", true)
  -- check if link has markdown extension
  local hasExt = string.sub(buf, -2) == 'md'
  if not hasExt then
    buf = buf..'.md'
  end
  -- go to that buffer
  vim.api.nvim_command("edit "..buf)
else
  print('link doesn\'t exist')
end
EOF
endfunction
]]

vim.cmd [[
function! CreateDiaryLinks() abort
lua << EOF

local vimwikiDiaryDir = os.getenv("HOME") .. '/windows/vimwiki/diary/'
-- get list of markdown files in dir
local diaryDirFiles = io.popen('ls ' .. vimwikiDiaryDir)
for file in diaryDirFiles:lines() do
  -- find diary entries matching YYYY-MM-DD filename format
  local diaryEntry = file:match("%d%d%d%d%-%d%d%-%d%d.md")
  -- if diary file found read the first line
  if (diaryEntry) then
    local firstLine = io.popen('head ' .. vimwikiDiaryDir .. diaryEntry .. ' -n 1')
    for line in firstLine:lines() do
    -- local reg = vim.regex('^# \(.*\)')
    local reg = vim.regex('^# \\(.*\\)')
      print('# hello':find(reg))
    end
  end
end

EOF
endfunction
]]

-- add markdown table divider
vim.cmd [[
function! AddTableDivider () abort
lua << EOF
-- TODO: call Tabularize function to align
-- get current line number
-- TODO: change this to get header line number
local lineNr = vim.api.nvim_win_get_cursor(0)[1]
-- get current line
local line = vim.api.nvim_buf_get_lines(0, lineNr-1, lineNr, {})[1]
-- replace any non bar chars with dashes
local tableSeparator = line:gsub('[^|]', '-')
-- insert separator after header
vim.api.nvim_buf_set_lines(0, lineNr, lineNr, true, { tableSeparator })
-- TODO: make sure Tabularize does not mess with newly added separator line
EOF
endfunction
]]
