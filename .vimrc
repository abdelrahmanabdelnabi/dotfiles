filetype plugin indent on

" change mapleader
let mapleader=" "

call plug#begin()
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'

" additional text objects
Plug 'wellle/targets.vim'

" Commenting multiple lines
Plug 'tpope/vim-commentary'

" mappings for common commands
Plug 'tpope/vim-unimpaired'

" working with variants of words +
" change between different cases (camel, snake, dash, underscore)
Plug 'tpope/vim-abolish'

" repeat plugin actions with .
Plug 'tpope/vim-repeat'

" correctly indent when pasting code
Plug 'sickill/vim-pasta'

" indentation guides
" Plug 'Yggdroot/indentLine'

" auto insert closing brackets/parens
" this must be loaded before vim-endwise
" for delimitMate_expand_cr to work
Plug 'Raimondi/delimitMate'

" for Ruby/Rails
Plug 'tpope/vim-rails'
Plug 'tpope/vim-endwise' " auto insert end keyword after if/def/do
Plug 'jgdavey/vim-blockle'

" syntax highlighting for javascript
" Plug 'pangloss/vim-javascript'

" syntax highlighting for typescript
Plug 'leafgarland/typescript-vim'
Plug 'Quramy/tsuquyomi'
Plug 'peitalin/vim-jsx-typescript'

" fuzzy search files
Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }

" whitespace highlighting
Plug 'ntpeters/vim-better-whitespace'

" jump to matching brackets/if/else using %
Plug 'tmhedberg/matchit'

" auto close html tags
Plug 'alvan/vim-closetag'

" customizable status line
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'rafi/awesome-vim-colorschemes'
Plug 'jpo/vim-railscasts-theme'
Plug 'morhetz/gruvbox'

" Mutliple cursors
" Plug 'terryma/vim-multiple-cursors'

" swap func arguments and lines
Plug 'machakann/vim-swap'

" Plug 'tmux-plugins/vim-tmux-focus-events'

" Linters
Plug 'w0rp/ale'

" file tree explorer on demand loading
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'mhinz/vim-startify'

" " coc
" Plug 'neoclide/coc.nvim', {'branch': 'release'}
" let g:coc_global_extensions = [
"   \ 'coc-tsserver',
"   \ 'coc-eslint',
"   \ 'coc-prettier',
"   \ 'coc-json'
"   \ ]

" Plug 'mlaursen/vim-react-snippets'
" Plug 'SirVer/ultisnips'

call plug#end()

set path+=$PWD/**
set nocompatible

" colors
set background=dark
set termguicolors
let g:gruvbox_italic=1
let g:gruvbox_bold=1
let g:gruvbox_contrast_dark='hard'
let g:gruvbox_contrast_light='soft'
colorscheme gruvbox

let NERDTreeQuitOnOpen = 1
let NERDTreeMinimalUI = 1

" don't auto close '<' with '>'. This will be handled by 'alvan/vim-closetag'.
let delimitMate_matchpairs = "(:),[:],{:}"
let delimitMate_expand_cr=1
let delimitMate_expand_space=1

" customize airline
let g:airline_section_y = ''
let g:airline_section_z = '%4l%#__restore__#%#__accent_bold#/%L%{g:airline_symbols.maxlinenr}%#__restore__# :%3v'
let g:airline_theme = 'gruvbox'

" customize mulicursor
" let g:multi_cursor_use_default_mapping=0

" " Default mapping
" let g:multi_cursor_start_word_key      = '<C-n>'
" let g:multi_cursor_select_all_word_key = '<A-n>'
" let g:multi_cursor_start_key           = 'g<C-n>'
" let g:multi_cursor_select_all_key      = 'g<A-n>'
" let g:multi_cursor_next_key            = '<C-n>'
" let g:multi_cursor_prev_key            = '<C-p>'
" let g:multi_cursor_skip_key            = '<C-x>'
let g:multi_cursor_quit_key            = '<Esc>'

" customize indentLine
let g:indentLine_char = '│'

" Return to last edit position when opening files (You want this!)
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case -g "!{node_modules/*,tags/*,bin/*,tmp/*,vendor/*,.git/*}" -- '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}), <bang>0)

" CTRL-A CTRL-Q to select all and build quickfix list

function! s:build_quickfix_list(lines)
  call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
  copen
  cc
endfunction

let g:fzf_action = {
  \ 'ctrl-q': function('s:build_quickfix_list'),
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

let $FZF_DEFAULT_OPTS = '--bind ctrl-a:select-all'

" """""""""""""""""""""""
" key mappings
" """""""""""""""""""""""

" vimrc handy shortcuts
:nnoremap <silent> <Leader>re :vsp ~/.vimrc<cr>
:nnoremap <silent> <Leader>rr :source ~/.vimrc<cr>

" for ctrl-p (jump to file) plugin: open files in version control and include
" untracked files
:map <C-p> :Files<CR>
" :map <C-p> :GFiles -c -o --exclude-standard --recurse-submodules<CR>
:nmap <C-B> :Buffers<CR>

" toggle file tree using <leader>e
nnoremap <silent> <Leader>e :NERDTreeToggle<CR>
nnoremap <silent> <Leader>f :NERDTreeFind<CR>

nmap ]g <Plug>(GitGutterNextHunk)
nmap [g <Plug>(GitGutterPrevHunk)

" Switch between the last two files
nnoremap <Leader><Leader> <C-^>

" copy and paste from system clipboard
noremap <Leader>y "+y
noremap <Leader>p "+p

" copy current line including file path and line number
nnoremap <silent> <leader>yy :let @+=expand("%").":".line(".")." ".getline(".")<cr>

" handy tab manipulation mappings
nmap <Leader>tn :tabnew<cr>
nmap <Leader>tc :tabclose<cr>
nmap <Leader>tm :tabmove
nnoremap <Leader>rg :Rg <C-r><C-w><CR>
nnoremap <silent> <Leader>tr :terminal<CR>

" vertical split
nmap <Leader>v :vsp<CR>

map Y y$
nnoremap c_ ct_
nnoremap d_ df_
nnoremap c. ct.
nnoremap d. df.

" easier window navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

noremap E $

" open Gstatus in a vertical split
nnoremap <leader>g :vertical Gstatus<cr>

" faster scrolling
nnoremap <c-y> 3<c-y>
nnoremap <c-e> 3<c-e>

" ALE config {{{
" use F4 to autformatting
let g:ale_fixers = { 'typescript': ['prettier', 'eslint'], 'javascript': ['prettier', 'eslint'], 'typescriptreact': ['prettier', 'eslint'], 'ruby': 'rubocop' }
noremap <F4> :ALEFix<CR>
let g:ale_javascript_prettier_options = '--single-quote'
let g:ale_typescript_prettier_options = '--single-quote'
let g:ale_typescriptreact_prettier_options = '--single-quote'

" Move between linting errors
nnoremap ]r :ALENextWrap<CR>
nnoremap [r :ALEPreviousWrap<CR>
" end ALE config }}}


"" CoC Config {{{
"" Don't pass messages to |ins-completion-menu|.
"set shortmess+=c

"" Always show the signcolumn, otherwise it would shift the text each time
"" diagnostics appear/become resolved.
"if has("patch-8.1.1564")
"  " Recently vim can merge signcolumn and number column into one
"  set signcolumn=number
"else
"  set signcolumn=yes
"endif

"" Use tab for trigger completion with characters ahead and navigate.
"" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
"" other plugin before putting this into your config.
"inoremap <silent><expr> <TAB>
"      \ pumvisible() ? "\<C-n>" :
"      \ <SID>check_back_space() ? "\<TAB>" :
"      \ coc#refresh()
"inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

"function! s:check_back_space() abort
"  let col = col('.') - 1
"  return !col || getline('.')[col - 1]  =~# '\s'
"endfunction

"" Use <c-space> to trigger completion.
"if has('nvim')
"  inoremap <silent><expr> <c-space> coc#refresh()
"else
"  inoremap <silent><expr> <c-@> coc#refresh()
"endif

"" CoC mappings
""
"" Use `[r` and `]r` to navigate diagnostics
"" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
"nmap <silent> [r <Plug>(coc-diagnostic-prev)
"nmap <silent> ]r <Plug>(coc-diagnostic-next)

"" GoTo code navigation.
"nmap <silent> gd <Plug>(coc-definition)
"nmap <silent> gy <Plug>(coc-type-definition)
"" nmap <silent> gi <Plug>(coc-implementation)
"nmap <silent> gr <Plug>(coc-references)

"" Use K to show documentation in preview window.
"nnoremap <silent> K :call <SID>show_documentation()<CR>

"function! s:show_documentation()
"  if (index(['vim','help'], &filetype) >= 0)
"    execute 'h '.expand('<cword>')
"  else
"    call CocAction('doHover')
"  endif
"endfunction

"" Highlight the symbol and its references when holding the cursor.
"autocmd CursorHold * silent call CocActionAsync('highlight')

"" Symbol renaming.
"nmap <leader>rn <Plug>(coc-rename)

"" Formatting selected code.
"" xmap <leader>f  <Plug>(coc-format-selected)
"" nmap <leader>f  <Plug>(coc-format-selected)

"" Add `:Format` command to format current buffer.
"command! -nargs=0 Format :call CocAction('format')
"noremap <F3> :Format<CR>

"" Add `:Fold` command to fold current buffer.
"command! -nargs=? Fold :call     CocAction('fold', <f-args>)

"" Add `:OR` command for organize imports of the current buffer.
"command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

"" Show all diagnostics.
"nnoremap <silent><nowait> <space>d  :<C-u>CocList diagnostics<cr>

"" End CoC config }}}

" use backspace in nomral mode
nnoremap <BS> X

" don't override the default register when deleting using 'x'
" noremap x "_x

" Use tab to jump between blocks, because it's easier
" WARNING: Ctrl + i and Tab are strictly equivalent, mapping tab will also map
" Ctrl + i, which will cause jumping forward in the jump list to not work
" nnoremap <tab> %
" vnoremap <tab> %

filetype plugin indent on

" automatically rebalance windows on vim resize
autocmd VimResized * :wincmd =

autocmd Filetype python setlocal tabstop=2 shiftwidth=2
autocmd Filetype ruby setlocal tabstop=2 shiftwidth=2
autocmd Filetype eruby setlocal tabstop=2 shiftwidth=2
autocmd Filetype typescript,typescriptreact setlocal tabstop=2 shiftwidth=2
autocmd Filetype html,vue setlocal tabstop=2 shiftwidth=2
autocmd Filetype yaml setlocal tabstop=2 shiftwidth=2
autocmd Filetype scss setlocal tabstop=2 shiftwidth=2

set autoindent " auto indentation
set showmatch " show matching parens
set shiftwidth=4
set tabstop=4
set expandtab " On pressing tab, insert 4 spaces
set smarttab
set smartcase
set cindent

set backspace=2 " Backspace deletes like most programs in insert mode
set nojoinspaces " Use one space, not two, after punctuation.
set nobackup
set nowritebackup
set noswapfile
set shell=/usr/bin/zsh
set clipboard=unnamedplus
" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=50

" Give more space for displaying messages.
" set cmdheight=2

" auto reload files if there are modified outside vim.
" (Does not replace current file it has been modified in vim.)
set autoread
au FocusGained,BufEnter * :checktime

set scrolloff=6 " start scrolling when we are 4 lines away from margin

" set relative number on by default
set number relativenumber

" set signcolumn to be always on
set signcolumn=yes

" enable mouse in all modes
set mouse=a

" set the g flag to search and replace by default
set gdefault

" highlight current line
set cursorline

" highlight search results
" set hlsearch

" clear the highlighted search result useful when hlsearch is enabled
nnoremap <silent> <cr> :noh<cr><cr>

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
set ttimeout notimeout ttimeoutlen=10

" show normal mode commands as they are being typed
" :set showcmd

" """""""""""""""""""""
" Javascript mappings
" """""""""""""""""""""
" au FileType javascript,vue,ts imap <c-l> console.log();<esc>hi

let g:UltiSnipsExpandTrigger="<c-l>"
let g:UltiSnipsJumpForwardTrigger="<c-i>"
let g:UltiSnipsJumpBackwardTrigger="<c-o>"

" for jumping between .ts and .html files of angular
autocmd Filetype typescript nnoremap <buffer> <Leader>a :e %<.html<CR>
autocmd Filetype html nnoremap <buffer> <Leader>a :e %<.ts<CR>
