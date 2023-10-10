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
-- splits duplicated
keymap('n', '<C-w>=', ':vsplit<CR>', opts)
keymap('n', '<C-w>-', ':split<CR>', opts)
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
keymap('n', '<leader>ve', ':edit ~/.config/nvim/lua/config/plugins.lua<CR>', opts)
keymap('n', '<leader>ze', ':edit ~/.zshrc<CR>', opts)
keymap('n', '<leader>te', ':edit ~/.tmux.conf<CR>', opts)

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
  .. ' && xdg-open ~/Downloads/pandoc-markdown-preview.html &<CR>',
  opts
)

-- Prettier
keymap('n', '<leader>fp', ':!prettier --write %<CR><CR>', opts)
keymap('n', '<leader>fr', ':!rustywind --write %<CR><CR>', opts)

-- change local working directory
keymap('n', '<leader>cd', ':lcd %:h<CR>', opts)

-- source current lua file
keymap('n', '<leader>so', ':source % <bar> lua vim.notify("NeoVim config reloaded")<CR>', opts)

local telescope_available, _ = pcall(require, 'telescope')
if telescope_available then
  keymap('n', '<C-p>', ':Telescope find_files find_command=rg,--files prompt_prefix=\\ 🔍\\ <CR>', opts)
  keymap('n', '<leader>b',  ':Telescope buffers prompt_prefix=\\ 🔍\\ <CR>', opts)
  keymap('n', '<leader>br', ':Telescope git_branches prompt_prefix=\\ \\ <CR>', opts)
  keymap('n', '<leader>fg', ':Telescope live_grep prompt_prefix=\\ 🔍\\ <CR>', opts)
  keymap('n', '<leader>gr', ':lua require(\'telescope.builtin\').lsp_references(require(\'telescope.themes\').get_ivy({}))<CR>', opts)
  keymap('n', '<leader>h',  ':Telescope help_tags prompt_prefix=\\ 🆘\\ <CR>', opts)
  keymap('n', '<leader>rc', ':Telescope oldfiles prompt_prefix=\\ ⏰\\ <CR>', opts)
  keymap('n', '<leader>rr', ':Telescope resume prompt_prefix=\\ ⏰\\ <CR>', opts)
  keymap('n', '<leader>ss', ':Telescope spell_suggest prompt_prefix=\\ ✅\\ <CR>', opts)

  -- open file picker for neovim settings
  keymap(
    'n',
    '<leader>v<C-p>',
    ':lua require\'telescope.builtin\'.find_files({ cwd = \'~/dotfiles/neovim/.config/nvim\' })<cr>',
    opts
  )
  -- open live grep for neovim settings
  keymap(
    'n',
    '<leader>vfg',
    ':lua require\'telescope.builtin\'.live_grep({ cwd = \'~/dotfiles/neovim/.config/nvim\' })<cr>',
    opts
  )

  -- open project directory
  keymap(
    'n',
    '<leader>pr',
    ':lua require\'telescope.builtin\'.find_files({ cwd = \'~/dotfiles\', hidden = true })<cr>',
    opts
  )

  -- yank filepath
  keymap('n', '<leader>yy', ':let @+ = expand("%")<CR>', opts)
end

