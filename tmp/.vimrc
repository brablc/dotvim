"" Forget VI - must be first command
set nocompatible

" Pathogen - processes bundles as if they were installed properly
filetype off
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

"" Generic VIM settings

set history=50 " keep 50 lines of command line history
set backspace=indent,eol,start
"set foldenable
set viewoptions=folds,options,cursor,unix,slash
set pastetoggle=<F2>
set showmode
"set number
set wildignore+=*.gif,*.jpg,*.png,,tmp,cache,rwproxy

" Search
set incsearch " do incremental searching
set hlsearch
set ignorecase
set smartcase

set ruler " show the cursor position all the time

" Tabs
set ts=4
set sw=4
set expandtab
set smarttab

set nowrap

" Nicer status line
set statusline=%F%m%r%h%w\ [%{&ff}/%Y]%=[%04l,%04v][%p%%/%L]
set laststatus=2

" Use console dialogs
set guioptions+=c
set showcmd " display incomplete commands

set nolist
if has("gui_running")
    " Maximize gvim window.
    set lines=999 columns=999
    colorscheme solarized
    set background=dark 
else
    set listchars=tab:»·,trail:·
    colorscheme blue
endif


" Tab completion options
" (only complete to the longest unambiguous match, and show a menu)
set completeopt=menu,preview
set wildmenu
" set wildchar=<Tab> 
set wildmode=list:longest,list:full
set complete=.,t

set cf  " Enable error files & error jumping.
set clipboard+=unnamed  " Yanks go on clipboard instead.

set encoding=utf-8
filetype plugin indent on
syntax enable
au FileType php set omnifunc=phpcomplete


" Leader Mappings

let mapleader = ","
" - Completion?
nnoremap <Leader><space> a<c-x><c-o>
" - Clear search highlight
nnoremap <silent> <Leader>h :nohlsearch<cr>
" - Delete trailing blanks (spaces)
nnoremap <Leader>b :silent :%s/\s\+$//<cr>:noh<cr>``
" - Display extra whitespace
nnoremap <Leader>l :set list!<cr>
" - Chage dir to the current path
nnoremap <Leader>p :cd %:p:h<cr>
" - Search current word
nnoremap <Leader>a :Ack <cword><cr>
" - Source vimrc
nnoremap <Leader>ve :edit ~/.vim/.vimrc<cr>
nnoremap <Leader>vs :source ~/.vim/.vimrc<cr>

map <Leader>f <Esc>:EnableFastPHPFolds<cr>
map <Leader>u <Esc>:DisablePHPFolds<cr>

" Regular Mappings

" - Add to ZZ and ZQ builtins
nnoremap ZW :w<cr>
" - Tabs - switch to next tab
nnoremap <F6> gt
" - Buffers
nnoremap <silent> <F11> :BufExplorer<cr>
nnoremap <silent> <F12> :bn<cr>
" - MRU
nnoremap <F10> :MRU<cr>

" - visual shifting (does not exit Visual mode)
vnoremap < <gv
vnoremap > >gv
