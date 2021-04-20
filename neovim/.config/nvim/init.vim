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
Plug 'anott03/nvim-lspinstall'
Plug 'hrsh7th/nvim-compe'
" }}}

" Navigation Plugins {{{
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'liuchengxu/vim-which-key'
" }}}

" Colorschemes and UI {{{
Plug 'morhetz/gruvbox'
Plug 'hoob3rt/lualine.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'junegunn/goyo.vim'
Plug 'mhinz/vim-startify'
Plug 'norcalli/nvim-colorizer.lua'
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

local system_name
if vim.fn.has("mac") == 1 then
	system_name = "macOS"
elseif vim.fn.has("unix") == 1 then
	system_name = "Linux"
elseif vim.fn.has('win32') == 1 then
	system_name = "Windows"
else
	print("Unsupported system for sumneko")
end

-- set the path to the sumneko installation; if you previously installed via the now deprecated :LspInstall, use
local sumneko_root_path = vim.fn.stdpath('cache')..'/lspconfig/sumneko_lua/lua-language-server'
local sumneko_binary = sumneko_root_path.."/bin/"..system_name.."/lua-language-server"

require'lspconfig'.sumneko_lua.setup {
	cmd = { sumneko_binary, "-E", sumneko_root_path .. "/main.lua" };
	settings = {
		Lua = {
			runtime = {
				-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
				version = 'LuaJIT',
				-- Setup your lua path
				path = vim.split(package.path, ';'),
			},
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = { 'vim' },
			},
			workspace = {
				-- Make the server aware of Neovim runtime files
				library = {
					[vim.fn.expand('$VIMRUNTIME/lua')] = true,
					[vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
				},
			},
			-- Do not send telemetry data containing a randomized but unique identifier
			telemetry = {
				enable = false,
			},
		},
	},
}
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
    buffer = true;
    calc = true;
    vsnip = true;
    nvim_lsp = true;
    nvim_lua = true;
    spell = true;
    tags = true;
    snippets_nvim = true;
    treesitter = true;
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
highlight GitGutterAdd guifg=#009900 ctermfg=Green
highlight GitGutterChange guifg=#bbbb00 ctermfg=Yellow
highlight GitGutterDelete guifg=#ff2222 ctermfg=Red
let g:gitgutter_enabled = 1
set updatetime=100
" }}}

" Startify {{{
" Heading
let g:startify_custom_header = [
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

gruvbox.terminal = gruvbox.normal

local function inactive_txt()
	return [[INACTIVE]]
end

require('lualine').setup {
	options = {
		theme = gruvbox,
		section_separators = { '', '' },
		component_separators = { '|', '|' },
		icons_enabled = true,
	},
	sections = {
		lualine_a = { { 'mode', upper = true, }, },
		lualine_b = { { 'branch', icon = '', }, { 'diff', color_added = colors.blue, color_modified = colors.green, color_removed = colors.red }, },
		lualine_c = { { 'filename', file_status = true, full_path = true, shorten = true, }, },
		lualine_x = { { 'diagnostics', sources = { 'nvim_lsp', }, symbols = { error = '🔴', warn = '🟡', info = '🔵', }, }, 'encoding', 'fileformat', 'filetype' },
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

" integrate with windows clipboard
let s:clip = '/mnt/c/Windows/System32/clip.exe'
if executable(s:clip)
	augroup WSLYank
		autocmd!
		autocmd TextYankPost * call system(s:clip, @0)
	augroup END
endif

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
set smartcase " case-insensitive when using lowercase; otherwise, case-sensitive
" }}}

" Section Folding {{{
set foldenable
set foldlevelstart=10
" }}}

" Remaps {{{
let mapleader = ","

" Easier Escape from Insert Mode
inoremap jk <Esc>

" Windows
nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>

" Open File Explorer on the side
nnoremap <leader>pv :wincmd v<bar> :Ex <bar> :vertical resize 30<CR>

" Text Wrapping
nnoremap <leader>z :set wrap!<CR>

" open config files
nnoremap <leader>ve :edit $MYVIMRC<CR>
nnoremap <leader>ze :edit ~/.zshrc<CR>

" Fuzzy Finder
nnoremap <silent> <C-p> :GFiles<CR>

" Folding/Unfolding
nnoremap <space> za

" Escape to normal mode in terminal mode
tnoremap <ESC> <C-\><C-n>

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

" vim:foldmethod=marker:foldlevel=0
