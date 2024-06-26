"" Forget VI - must be first command
set nocompatible
set encoding=utf-8

filetype off

" Set .vim accordingly to loaded .vimrc
let g:vim_dir = fnamemodify($MYVIMRC, ":h").'/.vim'

" Solve problems with disappearing MRU?
let g:ctrlp_clear_cache_on_exit = 0
if executable("ag")
    set grepprg=ag\ --nogroup\ --nocolor
    let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif
" Store cache inside of .vim
let g:ctrlp_cache_dir = g:vim_dir.'/.ctrlp/'.$USER
" Search from external cwd
let g:ctrlp_working_path_mode = ''
" Store backup inside of .vim
let g:ncbackup_directory = g:vim_dir.'/.ncbackup/'.$USER
" On some computers ca for github is missing
let $GIT_SSL_NO_VERIFY = 'true' 

let &runtimepath = g:vim_dir . '/bundle/Vundle.vim' . ',' . &runtimepath
call vundle#rc(g:vim_dir.'/bundle')

call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" My Plugins here (original repos on github):

" DetectIndent
Plugin 'ciaranm/detectindent'
" MRU, file browser
Plugin 'ctrlpvim/ctrlp.vim'
" Grep like search
Plugin 'mileszs/ack.vim'
" Show list of opened buffers
Plugin 'markabe/bufexplorer'
" Check syntax when saving files
Plugin 'tomtom/checksyntax_vim'
" Manipulte surroundings (braces, tags, ...)
Plugin 'tpope/vim-surround'
" Match pairs with % key
Plugin 'vim-scripts/matchit.zip'
" Tab completion
Plugin 'ervandew/supertab'
Plugin 'tomtom/tlib_vim'
" Work with GIT
Plugin 'airblade/vim-gitgutter'
" CSV
Plugin 'chrisbra/csv.vim'

call vundle#end()

filetype plugin indent on
syntax enable
au FileType php set omnifunc=phpcomplete
autocmd BufReadPost * :DetectIndent

"" Generic VIM settings

let g:is_posix = 1 " allow posix shell proper coloring $()
set history=100 " keep 50 lines of command line history
set backspace=indent,eol,start
set nofoldenable
set viewoptions=options,cursor,unix,slash
set pastetoggle=<F2>
set showmode
" set number
set wildignore+=*.gif,*.jpg,*.png,tmp,cache,rwproxy

function! RestoreCursorPosition()
  if line("'\"") <= line("$")
    normal! g`"
    return 1
  endif
endfunction

augroup resCur
  autocmd!
  autocmd BufWinEnter * call RestoreCursorPosition()
augroup END

" Search
set incsearch " do incremental searching
set hlsearch
set ignorecase
set smartcase

set ruler " show the cursor position all the time

" Tabs
set ts=4
set sw=4
" set expandtab
set smarttab
set switchbuf=usetab

set nowrap

" Nicer status line
set statusline=%F%m%r%h%w\ [%{&ff}/%Y]%=[%b\ 0x%B][%04l,%04v][%p%%/%L]
set laststatus=2

" Use console dialogs
set guioptions+=c
set showcmd " display incomplete commands

set nolist
colorscheme blue

if has("gui_running")
    " Maximize gvim window.
    set lines=999 columns=999
else
    set listchars=tab:»·,trail:·
    set t_Co=256
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

" Leader Mappings
let mapleader = ","
let maplocalleader = ","

" - Clear search highlight
nnoremap <silent> <Leader>h :nohlsearch<cr>
" - Delete trailing blanks (spaces)
nnoremap <Leader>t :silent :%s/\s\+$//<cr>:noh<cr>``
" - Display extra whitespace
nnoremap <Leader>l :set list!<cr>
" - Chage dir to the current path
nnoremap <Leader>c :cd %:p:h<cr>
" - Search current word
nnoremap <Leader>a :Ack <cword><cr>
" - Set tab stop to 4, expand tabs to spaces, and retab the whole document
nnoremap <Leader>r :set tabstop=4 shiftwidth=4 expandtab<CR>:retab<CR>
" - Replace globally current word
nnoremap <Leader>s :%s/\v<cword>//g<left><left>
"   double percentage sign in command mode is expanded to directory of current file - http://vimcasts.org/e/14
cnoremap %% <C-R>=expand('%:h').'/'<cr>
" - Source vimrc
nnoremap <Leader>ve :edit $MYVIMRC<cr>
nnoremap <Leader>vs :source $MYVIMRC<cr>
" - PHP source code folding
nnoremap <Leader>pf <Esc>:EnableFastPHPFolds<cr>
nnoremap <Leader>pu <Esc>:DisablePHPFolds<cr>

" Regular Mappings

" - Open each buffer in a new tab
nnoremap <Leader>b :bufdo tab split<cr>
" - MRU - use <c-b> to switch modes
nnoremap <Leader>m :CtrlPMRU<cr>
" - Add to ZZ and ZQ builtins
noremap ZW :w<cr>

" - visual shifting (does not exit Visual mode)
vnoremap < <gv
vnoremap > >gv

" - Tabs - switch to next tab
nnoremap <Leader>, gt
" - Buffers
nnoremap <Leader>0 :CtrlPBuffer<cr>
nnoremap <Leader>1 1gt 
nnoremap <Leader>2 2gt
nnoremap <Leader>3 3gt
nnoremap <Leader>4 4gt
nnoremap <Leader>5 5gt
nnoremap <Leader>6 6gt
nnoremap <Leader>7 7gt
nnoremap <Leader>8 8gt
nnoremap <Leader>9 9gt

" - Fugitive
" nnoremap <leader>gs :Gstatus<CR><C-w>15+

" Sum numbers example: 
"   let S=0
"   %s/\v(.*)/\=Sum(submatch(0))/  
"   echo S 
let g:S = 0
function! Sum(number)
  let g:S = g:S + str2float(a:number)
  return a:number
endfunction
