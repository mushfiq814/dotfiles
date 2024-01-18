-- Remaps

-- leader key
vim.g.mapleader = " "

local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Easier Escape from Insert Mode
keymap('i', 'jk', '<Esc>', opts)
keymap('i', 'JK', '<Esc>', opts)
keymap('i', 'KJ', '<Esc>', opts)
-- Auto complete pair
keymap('i', '(', '()<Left>', opts)
keymap('i', '{', '{}<Left>', opts)
keymap('i', '[', '[]<Left>', opts)
keymap('i', '`', '``<Left>', opts)
keymap('i', '"', '""<Left>', opts)
keymap('i', '\'', '\'\'<Left>', opts)

-- window management
-- splits
keymap('n', '<leader>=', ':vsplit<CR>', opts)
keymap('n', '<leader>-', ':split<CR>', opts)
-- move to window
keymap('n', '<leader>h', '<C-w>h', opts)
keymap('n', '<leader>j', '<C-w>j', opts)
keymap('n', '<leader>k', '<C-w>k', opts)
keymap('n', '<leader>l', '<C-w>l', opts)
-- move window to desired edge
keymap('n', '<leader>H', '<C-w>H', opts)
keymap('n', '<leader>J', '<C-w>J', opts)
keymap('n', '<leader>K', '<C-w>K', opts)
keymap('n', '<leader>L', '<C-w>L', opts)
-- new tab
keymap('n', '<leader>t', ':tabnew<CR>', opts)
-- focus current window to full screen
keymap('n', '<C-w>F', ':wincmd _ | :wincmd |<CR>', opts)
-- make all splits equal; should do the opposite of <C-w>F
keymap('n', '<C-w>f', ':wincmd =<CR>', opts)
-- resize with arrows
keymap('n', '<C-Up>', ':resize -2<CR>', opts)
keymap('n', '<C-Down>', ':resize +2<CR>', opts)
keymap('n', '<C-Left>', ':vertical resize -2<CR>', opts)
keymap('n', '<C-Right>', ':vertical resize +2<CR>', opts)

-- jumplist navigation
keymap('n', '<leader>.', '<C-i>', opts)
keymap('n', '<leader>,', '<C-o>', opts)

-- Stay in indent mode
keymap('v', '<', '<gv', opts)
keymap('v', '>', '>gv', opts)

-- sort selection
keymap('v', '<leader>st', ':sort<CR>', opts)

-- Text Wrapping
keymap('n', '<leader>z', ':set wrap!<CR>', opts)

-- open config files
keymap('n', '<leader>ve', ':edit ~/.config/nvim/init.lua<CR>', opts)
keymap('n', '<leader>ze', ':edit ~/.config/zsh/.zshrc<CR>', opts)

-- Folding/Unfolding
keymap('n', '<tab>', 'za', opts)

-- Escape to normal mode in terminal mode
keymap('t', '<ESC>', '<C-\\><C-n>', opts)

-- Disable highlight
keymap('n', '<ESC>', ':noh<CR>', opts)

-- local vimwikiDir
local vimwikiDir = '~/vimwiki'
-- Open personal wiki index page
keymap('n', '<leader>ww', ':edit ' .. vimwikiDir .. '/index.md<CR>', opts)
-- Open personal wiki diary page
keymap('n', '<leader>w<leader>w', ':edit ' .. vimwikiDir .. '/diary/diary.md<CR>', opts)

-- compile markdown to html
keymap(
  'n',
  '<leader>pp',
  ':cd %:h | !pandoc %:p'
  .. ' --css $HOME/dotfiles/pandoc/mvp.css'
  .. ' --template $HOME/dotfiles/pandoc/template.html'
  .. ' --output ~/downloads/pandoc-markdown-preview.html'
  .. ' --to html'
  .. ' --standalone'
  .. ' --self-contained'
  .. ' --mathjax'
  .. ' --highlight-style haddock'
  .. ' && open ~/downloads/pandoc-markdown-preview.html &<CR>',
  opts
)

-- change local working directory
keymap('n', '<leader>cd', ':lcd %:h<CR>', opts)

-- source current lua file
keymap('n', '<leader>so', ':source % <bar> lua vim.notify("NeoVim config reloaded")<CR>', opts)

-- yank filepath
keymap('n', '<leader>yy', ':let @+ = expand("%")<CR>', opts)

-- reload theme
keymap('n', '<leader>cc',
  function()
    -- remove cached colors module
    package.loaded["config/colors"] = nil
    vim.cmd("source " .. os.getenv("XDG_CONFIG_HOME") .. "/nvim/lua/config/theme.lua")
    vim.notify("Reloaded theme")
  end,
  opts)
