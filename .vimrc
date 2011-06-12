" Forget VI it's <current year>!
set nocompatible

" Pathogen
" Needed on some linux distros.
" see http://www.adamlowe.me/2009/12/vim-destroys-all-other-rails-editors.html
call pathogen#helptags()
call pathogen#runtime_append_all_bundles()

" Generic VIM settings

set nobackup
set nowritebackup
set history=50 " keep 50 lines of command line history

" Search
set incsearch " do incremental searching
set hlsearch
set ignorecase
set smartcase

let mapleader = ","
nnoremap <Leader><space> a<c-x><c-o>
" Clear search highlight
nnoremap <Leader>h :noh<cr>
" Delete trailing spaces
nnoremap <Leader>b :silent :%s/\s\+$//<cr>:noh<cr>``

" Go fullscreen
" set fu

set ruler " show the cursor position all the time

" tabs
set ts=4
set sw=4
set expandtab
set smarttab

" Colors and fonts
colorscheme vividchalk

" Nicer status line
set statusline=%F%m%r%h%w\ [%{&ff}/%Y]%=[%04l,%04v][%p%%/%L]
set laststatus=2

" Use console dialogs
set guioptions+=c
set showcmd " display incomplete commands

" Display extra whitespace
nmap <Leader>l :set list!<CR>
set list listchars=tab:»·,trail:·

" Tab completion options
" (only complete to the longest unambiguous match, and show a menu)
set completeopt=menu,preview
" set wildmode=list:longest,list:full
set wildchar=<Tab> wildmenu wildmode=full
set complete=.,t

set cf  " Enable error files & error jumping.
set clipboard+=unnamed  " Yanks go on clipboard instead.

set encoding=utf-8
syntax enable
filetype plugin indent on
au FileType php set omnifunc=phpcomplete

" Disable autoindent on paste
nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>
set showmode

" Mappings

" - Add to ZZ and ZQ builtins
nnoremap ZW :w<CR>
" - Tabs - switch to next tab
nnoremap <F6> gT
" - Buffers
nnoremap <silent> <F11> :BufExplorer<CR>
nnoremap <silent> <F12> :bn<CR>


