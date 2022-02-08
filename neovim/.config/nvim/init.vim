"=============================================================================
"                                  █████        ██████  ███
"                                 ░░███        ███░░███░░░
"  █████████████  █████ ████ █████ ░███████   ░███ ░░░ ████   ████████
" ░░███░░███░░███░░███ ░███ ███░░  ░███░░███ ███████  ░░███  ███░░███
"  ░███ ░███ ░███ ░███ ░███░░█████ ░███ ░███░░░███░    ░███ ░███ ░███
"  ░███ ░███ ░███ ░███ ░███ ░░░░███░███ ░███  ░███     ░███ ░███ ░███
"  █████░███ █████░░██████████████ ████ █████ █████    █████░░███████
" ░░░░░ ░░░ ░░░░░  ░░░░░░░░░░░░░░ ░░░░ ░░░░░ ░░░░░    ░░░░░  ░░░░░███
"                     o                      ,- o                ░███
"     ;-. ,-. ,-. . , . ;-.-.   ,-. ,-. ;-.  |  . ,-:            █████
"     | | |-' | | |/  | | | |   |   | | | |  |- | | |           ░░░░░
"     ' ' `-' `-' '   ' ' ' '   `-' `-' ' '  |  ' `-|
"                                           -'    `-'
"=============================================================================

" Plugins {{{
call plug#begin('~/.config/nvim/plugged')

" Programming Language Plugins {{{
Plug 'godlygeek/tabular'
Plug 'mattn/emmet-vim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/playground'
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/nvim-lsp-installer'
" Plug 'kabouzeid/nvim-lspinstall'
" Plug 'anott03/nvim-lspinstall'
Plug 'hrsh7th/nvim-compe'
Plug 'lewis6991/spellsitter.nvim'
Plug 'dense-analysis/ale'
" }}}

" Navigation Plugins {{{
" Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
" Plug 'junegunn/fzf.vim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'liuchengxu/vim-which-key'
Plug 'masukomi/vim-markdown-folding'
Plug 'psliwka/vim-smoothie'
Plug 'rstacruz/vim-closer'
" }}}

" Colorschemes and UI {{{
Plug 'kyazdani42/nvim-web-devicons'
Plug 'kyazdani42/nvim-tree.lua'
Plug 'nanozuki/tabby.nvim'
Plug 'morhetz/gruvbox'
Plug 'Shadorain/shadotheme'
Plug 'hoob3rt/lualine.nvim'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'junegunn/goyo.vim'
Plug 'mhinz/vim-startify'
Plug 'norcalli/nvim-colorizer.lua'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }
Plug 'fladson/vim-kitty'
" }}}

" Development Tools {{{
Plug 'tpope/vim-fugitive'
" Plug 'vimwiki/vimwiki'
Plug 'mbbill/undotree'
" Plug 'tbabej/taskwiki'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-surround'
" Plug 'mg979/vim-visual-multi'
Plug 'tpope/vim-commentary'
" }}}

call plug#end()
" }}}

" Plugin Settings {{{

" TreeSitter {{{
lua << EOF
require'nvim-treesitter.configs'.setup {
	highlight = { enable = true },
	indent = { enable = true }
}
EOF

set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
" }}}

" Neovim Lsp {{{

lua << EOF
require'lspconfig'.tsserver.setup{}
require'lspconfig'.pyright.setup{}
require'lspconfig'.graphql.setup{}

-- require'lspinstall'.setup() -- important
-- 
-- local servers = require'lspinstall'.installed_servers()
-- for _, server in pairs(servers) do
--   require'lspconfig'[server].setup{}
-- end
-- 
-- local function setup_servers()
--   require'lspinstall'.setup()
--   local servers = require'lspinstall'.installed_servers()
--   for _, server in pairs(servers) do
--     require'lspconfig'[server].setup{}
--   end
-- end
-- 
-- setup_servers()
-- 
-- -- Automatically reload after `:LspInstall <server>` so we don't have to restart neovim
-- require'lspinstall'.post_install_hook = function ()
--   setup_servers() -- reload installed servers
--   vim.cmd("bufdo e") -- this triggers the FileType autocmd that starts the server
-- end

EOF
" }}}

" Nevim Lsp Completion {{{
lua << EOF
vim.o.completeopt = "menuone,noselect"

require'compe'.setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'enable';
  throttle_time = 80;
  source_timeout = 200;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = false;

  source = {
    path = true;
    treesitter = true;
    nvim_lsp = true;
    nvim_lua = true;
    tags = true;
    spell = true;
    buffer = true;
    calc = true;
    vsnip = true;
    snippets_nvim = true;
  };
}

local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end
_G.s_tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-p>"
  elseif vim.fn.call("vsnip#jumpable", {-1}) == 1 then
    return t "<Plug>(vsnip-jump-prev)"
  else
    return t "<S-Tab>"
  end
end

-- vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
-- vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
-- vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
EOF

" }}}

" GitGutter {{{
let g:gitgutter_enabled = 1
let g:gitgutter_sign_added = '▍'
let g:gitgutter_sign_modified = '▍'
let g:gitgutter_sign_removed = '▍'
let g:gitgutter_sign_removed_first_line = '‾'
let g:gitgutter_sign_removed_above_and_below = '_¯'
let g:gitgutter_sign_modified_removed   = '█'
" █
" ▉
" ▊
" ▋
" ▌
" ▍
" ▎
" ▏
" ▐

set updatetime=100
" }}}

" Startify {{{
" Heading
let g:ascii = [
	\ '                                        _            .                       ',
	\ '                                       u            @88>                     ',
	\ '   u.    u.                     u.    88Nu.   u.    %8P      ..    .     :   ',
	\ ' x@88k u@88c.      .u     ...ue888b  `88888.o888c    .     .888: x888  x888. ',
	\ '^"8888""8888"   ud8888.   888R Y888r  ^8888  8888  .@88u  ~`8888~`888X`?888f`',
	\ '  8888  888R  :888`8888.  888R I888>   8888  8888 ``888E`   X888  888X `888> ',
	\ '  8888  888R  d888 `88%"  888R I888>   8888  8888   888E    X888  888X `888> ',
	\ '  8888  888R  8888.+"     888R I888>   8888  8888   888E    X888  888X `888> ',
	\ '  8888  888R  8888L      u8888cJ888   .8888b.888P   888E    X888  888X `888> ',
	\ ' "*88*" 8888" `8888c. .+  "*888*P"     ^Y8888*""    888&   "*88%""*88" `888!`',
	\ '   ""   `Y"    "88888%      `Y"          `Y"        R888"    `~    "    `"`  ',
	\ '                 "YP`                                ""                      ',
	\ ]

let g:startify_custom_header = 'startify#center(g:ascii)'

" }}}

" LuaLine {{{

lua << EOF
local gruvbox = {  }

local colors = {
	black    = '#1d2021',
	grey0    = '#282828',
	grey1    = '#504945',
	grey2    = '#7c6f64',
	grey3    = '#a89984',
	grey4    = '#ebdbb2',
	white    = '#fbf1c7',
	blue     = '#83a598',
	red      = '#fb4934',
	orange   = '#fe8019',
	yellow   = '#fabd2f',
	green    = '#b8bb26',
	purple   = '#d3869b',
	cyan     = '#8ec07c',
}

-- #83a598 #458588
-- #fb4934 #cc241d
-- #fe8019 #d65d0e
-- #fabd2f #d79921
-- #b8bb26 #98971a
-- #d3869b #b16286
-- #8ec07c #689d6a

gruvbox.normal = {
	a = { bg = colors.cyan,   fg = colors.black, gui = "bold", },
	b = { bg = colors.black,  fg = colors.white, },
	c = { bg = colors.grey0,  fg = colors.grey4, }
}

gruvbox.insert = {
	a = { bg = colors.blue,   fg = colors.black, gui = "bold", },
	b = { bg = colors.black,  fg = colors.white, },
	c = { bg = colors.grey0,  fg = colors.grey4, }
}

gruvbox.visual = {
	a = { bg = colors.yellow, fg = colors.black, gui = "bold", },
	b = { bg = colors.black,  fg = colors.white, },
	c = { bg = colors.grey0,  fg = colors.grey4, }
}

gruvbox.replace = {
	a = { bg = colors.red,    fg = colors.black, gui = "bold", },
	b = { bg = colors.black,  fg = colors.white, },
	c = { bg = colors.grey0,  fg = colors.grey4, }
}

gruvbox.command = {
	a = { bg = colors.orange, fg = colors.black, gui = "bold", },
	b = { bg = colors.black,  fg = colors.white, },
	c = { bg = colors.grey0,  fg = colors.grey4, }
}

gruvbox.inactive = {
	a = { bg = colors.grey3,  fg = colors.black, gui = "bold", },
	b = { bg = colors.black,  fg = colors.grey3, },
	c = { bg = colors.grey0,  fg = colors.grey4, }
}

gruvbox.terminal = {
	a = { bg = colors.purple,   fg = colors.black, gui = "bold", },
	b = { bg = colors.black,  fg = colors.white, },
	c = { bg = colors.grey0,  fg = colors.grey4, }
}

local function inactive_txt()
	return [[INACTIVE]]
end

require('lualine').setup {
	options = {
		theme = gruvbox,
		-- section_separators = { '', '' },
		-- section_separators = { '', '' },
		-- section_separators = { '▌', '▐' },
		section_separators = { '', '' },
		component_separators = { '•', '•' },
		-- component_separators = { ' ', ' ' },
		icons_enabled = true,
	},
	sections = {
		lualine_a = { { 'mode', upper = true, }, },
		-- lualine_b = { { 'branch', icon = '', }, { 'diff', color_added = colors.green, color_modified = colors.cyan, color_removed = colors.red }, },
		lualine_b = { { 'branch', icon = '', }, { 'diff', color_added = colors.green, color_modified = colors.cyan, color_removed = colors.red }, },
		lualine_c = { { 'filename', file_status = true, path = 1, }, },
		lualine_x = { { 'diagnostics', sources = { 'nvim_lsp', }, symbols = { error = '🔴', warn = '🟡', info = '🔵', }, color_error = colors.red, color_warn = colors.yellow, color_info = colors.blue }, 'encoding', 'fileformat', 'filetype' },
		lualine_y = { 'progress' },
		lualine_z = { 'location'  },
	},
	inactive_sections = {
		lualine_a = { inactive_txt },
		lualine_b = { 'filename' },
		lualine_c = { },
		lualine_x = { },
		lualine_y = { },
		lualine_z = { 'location' },
	},
	extensions = { 'fzf' }
}
EOF

" }}}

" Fuzzy Finder {{{
let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.8 } }
let $FZF_DEFAULT_OPTS = '--reverse'
" }}}

" Colorizer {{{
" Colorizer init settings in Colors section
" }}}

" Which Key {{{
nnoremap <silent> <leader> :WhichKey ','<CR>
set timeoutlen=500
" }}}

" Indent Blankline {{{

" Special Characters: '│' '█' '▏'
let g:indent_blankline_char = '▏'
let g:indent_blankline_space_char = ' '
" let g:indent_blankline_space_char_blankline = '▏'

" Enable tree sitter to detect current indent level. Needs Treesitter installed
let g:indent_blankline_use_treesitter = v:true

" }}}

" Nvim Tree {{{
lua << EOF
-- following options are the default
require'nvim-tree'.setup {
  -- disables netrw completely
  disable_netrw       = true,
  -- hijack netrw window on startup
  hijack_netrw        = true,
  -- open the tree when running this setup function
  open_on_setup       = false,
  -- will not open on setup if the filetype is in this list
  ignore_ft_on_setup  = {},
  -- closes neovim automatically when the tree is the last **WINDOW** in the view
  open_on_tab         = false,
  -- hijacks new directory buffers when they are opened.
  update_to_buf_dir   = {
    -- enable the feature
    enable = true,
    -- allow to open the tree if it was previously closed
    auto_open = true,
  },
  -- hijack the cursor in the tree to put it at the start of the filename
  hijack_cursor       = false,
  -- updates the root directory of the tree on `DirChanged` (when your run `:cd` usually)
  update_cwd          = false,
  -- show lsp diagnostics in the signcolumn
  diagnostics = {
    enable = true,
    icons = {
      hint    = "",
      info    = "",
      warning = "",
      error   = "",
    }
  },
  -- update the focused file on `BufEnter`, un-collapses the folders recursively until it finds the file
  update_focused_file = {
    -- enables the feature
    enable      = true,
    -- update the root directory of the tree to the one of the folder containing the file if the file is not under the current root directory
    -- only relevant when `update_focused_file.enable` is true
    update_cwd  = false,
    -- list of buffer names / filetypes that will not update the cwd if the file isn't found under the current root directory
    -- only relevant when `update_focused_file.update_cwd` is true and `update_focused_file.enable` is true
    ignore_list = {}
  },
  -- configuration options for the system open command (`s` in the tree by default)
  system_open = {
    -- the command to run this, leaving nil should work in most cases
    cmd  = nil,
    -- the command arguments as a list
    args = {}
  },

  view = {
    -- width of the window, can be either a number (columns) or a string in `%`, for left or right side placement
    width = 30,
    -- height of the window, can be either a number (columns) or a string in `%`, for top or bottom side placement
    height = 30,
    -- side of the tree, can be one of 'left' | 'right' | 'top' | 'bottom'
    side = 'left',
    -- if true the tree will resize itself after opening a file
    auto_resize = true,
    mappings = {
      -- custom only false will merge the list with the default mappings
      -- if true, it will only use your list to set the mappings
      custom_only = false,
      -- list of mappings to set on the tree manually
      list = {}
    }
  }
}
EOF
let g:nvim_tree_icons = {
    \ 'default': '',
    \ 'symlink': '',
    \ 'git': {
    \   'unstaged': "✗",
    \   'staged': "✓",
    \   'unmerged': "",
    \   'renamed': "➜",
    \   'untracked': "★",
    \   'deleted': "",
    \   'ignored': "◌"
    \   },
    \ 'folder': {
    \   'arrow_open': "",
    \   'arrow_closed': "",
    \   'default': "",
    \   'open': "",
    \   'empty': "",
    \   'empty_open': "",
    \   'symlink': "",
    \   'symlink_open': "",
    \   },
    \   'lsp': {
    \     'hint': "",
    \     'info': "",
    \     'warning': "",
    \     'error': "",
    \   }
    \ }

nnoremap <C-n> :NvimTreeToggle<CR>
nnoremap <leader>r :NvimTreeRefresh<CR>
nnoremap <leader>n :NvimTreeFindFile<CR>

" a list of groups can be found at `:help nvim_tree_highlight`
" highlight NvimTreeFolderIcon guibg=blue
" }}}

" spellsitter {{{
lua << EOF
require('spellsitter').setup {
  hl = 'SpellBad',
  captures = { 'comment' },  -- set to {} to spellcheck everything
}
EOF
" }}}

" Tabby {{{
lua << EOF

local colors = {
	black          = '#1d2021',
	grey0          = '#282828',
	grey1          = '#504945',
	grey2          = '#7c6f64',
	grey3          = '#a89984',
	grey4          = '#ebdbb2',
	white          = '#fbf1c7',

	bright_red     = '#fb4934',
	bright_green   = '#b8bb26',
	bright_yellow  = '#fabd2f',
	bright_blue    = '#83a598',
	bright_purple  = '#d3869b',
	bright_aqua    = '#8ec07c',
	bright_orange  = '#fe8019',

	neutral_red    = '#cc241d',
	neutral_green  = '#98971a',
	neutral_yellow = '#d79921',
	neutral_blue   = '#458588',
	neutral_purple = '#b16286',
	neutral_aqua   = '#689d6a',
	neutral_orange = '#d65d0e',

	faded_red      = '#9d0006',
	faded_green    = '#79740e',
	faded_yellow   = '#b57614',
	faded_blue     = '#076678',
	faded_purple   = '#8f3f71',
	faded_aqua     = '#427b58',
	faded_orange   = '#af3a03',
}

local palette = {
	bg0   = nil,
	bg1   = colors.black,
	bg2   = colors.grey1,
	ac1_1 = colors.bright_aqua,
	ac1_2 = colors.neutral_aqua,
	ac1_3 = colors.faded_aqua,
	ac2_1 = colors.bright_purple,
	ac2_2 = colors.neutral_purple,
	ac2_3 = colors.faded_purple,
}

local separator = {
	left  = '▐', -- ▐    
	right = '▌', -- ▌    
}

local filename = require('tabby.filename')

local cwd = function()
	return ' ' .. vim.fn.fnamemodify(vim.fn.getcwd(), ':t') .. ' '
end
 
local tabname = function(tabid)
	return vim.api.nvim_tabpage_get_number(tabid)
end

local gitbranch = function()
	-- get branch name from lualine function
	local branch = require('lualine.components.branch')
	local branch_name = branch.git_branch

	if branch_name == nil or branch_name == '' then
		return ''
	else
		return '  ' .. branch_name .. ' '
	end
end

local line = {
	hl = { fg = palette.white, bg = palette.bg },
	layout = 'active_wins_at_tail',
	head = {
		-- { separator.left, hl = { fg = palette.ac1_1 } },
		{ cwd, hl = { fg = palette.bg1, bg = palette.ac1_1, style = 'bold' } },
		{ gitbranch, hl = { fg = palette.bg1, bg = palette.ac1_2, style = 'bold' } },
		{ separator.right, hl = { fg = palette.ac1_2, bg = palette.bg0 } },
	},
	active_tab = {
		label = function(tabid)
			return {
				'  ' .. tabname(tabid) .. ' ',
				hl = { fg = palette.bg1, bg = palette.ac1_3, style = 'bold' },
			}
		end,
		left_sep = { separator.left, hl = { fg = palette.ac1_3, bg = palette.bg0 } },
		right_sep = { separator.right, hl = { fg = palette.ac1_3, bg = palette.bg0 } },
	},
	inactive_tab = {
		label = function(tabid)
			return {
				'  ' .. tabname(tabid) .. ' ',
				hl = { fg = palette.white, bg = palette.bg2, style = 'italic' },
			}
		end,
		left_sep = { separator.left, hl = { fg = palette.bg2, bg = palette.bg0 } },
		right_sep = { separator.right, hl = { fg = palette.bg2, bg = palette.bg0 } },
	},
	top_win = {
		label = function(winid)
			return {
				'  ' .. filename.unique(winid) .. ' ',
				hl = { fg = palette.bg1, bg = palette.ac2_2, style = 'bold' },
			}
		end,
		left_sep = { separator.left, hl = { fg = palette.ac2_2, bg = palette.bg0 } },
		right_sep = { separator.right, hl = { fg = palette.ac2_2, bg = palette.bg0 } },
	},
	win = {
		label = function(winid)
			return {
				'  ' .. filename.unique(winid) .. ' ',
				hl = { fg = palette.bg1, bg = palette.bg2 },
			}
		end,
		left_sep = { separator.left, hl = { fg = palette.bg2, bg = palette.bg0 } },
		right_sep = { separator.right, hl = { fg = palette.bg2, bg = palette.bg0 } },
	},
	tail = {
		{ separator.left, hl = { fg = palette.ac2_1, bg = palette.bg0 } },
		{ '   ', hl = { fg = palette.bg1, bg = palette.ac2_1 } },
		-- { separator.right, hl = { fg = palette.ac2_1 } },
	},
}

require('tabby').setup({ tabline = line })
EOF
" }}}

" Telescope {{{
lua << EOF
require('telescope').setup({
  defaults = {
    layout_config = {
      vertical = { width = 0.9 },
      horizontal = { width = 0.9 },
      -- other layout configuration here
    },
    -- other defaults configuration here
  },
  -- other configuration values here
})
EOF
" }}}

" Ale linter {{{
let g:ale_fixers = { 'javascript': ['prettier-eslint', 'prettier', 'eslint'], 'graphql': [ 'eslint', 'prettier', 'gqlint' ] }
let g:ale_sign_error = '🛑'
let g:ale_sign_warning = '⚠️'
" }}}

" }}}

" Colors {{{
syntax enable
filetype plugin on
set termguicolors
colorscheme gruvbox
hi Normal guibg=NONE ctermbg=NONE
lua require'colorizer'.setup()
" }}}

" Tabs And Spaces {{{
set shiftwidth=2    " # of spaces to use for each step of (auto)indent (>>, <<)
set tabstop=2       " # of spaces that a <Tab> counts for
set softtabstop=2   " # of spaces that a <Tab> counts while editing
set noexpandtab     " Insert mode: Disable inserting spaces for tabs
" }}}

" File Find {{{
set path+=**
set wildmenu
set wildignore+=**/node_modules/**
set hidden
" }}}

" UI {{{
set number
set relativenumber
set showcmd
set showmatch
set nocompatible
set mouse=a
set noswapfile
set list
set listchars=tab:▶\ ,precedes:↪,extends:↪,space:•,trail:■
set nowrap
set linebreak
set noshowmode
set spell
set clipboard=unnamed

" }}}

" File Explorer {{{
let g:netrw_liststyle = 3 " show tree listing
let g:netrw_preview = 1   " open splits to the right
let g:netrw_winsize = 25  " 25%
let g:netrw_banner = 0    " disable banner
" }}}

" Searching {{{
noh
set incsearch
set hlsearch
set ignorecase
set smartcase " case-insensitive when using lowercase; otherwise, case-sensitive
" }}}

" Section Folding {{{
set foldenable
set foldlevelstart=10
" }}}

" Remaps {{{
let mapleader = " "

" Easier Escape from Insert Mode
inoremap jk <Esc>

" Windows
" Focus current window to full screen
nnoremap <silent> <C-w>F :wincmd _ \| :wincmd \|<CR>
" Make all splits equal; should do the opposite of <C-w>F
nnoremap <silent> <C-w>f :wincmd =<CR>

" Text Wrapping
nnoremap <leader>z :set wrap!<CR>

" open config files
nnoremap <leader>ve :edit $MYVIMRC<CR>
nnoremap <leader>ze :edit ~/.zshrc<CR>

" Fuzzy Finder
nnoremap <silent> <C-p> :Telescope find_files find_command=rg,--hidden,--files prompt_prefix=\ 🔍\ <CR>
nnoremap <silent> <leader>ff :Telescope git_files     prompt_prefix=\ 🔍\ <CR>
nnoremap <silent> <leader>fg :Telescope live_grep     prompt_prefix=\ 🔍\ <CR>
nnoremap <silent> <leader>fb :Telescope buffers       prompt_prefix=\ 🔍\ <CR>
nnoremap <silent> <leader>fh :Telescope help_tags     prompt_prefix=\ 🔍\ <CR>
nnoremap <silent> <leader>s  :Telescope spell_suggest prompt_prefix=\ ✅\ <CR>

" lua require('telescope.builtin').find_files({layout_strategy='vertical',layout_config={width=0.9}})

" Prettier
nnoremap <silent> <leader>f :!prettier --write %<CR><CR>

" Folding/Unfolding
nnoremap <silent> <tab> za

" Escape to normal mode in terminal mode
tnoremap <ESC> <C-\><C-n>

" Lsp
nnoremap K           :lua vim.lsp.buf.hover()<CR>
nnoremap <leader>K   :lua vim.lsp.diagnostic.show_line_diagnostics()<CR>
nnoremap <leader>gd  :lua vim.lsp.buf.definition()<CR>
nnoremap <leader>gi  :lua vim.lsp.buf.implementation()<CR>
nnoremap <leader>gs  :lua vim.lsp.buf.signature_help()<CR>
nnoremap <leader>gr  :lua vim.lsp.buf.references()<CR>
nnoremap <leader>rn  :lua vim.lsp.buf.rename()<CR>
nnoremap <leader>ca  :lua vim.lsp.buf.code_action()<CR>
nnoremap [v          :lua vim.diagnostic.goto_prev()<CR>
nnoremap ]v          :lua vim.diagnostic.goto_next()<CR>

" Git
nnoremap <leader>gb :G blame<CR>

" Disable highlight
nnoremap <ESC> :noh<CR>

" Open personal wiki index page
nnoremap <leader>ww :edit ~/vimwiki/index.md<CR>
" Open personal wiki diary page
nnoremap <leader>w<leader>w :edit ~/vimwiki/diary/diary.md<CR>

" compile markdown to html
noremap <leader>p :!pandoc %:p
			\ --css $HOME/dotfiles/pandoc/mvp.css
			\ --template $HOME/dotfiles/pandoc/template.html
			\ --output /tmp/pandoc-markdown-preview.html
			\ --to html
			\ --standalone
			\ --mathjax
			\ --highlight-style tango
			\ && open /tmp/pandoc-markdown-preview.html<CR><CR>

" }}}

" File Specific Commands {{{

" follow markdown links
au FileType markdown nnoremap <buffer> <CR> :call FollowMarkdownLink()<CR>
" go backwards
au FileType markdown nnoremap <buffer> <BS> <C-o>
" align tables using Tabular
au FileType markdown nnoremap <buffer> <leader>a :Tabularize /\|<CR>

" }}}

" Commands {{{

" Insert current date into buffer.
" This will insert the date in a new line after the current cursor
" The ! lets vim override the previous version of the command when resourcing
" this file
command! Datenow execute "put=strftime(\\\"%Y-%m-%d\\\")"

" Put matched groups in search into register
" for stringing multiple objects use:
" %s//\=setreg('A', submatch(1) . ": " . submatch(2), "V")/n

command! GetMatch execute "%s//\=setreg('A', submatch(1), \"V\")/n"

" }}}

" Functions {{{

" Exec {{{
" call as follows `:put =Exec('command')`. e.g. `:put =Exec('ls')`
function! Exec(command)
	redir => output
	silent exec a:command
	redir END
	return output
endfunction!
" }}}

" FollowMarkdownLink {{{
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
" }}}

" TextEnableCodeSnip {{{
" From https://vim.fandom.com/wiki/Different_syntax_highlighting_within_regions_of_a_file
function! TextEnableCodeSnip(filetype, start, end) abort
	" let start = '^\s*```'.a:filetype
	" let end = "^\s*```"
	let textSnipHl = "Comment"

	let ft=toupper(a:filetype)
	let group='textGroup'.ft
	if exists('b:current_syntax')
		let s:current_syntax=b:current_syntax
		" Remove current syntax definition, as some syntax files (e.g. cpp.vim)
		" do nothing if b:current_syntax is defined.
		unlet b:current_syntax
	endif
	execute 'syntax include @'.group.' syntax/'.a:filetype.'.vim'
	try
		execute 'syntax include @'.group.' after/syntax/'.a:filetype.'.vim'
	catch
	endtry
	if exists('s:current_syntax')
		let b:current_syntax=s:current_syntax
	else
		unlet b:current_syntax
	endif
	execute 'syntax region textSnip'.ft.' matchgroup='.textSnipHl.' keepend start="'.a:start.'" end="'.a:end.'" contains=@'.group
endfunction
" }}}

" My_orgmode {{{
" The following function tries to implement execution of a markdown code blocks
" A bulk of the vimscript here is "borrowed" from vim-markdown by gabrielelana
" I have tried to trim the code to fit my particular needs and have made a few
" additions as well.
function! My_orgmode ()
	" regex for start and end of fenced code blocks
	let upper_delimiter = '^\s*`\{3,}\(\w\+\)\%(\s.*$\|$\)'
	let lower_delimiter = '^\s*`\{3,}\s*$'

	" preoperties to keep track of populated with default values
	let code_block = {
		\ 'from': 0,
		\ 'to': 0,
		\ 'language': 'txt',
		\ 'indentation': ''
	\ }

	" get current position
	let initial_position = getpos('.')
	" make copy of initial_position
	let search_position = copy(initial_position)
	let search_position[1] = a:firstline
	let search_position[2] = 0
	cal setpos('.', search_position)

	" get line number for previous code block end
	let end_code_block_backward = search(lower_delimiter, 'cbnW')
	" get line number for closest code block start
	let start_code_block_backward = search(upper_delimiter, 'cbnW')
	" get line number for closest code block end
	let end_code_block_forward = search(lower_delimiter, 'cnW')

	" whether code block was found
	let found_code_block =
		\ start_code_block_backward > 0 && end_code_block_forward > 0
	" whether current line is between two code blocks
	let between_two_code_blocks =
		\ start_code_block_backward < end_code_block_backward &&
		\ end_code_block_backward <= a:firstline
	" whether current line is within a code block
	let starting_inside_code_block =
		\ found_code_block &&
		\ !between_two_code_blocks &&
		\ start_code_block_backward <= a:firstline &&
		\ end_code_block_forward >= a:firstline

	" get language for code block
	let code_block_lang = substitute(
		\ getline(start_code_block_backward),
		\ upper_delimiter, '\1', '')

	" get indentation level for code block
	let code_block_indent = substitute(
		\ getline(start_code_block_backward),
		\ '\(^\s*\).\+$', '\1', '')

	" If we are not inside a code block, exit
	if !starting_inside_code_block
		echo "Not inside a code block"
		return
	endif

	" update properties and continue
	let code_block['language'] = code_block_lang
	let code_block['indentation'] = code_block_indent
	let code_block['back_to_position'] = initial_position
	let code_block['back_to_position'][1] = start_code_block_backward
	let code_block['back_to_position'][2] = 0
	let code_block['from'] = start_code_block_backward + 1
	let code_block['to'] = end_code_block_forward - 1

	" set default file extension as language name
	let code_block['file_extension'] = '.' . code_block['language']

	" if known extension exists in list, update
	if has_key(s:extensions_and_envs, code_block['language'])
		let code_block['file_extension'] =
			\ s:extensions_and_envs[code_block['language']][0]
	endif

	" create temp file with extension
	let code_block['file_path'] = tempname() . code_block['file_extension']
	" extract code block contents
	let code_block['content'] = getline(code_block['from'], code_block['to'])

	" unindent code block contents (based on full block indent)
	let code_block['content'] = map(
			\ code_block['content'],
			\ 'substitute(v:val, ''^' . code_block['indentation'] . ''', '''', ''g'')'
		\ )

	" save code block contents to temp file
	call writefile(code_block['content'], code_block['file_path'])

	" find code environment
	let code_block['env'] = ''
	if has_key(s:extensions_and_envs, code_block['language'])
		let code_block['env'] =
			\ s:extensions_and_envs[code_block['language']][1]
	else
		echo "No specified environment for " . code_block['language']
		return
	endif

	" path to where code output is stored
	let code_block['output_file'] = '/home/mushfiq/downloads/out.txt'

	" execute code in environment and save to output file
	" TODO: handle errors in output
	call system(
		\   code_block['env'] . ' '
		\ . code_block['file_path']
		\ . ' > ' . code_block['output_file'])
	
	" write output file contents back into original markdown file right after
	" the code block. TODO: a result block with specific syntax could be created
	" for this and if one doesn't exist, it will be created. If one exists
	" however, its contents will have to be replaced

	" starting delimiter
	let code_block['output'] = ['```solution']
	" code block result contents as a list
	let code_block['output'] += readfile(code_block['output_file'])
	" ending delimiter and newline
	let code_block['output'] += ['```', '']

	" indent the result code block as necessary
	let code_block['output'] = map(
		\ code_block['output'],
		\ 'substitute(v:val, ''^'', ''' . code_block['indentation'] . ''', ''g'')'
	\ )

	" insert result after code block
	call append(end_code_block_forward + 1, code_block['output'])

endfunction

let s:extensions_and_envs = {
	\ 'javascript': ['.js', 'node'],
	\ 'js': ['.js', 'node'],
	\ 'python': ['.py', 'python3'],
	\ 'py': ['.py', 'python3']
\ }

" }}}

" }}}

" Custom Universal Highlight Groups (Need to be last) {{{

" Indent Blankline Highlight Groups
" hi! indentBlanklinePrimary guifg=red guibg=#282828
" hi! indentBlanklineSecondary guifg=red guibg=#484848

" Neovim LSP virtual diagnostics 
" hi! LspDiagnosticsDefaultError guifg=#FB4934
" hi! LspDiagnosticsDefaultWarning guifg=#FABD2F
" hi! LspDiagnosticsDefaultInformation guifg=#83A598
" hi! LspDiagnosticsDefaultHint guifg=#8EC07C
hi! LspDiagnosticsDefaultError guifg=#CC241D
hi! LspDiagnosticsDefaultWarning guifg=#D79921
hi! LspDiagnosticsDefaultInformation guifg=#458588
hi! LspDiagnosticsDefaultHint guifg=#689D6A

" GitGutter
hi! GitGutterAdd guifg=#b8bb26 guibg=#
hi! GitGutterChange guifg=#8ec07c guibg=#
hi! GitGutterDelete guifg=#fb4934 guibg=#
hi! GitGutterChangeDelete guifg=#8ec07c guibg=#fb4934
" remove both colors from regular signcolumn
hi! SignColumn guifg=# guibg=#

" }}}

" vim:foldmethod=marker:foldlevel=0:norelativenumber
