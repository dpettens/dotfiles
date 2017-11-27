" Based on https://dougblack.io/words/a-good-vimrc.html
" Vim Cheat Sheet http://vim.rtorr.com/

" General ----------------------------------------------------

set encoding=utf-8

" Colors -----------------------------------------------------

"colorscheme molokai    " enable colorscheme
syntax enable           " enable syntax processing

" Spaces & Tabs ----------------------------------------------

set tabstop=2	        " number of visual spaces per TAB
set softtabstop=2       " number of spaces in tab when editing
set expandtab           " tabs are spaces

" UI Config --------------------------------------------------

set number              " show line numbers
set showmatch           " highlight matching [{()}]
set showcmd             " show command in bottom bar
set showmode            " show mode in bottom bar
set wildmenu            " visual autocomplete for command menu
set lazyredraw          " redraw only when we need to
set t_Co=256            " color scheme (terminal)
filetype indent on      " load filetype-specific indent files

" Searching --------------------------------------------------

set incsearch           " search as characters are entered
set hlsearch            " highlight matches

" map <space> to turn off search highlight
nnoremap <leader><space> :nohlsearch<CR>

" Folding ----------------------------------------------------

set foldenable          " enable folding
set foldlevelstart=10   " open most folds by default
set foldnestmax=10      " 10 nested fold max
set foldmethod=indent   " fold based on indent level

" map <space> to open/closes folds
nnoremap <space> za

" Powerline --------------------------------------------------

"set laststatus=2
"let g:powerline_pycmd="py3"

