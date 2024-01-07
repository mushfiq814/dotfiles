-- https://stackoverflow.com/questions/11201262/how-to-read-data-from-a-file-in-lua
-- http://lua-users.org/wiki/FileInputOutput

local M = {}

-- see if the file exists
function M.file_exists(file)
  local f = io.open(file, "rb")
  if f then f:close() end
  return f ~= nil
end

-- get all lines from a file, returns an empty
-- list/table if the file does not exist
function M.lines_from(file)
  if not M.file_exists(file) then return {} end
  local lines = {}
  for line in io.lines(file) do
    lines[#lines + 1] = line
  end
  return lines
end

--- Check if a file or directory exists in this path
function M.exists(file)
  local ok, err, code = os.rename(file, file)
  if not ok then
    if code == 13 then
      -- Permission denied, but it exists
      return true
    end
  end
  return ok, err
end

function M.getOpenBuffers()
  -- get list of buffers
  local bufs = vim.api.nvim_list_bufs()
  -- for each buffer in list
  for k, v in pairs(bufs) do
    -- check whether the buffer is loaded
    if vim.api.nvim_buf_is_loaded(v) then
      -- get the name of the buffer
      local bufName = vim.api.nvim_buf_get_name(v)
      -- NOTE: this list contains all opened buffers.
      -- perhaps I can filter it to the vimwiki directory only
      -- and cycle through those buffers
      print(k, bufName)
    end
  end
end

local function readTaskwikiTasks()
  local taskBaseDir = '/mnt/c/Users/mushf/.task'
  local filesToRead = {
    completedFile = taskBaseDir .. '/completed.data',
    pendingFile = taskBaseDir .. '/pending.data'
  }

  for fileTag, fileName in pairs(filesToRead) do
    -- get lines from file
    local lines = lines_from(fileName)
    -- content to be written to buffer
    todoContent = {}
    -- table of tasks for bookkeeping
    tasks = {}

    -- go through file line by line
    for k, v in pairs(lines) do
      -- get required info; .- is lazy matching
      local uuid        = v:match('uuid:\"(.-)\"')
      local description = v:match('description:\"(.-)\"')
      local status      = v:match('status:\"(.-)\"')
      local entry       = v:match('entry:\"(.-)\"')
      local modified    = v:match('modified:\"(.-)\"')
      local depends     = v:match('depends:\"(.-)\"')
      local due         = v:match('due:\"(.-)\"')
      local _end        = v:match('end:\"(.-)\"') -- end is a lua reserved keyword
      local project     = v:match('project:\"(.-)\"')
      local tags        = v:match('tags:\"(.-)\"')

      -- append to list
      if fileTag == 'completedFile' then
        table.insert(todoContent, '* [X] ' .. description .. ' #' .. uuid)
      else
        table.insert(todoContent, '* [ ] ' .. description .. ' #' .. uuid)
      end
    end
  end

  -- get current line number
  local line = vim.api.nvim_win_get_cursor(0)[1]
  -- insert todoContent at current line
  vim.api.nvim_buf_set_lines(0, line, line, true, todoContent)
end

return M;
