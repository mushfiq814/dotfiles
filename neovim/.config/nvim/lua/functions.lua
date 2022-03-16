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

-- vim.cmd [[
-- function! <SID>functions#SynStack()
-- 	if !exists("*synstack")
-- 		return
-- 	endif
-- 	echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
-- endfunction
-- " nmap <leader>;; :call <SID>SynStack()<CR>
-- ]]
