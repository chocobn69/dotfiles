set clipboard=unnamedplus

syntax on

filetype indent plugin on
set ttyfast
set hlsearch
set cursorline
set ruler
set undofile
set history=100
set noswapfile
set autoread
set hidden
set linespace=0
set t_Co=256

set ignorecase
set smartcase

set undodir=~/.vim/tmp/undo/     " undo files
set backupdir=~/.vim/tmp/backup/ " backups
set directory=~/.vim/tmp/swap/   " swap files

set encoding=utf-8

if has('mouse')
  set mouse=a
endif

set expandtab           " enter spaces when tab is pressed
" set textwidth=120       " break lines when line length increases
set tabstop=4           " use 4 spaces to represent tab
set softtabstop=4
set shiftwidth=4        " number of spaces to use for auto indent
set smarttab

set colorcolumn=120

let mapleader = "\<Space>"

" make backspaces more powerfull
set backspace=indent,eol,start

set showcmd             " show (partial) command in status line

set number
call plug#begin('~/.vim/plugged')


Plug 'ctrlpvim/ctrlp.vim'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'plasticboy/vim-markdown', {'for': 'markdown'}
Plug 'ap/vim-css-color'
Plug 'tpope/vim-commentary'
Plug 'chriskempson/base16-vim'
Plug 'bling/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'jmcantrell/vim-virtualenv', {'for': 'python'}
Plug 'myusuf3/numbers.vim'
Plug 'mileszs/ack.vim'
" async linter
Plug 'w0rp/ale'
Plug 'google/yapf'
Plug 'timothycrosley/isort'
Plug 'davidhalter/jedi-vim', {'for': 'python'}
Plug 'majutsushi/tagbar'
Plug 'townk/vim-autoclose'
Plug 'mhinz/vim-startify'


" Initialize plugin system
call plug#end()

" markdown
let g:vim_markdown_folding_disabled = 1

" fugitive
nnoremap gs :Gstatus<CR>
nnoremap gw :Gwrite<CR>
nnoremap go :Gcommit<CR>
nnoremap gD :Gdiff<CR>
nnoremap gl :Glog<CR>

" airline
let g:airline_theme='base16'
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 0

" ctrlp
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git)$',
  \ 'file': '\v\.(pyc)$',
  \ }
map <C-b> :CtrlPBuffer<CR>
let g:ctrlp_cmd = 'CtrlPMixed'
let g:ctrlp_use_caching = 1
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_cache_dir = $HOME.'/.vim/cache/ctrlp'

" NERDTree
let NERDTreeIgnore=['\.pyc$', '\~$'] "ignore files in NERDTree

" tagbar
nmap <silent> <leader>c :TagbarToggle<CR>

set background=dark

hi clear SpellBad
hi SpellBad cterm=underline

" transparent background
hi Normal ctermbg=none
if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256
  source ~/.vimrc_background
endif

let python_highlight_all = 1

" custom shortcuts
nmap <silent> <leader> :update<CR>
nmap <silent> <leader>t :NERDTreeToggle<CR>
nmap <silent> <leader>s :so ~/.config/nvim/init.vim<CR>
nmap <silent> <leader>i :e  ~/.config/nvim/init.vim<CR>
nmap <silent> <leader>x :update<CR>:bd<CR>
nmap <silent> <leader>h :nohlsearch<CR>
" copy relative path of current file
nmap <silent> <leader>f :let @+ = expand("%")<CR>

if executable('ag')
  let g:ackprg = 'ag --vimgrep --smart-case'
endif

autocmd FileType python nnoremap <LocalLeader>i :!isort %<CR><CR>
autocmd FileType python nnoremap <LocalLeader>= :0,$!yapf<CR>
autocmd FileType python autocmd BufWritePre <buffer> %s/\s\+$//e
