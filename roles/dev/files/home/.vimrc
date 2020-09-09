" Remove toolbar
set guioptions-=T

" We're running Vim, not Vi!
set nocompatible
set nobackup
set nowritebackup

filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
Bundle 'gmarik/vundle'

filetype plugin indent on

" Session
set ruler

" Enables syntax highlighting
syntax on

" Folding settings
set foldmethod=indent
set foldnestmax=3
set nofoldenable

set wildmode=list:longest
set wildmenu
set wildignore=*.o,*.obj,*~

" Vertical/horizontal scroll off settings
set scrolloff=3
set sidescrolloff=7
set sidescroll=1

" Enables error files & error jumping.
set cf

" Number of things to remember in history.
set history=256

" Time to wait after ESC (default causes an annoying delay)
set timeoutlen=250

" Indentation/formatting settings
set autoindent
set list
set nu
set nowrap

" Matching bracket
set showmatch
set mat=5

" Tabs to spaces
set expandtab
set smarttab

" Clear search results highlighting
map <c-L> :nohlsearch<CR>

" No blinking nor noise
set novisualbell
set noerrorbells

" Show $ at end of line and trailing space as ~
set lcs=tab:\ \ ,extends:>,precedes:<

" Always show status line
set laststatus=2

" Filetype aware
filetype plugin on
filetype plugin indent on

" Avoid leaking gopass secrets
au BufNewFile,BufRead /dev/shm/gopass.* setlocal noswapfile nobackup noundofile
