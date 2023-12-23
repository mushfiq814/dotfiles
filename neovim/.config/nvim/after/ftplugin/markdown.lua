-- remove list chars for improved readability
vim.opt.list = false

-- tabs & spaces
vim.opt.shiftwidth = 2 -- of spaces to use for each step of (auto)indent (>>, <<)
vim.opt.tabstop = 2 -- of spaces that a <Tab> counts for
vim.opt.softtabstop = 2 -- of spaces that a <Tab> counts while editing

-- keybindings
local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = false }

-- follow markdown links
keymap('n', '<CR>', ':lua FollowMarkdownLink()<CR>', opts)
-- go backwards
keymap('n', '<BS>', '<C-o>', opts)
-- align tables using Tabular
keymap('n', '<leader>a', ':Tabularize /|<CR>', opts)

-- functions
-- TODO: if extension exists (e.g. file.json), don't append markdown extension
function FollowMarkdownLink()
  -- get text of current line
  local txt = vim.api.nvim_get_current_line()
  -- get markdown link
  local link = txt:match("%[.*%]%((.*)%)")

  if link ~= nil then
    -- if the link exists, get current buffer filepath and append markdown link
    local buf = vim.api.nvim_exec("echo expand('%:p:h').\"/" .. link .. "\"", true)
    -- check if link has markdown extension
    local hasExt = string.sub(buf, -2) == 'md'
    if not hasExt then
      buf = buf .. '.md'
    end
    -- go to that buffer
    vim.api.nvim_command("edit " .. buf)
  else
    print('link doesn\'t exist')
  end
end

-- toggle checkboxes: [ ] <-> [x]
keymap('n', '<leader>cx', ':lua ToggleCheckbox()<CR>', opts)
function ToggleCheckbox()
  local unchecked = "[ ]"
  local checked = "[x]"
  local uncheckedRegex = "%[ %]"
  local checkedRegex = "%[x%]"

  -- get text of current line
  local currLine = vim.api.nvim_get_current_line()

  -- check whether checkbox exists in line
  local regexMatch = currLine:match("%[[x ]%]")
  -- local regexMatch = txt:match("%s***(%[[x ]%])")

  -- if no checkbox found, return immediately
  if regexMatch == nil then return end

  -- otherwise, toggle to correct state
  local newline = ""
  if regexMatch == unchecked then
    newline = currLine:gsub(uncheckedRegex, checkedRegex)
  elseif regexMatch == checked then
    newline = currLine:gsub(checkedRegex, uncheckedRegex)
  end

  -- set line in buffer
  vim.api.nvim_set_current_line(newline)
end
