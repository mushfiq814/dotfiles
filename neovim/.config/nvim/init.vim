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
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Plug 'neovim/nvim-lspconfig'
" Plug 'anott03/nvim-lspinstall'
Plug 'leafgarland/typescript-vim'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'mattn/emmet-vim'
Plug 'pangloss/vim-javascript'
Plug 'cespare/vim-toml'
" Plug 'peitalin/vim-jsx-typescript'
" Plug 'Valloric/YouCompleteMe'
" }}}

" Navigation Plugins {{{
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'liuchengxu/vim-which-key'
" }}}

" Colorschemes and UI {{{
Plug 'morhetz/gruvbox'
Plug 'caksoylar/vim-mysticaltutor'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'junegunn/goyo.vim'
" Plug 'jkramer/vim-checkbox'
Plug 'mhinz/vim-startify'
Plug 'norcalli/nvim-colorizer.lua'
" }}}

" Development Tools {{{
Plug 'tpope/vim-fugitive'
Plug 'vimwiki/vimwiki'
Plug 'mbbill/undotree'
" Plug 'godlygeek/tabular'
" Plug 'plasticboy/vim-markdown'
Plug 'tbabej/taskwiki'
Plug 'airblade/vim-gitgutter'
Plug 'majutsushi/tagbar'
Plug 'tpope/vim-surround'
Plug 'mg979/vim-visual-multi'
Plug 'tpope/vim-commentary'
" Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install' }
" Plug 'glacambre/firenvim', {'do': {_ -> firenvim#install(0)}}
" }}}

call plug#end()
" }}}

" Plugin Settings {{{

" Coc Settings {{{

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
	let col = col('.') - 1
	return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
	inoremap <silent><expr> <c-space> coc#refresh()
else
	inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
	\: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
" }}}

" Neovim Lsp {{{
" lua << EOF
" require'lspconfig'.tsserver.setup{}
" EOF
" }}}

" VimWiki {{{
let g:vimwiki_list = [{'path':'/mnt/c/Users/mushf/vimwiki',
	\ 'syntax': 'markdown', 'ext': '.md'}]
let g:vimwiki_global_ext = 0
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

" Powerline/Airline {{{
let g:airline_powerline_fonts = 1
let g:airline_theme='base16_bright'
" }}}

" Fuzzy Finder {{{
let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.8 } }
let $FZF_DEFAULT_OPTS = '--reverse'
" }}}

" Colorizer {{{
" Colorizer init settings in Colors section
" }}}

" Vim-Markdown {{{
let g:markdown_fenced_languages = ['css', 'javascript', 'js=javascript', 'json=javascript']
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
set foldnestmax=10
set foldmethod=syntax
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

" set foldmethod for zshrc
au BufRead,BufNewFile *.zshrc set foldmethod=marker foldlevel=0

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

" vim:foldmethod=marker:foldlevel=0