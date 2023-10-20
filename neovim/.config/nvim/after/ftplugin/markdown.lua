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
