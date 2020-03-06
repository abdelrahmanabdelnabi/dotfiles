filetype plugin indent on

" change mapleader
let mapleader=" "

call plug#begin()
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'

" additional text objects
Plug 'wellle/targets.vim'

" Commenting multiple lines
Plug 'tpope/vim-commentary'
"
" repeat plugin actions with .
Plug 'tpope/vim-repeat'

" correctly indent when pasting code
Plug 'sickill/vim-pasta'

" for Rails
Plug 'tpope/vim-rails'
Plug 'tpope/vim-endwise' " auto insert end keyword after if/def/do

" ctags list
Plug 'majutsushi/tagbar'

" autocomplete with tab
Plug 'ervandew/supertab'

" syntax highlighting for javascript
Plug 'pangloss/vim-javascript'

" syntax highlighting for typescript
Plug 'leafgarland/typescript-vim'

" fuzzy search files
Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf'

" whitespace highlighting
Plug 'ntpeters/vim-better-whitespace'

" auto insert closing brackets/parens
Plug 'Raimondi/delimitMate'
" jump to matching brackets/if/else using %
Plug 'tmhedberg/matchit'
" auto close html tags
Plug 'alvan/vim-closetag'

" customizable status line
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'rafi/awesome-vim-colorschemes'
Plug 'jpo/vim-railscasts-theme'


" Mutliple cursors
Plug 'terryma/vim-multiple-cursors'

" Linters
Plug 'w0rp/ale'

" file tree explorer on demand loading
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'Xuyuanp/nerdtree-git-plugin'

call plug#end()

" set clipboard=unnamed

" colors
set background=dark
colorscheme ayu
set termguicolors

let NERDTreeQuitOnOpen = 1
let NERDTreeMinimalUI = 1

" don't auto close '<' with '>'. This will be handled by 'alvan/vim-closetag'.
let delimitMate_matchpairs = "(:),[:],{:}"
" customize airline
let g:airline_section_y = ''
let g:airline_section_z = '%4l%#__restore__#%#__accent_bold#/%L%{g:airline_symbols.maxlinenr}%#__restore__# :%3v'


" """""""""""""""""""""""
" key mappings
" """""""""""""""""""""""

" for ctrl-p (jump to file) plugin
:map <C-p> :Files<CR>

" toggle file tree using <leader>e
nnoremap <silent> <Leader>e :NERDTreeToggle<CR>

" copy and paste from system clipboard
noremap <Leader>y "+y
noremap <Leader>p "+p
nmap <Leader>t :TagbarToggle<CR>

" easier window navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" don't override the default register when deleting using 'x'
" noremap x "_x

set autoindent " auto indentation
set showmatch " show matching parens
set shiftwidth=4
set tabstop=4
" On pressing tab, insert 4 spaces
set expandtab
set smarttab
set cindent
set noswapfile
set shell=/usr/bin/zsh

filetype plugin indent on

set scrolloff=4 " start scrolling when we are 4 lines away from margin

" Use tab to jump between blocks, because it's easier
" WARNING: Ctrl + i and Tab are strictly equivalent, mapping tab will also map
" Ctrl + i, which will cause jumping forward in the jump list to not work
" nnoremap <tab> %
" vnoremap <tab> %

" automatically rebalance windows on vim resize
autocmd VimResized * :wincmd =
autocmd Filetype python setlocal tabstop=2 shiftwidth=2
autocmd Filetype ruby setlocal tabstop=2 shiftwidth=2
autocmd Filetype eruby setlocal tabstop=2 shiftwidth=2
autocmd Filetype html setlocal tabstop=2 shiftwidth=2
autocmd Filetype yaml setlocal tabstop=2 shiftwidth=2

" set relative number on by default
set number relativenumber

" enable mouse in all modes
set mouse=a

" set the g flag to search and replace by default
set gdefault

" highlight current line
set cursorline

" highlight search results
" set hlsearch

" ignore case of search
set ignorecase

" show current file name in titlebar
set title

" open new splits to the right and below
set splitright
set splitbelow

" keep undo history between exits/reboot
set undodir=~/.vim/undo
set undofile

" to solve the lag when typing esc+O.
" ref: https://stackoverflow.com/questions/2158516/delay-before-o-opens-a-new-line
" see help :timeoutlen
set ttimeout notimeout ttimeoutlen=100

" show normal mode commands as they are being typed
" :set showcmd

" """""""""""""""""""""
" RTL and LTR switching
" """""""""""""""""""""
" Switch to English - mapping
nnoremap <Leader>> :<C-U>call EngType()<CR>
" Switch to Arabic - mapping
nnoremap <Leader>< :<C-U>call AraType()<CR>

" Switch to English - function
function! EngType()
" To switch back from Arabic
  set keymap= " Restore default (US) keyboard layout
  set norightleft
endfunction

" Switch to Arabic - function
function! AraType()
    set keymap=arabic "Modified keymap. File in ~/.vim/keymap/
    set rightleft
endfunction

