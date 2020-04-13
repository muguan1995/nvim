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
" === Create a _machine_specific.vim file to adjust machine specific stuff, like python interpreter location
" ===
let has_machine_specific_file = 1
if empty(glob('~/.config/nvim/_machine_specific.vim'))
	let has_machine_specific_file = 0
	silent! exec "!cp ~/.config/nvim/default_configs/_machine_specific_default.vim ~/.config/nvim/_machine_specific.vim"
endif
source ~/.config/nvim/_machine_specific.vim

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
noremap <C-q> :q!<CR>
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

Plug 'vim-airline/vim-airline'
Plug 'connorholyday/vim-snazzy'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'mhinz/vim-startify'

"Surround
Plug 'tpope/vim-surround'

"new terminal
Plug 'voldikss/vim-floaterm'
Plug 'itchyny/lightline.vim'

"side navigation
Plug 'scrooloose/nerdtree'

"commenter
Plug 'preservim/nerdcommenter'

" HTML, CSS, JavaScript,JSON, etc.
Plug 'elzr/vim-json'
Plug 'hail2u/vim-css3-syntax'
Plug 'pangloss/vim-javascript' ", { 'for' :['javascript', 'vim-plug'] }
Plug 'jelera/vim-javascript-syntax'

"auto completion
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

"Python
Plug 'tmhedberg/SimpylFold'  "折叠代码
Plug 'Vimjas/vim-python-pep8-indent', { 'for' :['python', 'vim-plug'] } "缩进
Plug 'numirias/semshi', { 'do': ':UpdateRemotePlugins','for' :['python', 'vim-plug'] } "高亮

" file navigation
Plug 'junegunn/fzf.vim'

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
set signcolumn=yes

"""
"NERDTree-git
"""
let g:NERDTreeIndicatorMapCustom = {
            \ "Modified": "✹",
            \ "Staged": "✚",
            \ "Untracked" : "✭",
            \ "Renamed" : "➜",
            \ "Unmerged": "═",
            \ "Deleted" : "✖",
            \ "Dirty" : "✗",
            \ "Clean" : "✔︎",
            \ "Unknown" : "?"
            \ }


"""
"ultisnips
"""
let g:UltiSnipsExpandTrigger="<c-b>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-e>"


"""
"fzf
"""
let g:fzf_preview_window = 'right:60%'
let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'

"""
"vim-floaterm
"""
let g:floaterm_position='center'
let g:floaterm_width=0.8
let g:floaterm_height=0.6
let g:floaterm_rootmarkers=['.project', '.git', '.hg', '.svn', '.root', '.gitignore']
let g:floaterm_autoinsert=v:true
hi FloatermNF guibg=black

nmap <M-+> :FloatermNew<cr>
nmap <M-=> :FloatermToggle<cr>
tnoremap <M-+> <c-\><c-n>:FloatermNew<cr>
tnoremap <M-=> <c-\><c-n>:FloatermToggle<cr>
au FileType floaterm tnoremap <M-h> <c-\><c-n>:FloatermPrev<CR>
au FIleType floaterm tnoremap <M-l> <c-\><c-n>:FloatermNext<CR>

nmap <leader>f :FloatermNew ranger<cr>
nmap <leader>g :FloatermNew lazygit<cr>

"""
"nerdcommenter
"""
let g:NERDSpaceDelims = 1
let g:NERDToggleCheckAllLines = 1
