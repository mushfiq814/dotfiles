-- Remaps

-- leader key
vim.g.mapleader = " "

local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- Easier Escape from Insert Mode
keymap('i', 'jk', '<Esc>', opts)

-- Windows
-- Focus current window to full screen
keymap('n', '<C-w>F', ':wincmd _ | :wincmd |<CR>', opts)
-- Make all splits equal; should do the opposite of <C-w>F
keymap('n', '<C-w>f', ':wincmd =<CR>', opts)
keymap('n', '<C-h>', '<C-w><C-h><CR>', opts)
keymap('n', '<C-j>', '<C-w><C-j><CR>', opts)
keymap('n', '<C-k>', '<C-w><C-k><CR>', opts)
keymap('n', '<C-l>', '<C-w><C-l><CR>', opts)
-- Resize with arrows
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

-- Folding/Unfolding
keymap('n', '<tab>', 'za', opts)

-- Escape to normal mode in terminal mode
keymap('t', '<ESC>', '<C-\\><C-n>', opts)

-- Disable highlight
keymap('n', '<ESC>', ':noh<CR>', opts)

-- Open personal wiki index page
keymap('n', '<leader>ww', ':edit ~/windows/vimwiki/index.md<CR>', opts)
-- Open personal wiki diary page
keymap('n', '<leader>w<leader>w', ':edit ~/windows/vimwiki/diary/diary.md<CR>', opts)

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

