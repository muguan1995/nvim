" _ __ ___  _   _ _ __   ___  _____   _(_)_ __ __
"| '_ ` _ \| | | | '_ \ / _ \/ _ \ \ / / | '_ ` _ \
"| | | | | | |_| | | | |  __/ (_) \ V /| | | | | | |
"|_| |_| |_|\__, |_| |_|\___|\___/ \_/ |_|_| |_| |_|
"           |___/


" ===
" === Auto load for first time uses
" ===
if empty(glob('~/.config/nvim/autoload/plug.vim'))
       silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs 
                      \https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
       autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" ===
" === System
" ===
set encoding=utf-8
let &t_ut=''
set autochdir
let mapleader=" "

" ===
" === Basic Mapping
" ===

" Save & quit
noremap Q :q<CR>
noremap W :w<CR>
noremap R :source $MYVIMRC<CR>

"split move
noremap <LEADER><right> <C-w>l
noremap <LEADER><left> <C-w>h
noremap <LEADER><down> <C-w>j
noremap <LEADER><up> <C-w>k
"split resize
noremap <C-k> :res +5<CR>
noremap <C-j> :res -5<CR>
noremap <C-l> :vertical resize+5<CR>
noremap <C-h> :vertical resize-5<CR>
"split
noremap s<right> :set splitright<CR>:vsplit<CR>
noremap s<down> :set splitbelow<CR>:split<CR>
"switch tabe 
noremap th :tabp<CR>
noremap tl :tabn<CR>

"Cursor shape
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_SR = "\<Esc>]50;CursorShape=2\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

set nu
syntax on
set wildmenu

set hlsearch
set incsearch
exec "nohlsearch"
set ignorecase
set smartcase
set scrolloff=5

set nocompatible
filetype on
filetype indent on
filetype plugin on
filetype plugin indent on
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set tw=0
set indentexpr=
set list
set listchars=tab:▸\ ,trail:▫
set foldmethod=indent
set foldlevel=99
set laststatus=2

call plug#begin('~/.config/nvim/plugged')

Plug 'https://github.com/vim-airline/vim-airline'
Plug 'https://github.com/connorholyday/vim-snazzy'
Plug 'https://github.com/scrooloose/nerdtree'

" HTML, CSS, JavaScript,JSON, etc.
Plug 'elzr/vim-json'
Plug 'hail2u/vim-css3-syntax'
Plug 'pangloss/vim-javascript' ", { 'for' :['javascript', 'vim-plug'] }
Plug 'jelera/vim-javascript-syntax'

"auto completion
Plug 'neoclide/coc.nvim', {'branch': 'release'}

"Python
Plug 'tmhedberg/SimpylFold'  "折叠代码
Plug 'Vimjas/vim-python-pep8-indent', { 'for' :['python', 'vim-plug'] } "缩进
Plug 'numirias/semshi', { 'do': ':UpdateRemotePlugins' } "高亮


call plug#end()

"""
"NerdTree
"""
map ff :NERDTreeToggle<CR>
let NERDTreeMapOpenExpl = ""
let NERDTreeMapUpdir = ""
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

"""
"coc
"""
"fix the most annoying bug that coc has
silent! au BufEnter,BufRead,BufNewFile * silent! unmap if
let g:coc_global_extensions = ['coc-python', 'coc-vimlsp', 'coc-emmet', 'coc-html', 'coc-json', 'coc-css', 'coc-tsserver', 'coc-yank', 'coc-lists', 'coc-gitignore', 'coc-omnisharp']
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}
" use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]    =~ '\s'
endfunction
inoremap <silent><expr> <Tab>
                        \ pumvisible() ? "\<C-n>" :
                        \ <SID>check_back_space() ? "\<Tab>" :
                        \ coc#refresh()
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <silent><expr> <c-space> coc#refresh()











