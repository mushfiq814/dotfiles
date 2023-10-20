-- place for unused/deprecated function(s)

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

-- organize diary file by month/year
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

function alignMarkdownTable()
  vim.cmd.Tabularize()
  -- get current line number
  local lineNr = vim.api.nvim_win_get_cursor(0)[1]
  -- get current line
  local line = vim.api.nvim_buf_get_lines(0, lineNr-1, lineNr, {})[1]
  -- replace any non bar chars with dashes
  local tableSeparator = line:gsub('[^|]', '-')
  -- insert separator after header
  -- vim.api.nvim_buf_set_lines(0, lineNr, lineNr, true, { tableSeparator })
  -- TODO: make sure Tabularize does not mess with newly added separator line
  local parser = vim.treesitter.get_parser(0, vim.o.filetype)
  local root = parser:parse()[1]:root()
  local query = vim.treesitter.parse_query(vim.o.filetype, [[
    (pipe_table_delimiter_row) @var
  ]])
  for id, captures, metadata in query:iter_matches(root, lineNr) do
    print(vim.inspect({
      id = id,
      captures = captures,
      metadata = metadata,
    }))
    -- id(captures)
  end
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

  -- TODO: not supported currently with lazy.nvim
  -- INFO: https://github.com/folke/lazy.nvim/issues/445
  -- vim.cmd("luafile " .. vim.env.MYVIMRC)
  require('config/winbar')
  require('config/statusline')
  require('config/theme')

  vim.cmd "doautocmd VimEnter"
  vim.cmd("redraw!")
  vim.cmd("edit")
  vim.notify("Reloaded config")
end

-- turn off spell for images
vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
  pattern = { "*.jpg", "*.jpeg", "*.png", "*.bmp", "*.webp" },
  callback = function ()
    vim.wo.spell = false
  end,
})

-- Put matched groups in search into register for stringing multiple objects use:
-- %s//\=setreg('A', submatch(1) . ": " . submatch(2), "V")/n
-- command! GetMatch execute "%s//\=setreg('A', submatch(1), \"V\")/n"

-- Exec
-- call as follows `:put =Exec('command')`. e.g. `:put =Exec('ls')`
vim.cmd [[
function! Exec(command)
	redir => output
	silent exec a:command
	redir END
	return output
endfunction!
]]

-- sum numbers in visual selection
function sum_cols()
  vim.cmd([[echo eval(join(split(@", '\_s\+'), '+'))]])
end
