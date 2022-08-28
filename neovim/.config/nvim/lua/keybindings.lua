-- Remaps

-- leader key
vim.g.mapleader = " "

local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- Easier Escape from Insert Mode
keymap('i', 'jk', '<Esc>', opts)

-- window management
-- splits
keymap('n', '<C-=>', ':vsplit<CR>', opts)
keymap('n', '<C-->', ':split<CR>', opts)
-- new tab
keymap('n', '<C-t>', ':tabnew<CR>', opts)
-- new terminal
keymap('n', '<C-/>', ':terminal<CR>', opts)
-- focus current window to full screen
keymap('n', '<C-w>F', ':wincmd _ | :wincmd |<CR>', opts)
-- make all splits equal; should do the opposite of <C-w>F
keymap('n', '<C-w>f', ':wincmd =<CR>', opts)
-- resize with arrows
keymap('n', '<C-Up>', ':resize -2<CR>', opts)
keymap('n', '<C-Down>', ':resize +2<CR>', opts)
keymap('n', '<C-Left>', ':vertical resize -2<CR>', opts)
keymap('n', '<C-Right>', ':vertical resize +2<CR>', opts)

-- Stay in indent mode
keymap('v', '<', '<gv', opts)
keymap('v', '>', '>gv', opts)

-- Text Wrapping
keymap('n', '<leader>z', ':set wrap!<CR>', opts)

-- open config files
keymap('n', '<leader>ve', ':edit $MYVIMRC<CR>', opts)
keymap('n', '<leader>ze', ':edit ~/.zshrc<CR>', opts)
keymap('n', '<leader>te', ':edit ~/.tmux.conf<CR>', opts)

local winTermPathRegex =
  '~/windows/AppData/Local/Packages/Microsoft.WindowsTerminalPreview_*/LocalState/settings.json'
local handle = io.popen('ls ' .. winTermPathRegex)
local winTermPath = handle:read("*a")
handle:close()
keymap('n', '<leader>we', ':edit ' .. winTermPath, opts)

-- Folding/Unfolding
keymap('n', '<tab>', 'za', opts)

-- Escape to normal mode in terminal mode
keymap('t', '<ESC>', '<C-\\><C-n>', opts)

-- Disable highlight
keymap('n', '<ESC>', ':noh<CR>', opts)

-- local vimwikiDir
local vimwikiDir = '~/vimwiki'
-- if 2 then
--   vimwikiDir = '~/vimwiki'
-- else
--   vimwikiDir = '~/windows/vimwiki'
-- end
-- Open personal wiki index page
keymap('n', '<leader>ww', ':edit ' .. vimwikiDir .. '/index.md<CR>', opts)
-- Open personal wiki diary page
keymap('n', '<leader>w<leader>w', ':edit ' .. vimwikiDir .. '/diary/diary.md<CR>', opts)

-- compile markdown to html
keymap('n', '<leader>p', ':cd %:h | !pandoc %:p'
				 .. ' --css $HOME/dotfiles/pandoc/mvp.css'
				 .. ' --template $HOME/dotfiles/pandoc/template.html'
				 .. ' --output ~/downloads/documents/pandoc-markdown-preview.html'
				 .. ' --to html'
				 .. ' --standalone'
				 .. ' --self-contained'
				 .. ' --mathjax'
				 .. ' --highlight-style tango'
				 .. ' && powershell.exe "Invoke-Item ~/downloads/documents/pandoc-markdown-preview.html"<CR><CR>', opts)

-- Prettier
keymap('n', '<leader>f', ':!prettier --write %<CR><CR>', opts)

