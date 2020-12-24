"=============================================================================
" NEOVIM CONFIG
"=============================================================================

" Plugins {{{
call plug#begin('~/.config/nvim/plugged')
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'caksoylar/vim-mysticaltutor'
Plug 'tpope/vim-fugitive'
Plug 'digitaltoad/vim-pug'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'leafgarland/typescript-vim'
" Plug 'Valloric/YouCompleteMe'
Plug 'vimwiki/vimwiki'
Plug 'mbbill/undotree'
Plug 'morhetz/gruvbox'
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
" Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install' }
Plug 'junegunn/goyo.vim'
Plug 'glacambre/firenvim', {'do': {_ -> firenvim#install(0)}}
call plug#end()
" }}}

" Colors {{{
syntax enable
filetype plugin on
set termguicolors
colorscheme gruvbox
let g:airline_theme='base16_bright'
hi Normal guibg=NONE ctermbg=NONE
" }}}

" Tabs And Spaces {{{
set shiftwidth=2
set tabstop=2
set softtabstop=2
set expandtab
set noswapfile
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
nnoremap <space> za
" }}}

" Powerline Fonts {{{
let g:airline_powerline_fonts = 1
" }}}

" Remaps {{{
let mapleader = ","
nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>
nnoremap <leader>z :set wrap!<CR>
nnoremap <leader>pv :wincmd v<bar> :Ex <bar> :vertical resize 30<CR>
nnoremap <silent> <C-p> :FZF -m<CR>
" }}}

" Coc Settings {{{

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ SID>check_back_space() ? "\<TAB>" :
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

" VimWiki {{{
let g:vimwiki_list = [{'path':'/mnt/c/Users/mushf/vimwiki'}]
" }}}

" vim:foldmethod=marker:foldlevel=0
