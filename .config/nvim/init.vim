let g:python3_host_prog = '/home/choco/.pyenv/versions/neovim/bin/python'
set clipboard=unnamedplus

set ttyfast
set hlsearch
set cursorline
set undofile
set history=100
set noswapfile
set autoread
set hidden
set linespace=0
set laststatus=2
set noshowmode
syntax on
" set t_Co=256

set ignorecase
set smartcase
set termguicolors
set background=dark

" 2 lines for cmd line
set cmdheight=2

set undodir=~/.vim/tmp/undo/     " undo files
set backupdir=~/.vim/tmp/backup/ " backups
set directory=~/.vim/tmp/swap/   " swap files

set encoding=utf-8

" allow per project settings file
set exrc

if has('mouse')
  set mouse=a
endif

set expandtab           " enter spaces when tab is pressed
set tabstop=4           " use 4 spaces to represent tab
set softtabstop=4
set shiftwidth=4        " number of spaces to use for auto indent

set colorcolumn=88

" folding
" autocmd FileType python setlocal softtabstop=4 tabstop=4 shiftwidth=4 textwidth=119 foldmethod=indent foldnestmax=2

" make vim views creation / loading automatic
" autocmd BufWinLeave *.* mkview
" autocmd BufWinEnter *.* silent! loadview 

let mapleader = ","

set showcmd             " show (partial) command in status line

set number
call plug#begin('~/.vim/plugged')

Plug 'AaronLasseigne/yank-code'
Plug 'Yggdroot/indentLine'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-sensible'
Plug 'ap/vim-css-color'
Plug 'tpope/vim-commentary'
Plug 'chriskempson/base16-vim'
Plug 'itchyny/lightline.vim'
Plug 'mengelbrecht/lightline-bufferline'
Plug 'myusuf3/numbers.vim'
" Plug 'cohama/lexima.vim'
" python dev
Plug 'davidhalter/jedi-vim'
Plug 'Vimjas/vim-python-pep8-indent', {'for': 'python'}
Plug 'airblade/vim-rooter'
Plug 'majutsushi/tagbar'
Plug 'mattn/emmet-vim'
Plug 'janko/vim-test'
" haskell
" Plug 'neovimhaskell/haskell-vim'

" coc : autocompletion
Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}

call plug#end()

" markdown
let g:vim_markdown_folding_disabled = 1

" fugitive
nnoremap gs :Gstatus<CR>
nnoremap gw :Gwrite<CR>
nnoremap go :Gcommit<CR>
nnoremap gD :Gdiff<CR>
set diffopt+=vertical

" fzf
let g:fzf_history_dir = '~/.local/share/fzf-history'

let $FZF_DEFAULT_COMMAND = 'ag --vimgrep --ignore .git --hidden --smart-case -g ""'
nnoremap <C-p> :FZF<cr>
nnoremap <C-b> :Buffers<cr>
nnoremap <C-n> :Ag<cr>
nnoremap <C-l> :BLines<cr>
nnoremap <C-k> :History<cr>
nnoremap <C-t> :Tags<cr>

" NERDTree
let NERDTreeIgnore=['\.pyc$', '\~$', '__pycache__'] "ignore files in NERDTree

" tagbar
nnoremap <silent> <leader>c :TagbarToggle<CR>

" coc
source ~/.config/nvim/coc.vim

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
nnoremap <silent> <leader> :update<CR>
nnoremap <silent> <leader>t :NERDTreeToggle<CR>
nnoremap <silent> <leader>s :update<cr>:so ~/.config/nvim/init.vim<CR>
nnoremap <silent> <leader>i :e  ~/.config/nvim/init.vim<CR>
nnoremap <silent> <leader>x :update<CR>:bd<CR>
nnoremap <silent> <leader>h :nohlsearch<CR>
" copy relative path of current file
nnoremap <silent> <leader>f :let @+ = expand("%")<CR>
" add a line before, then a line after, then go back to initial line
nnoremap gA O<esc>jo<esc>k
" paste after line
nnoremap gP o<esc>p
" disable Ex mode
nnoremap Q <nop>
" Use kj as escape
inoremap kj <ESC>

autocmd FileType python autocmd BufWritePre <buffer> %s/\s\+$//e
autocmd Filetype python set tabstop=4
autocmd Filetype python set shiftwidth=4
autocmd Filetype python set textwidth=88
autocmd Filetype python set colorcolumn=88
autocmd Filetype python set softtabstop=4
autocmd Filetype python set expandtab
autocmd Filetype python set autoindent

" " haskell
" let g:haskell_enable_quantification = 1   " to enable highlighting of `forall`
" let g:haskell_enable_recursivedo = 1      " to enable highlighting of `mdo` and `rec`
" let g:haskell_enable_arrowsyntax = 1      " to enable highlighting of `proc`
" let g:haskell_enable_pattern_synonyms = 1 " to enable highlighting of `pattern`
" let g:haskell_enable_typeroles = 1        " to enable highlighting of type roles
" let g:haskell_enable_static_pointers = 1  " to enable highlighting of `static`
" let g:haskell_backpack = 1                " to enable highlighting of backpack keywords

" yank code plugin
vmap <leader>y :YankCode<CR>

" Jinja
au BufNewFile,BufRead *.jinja set ft=jinja

" " jedi
let g:jedi#auto_initialization = 0
let g:jedi#auto_vim_configuration = 0
let g:jedi#use_tabs_not_buffers = 0  " current default is 1.
let g:jedi#completions_enabled = 0
let g:jedi#smart_auto_mappings = 0
let g:jedi#popup_on_dot = 0
let g:jedi#force_py_version = 3

" vim-test
let test#strategy = 'neovim'
let test#python#runner = 'pytest'
let test#python#pytest#executable = 'runtest'
nmap <silent> t<C-n> :TestNearest<CR>
nmap <silent> t<C-f> :TestFile<CR>
nmap <silent> t<C-s> :TestSuite<CR>
nmap <silent> t<C-l> :TestLast<CR>
nmap <silent> t<C-g> :TestVisit<CR>

" lightline
set showtabline=2
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'cocstatus', 'readonly', 'relativepath', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'fugitive#head',
      \   'cocstatus': 'coc#status'
      \ },
      \ }
let g:lightline#bufferline#show_number  = 1
let g:lightline#bufferline#shorten_path = 1
let g:lightline#bufferline#unnamed      = '[No Name]'
let g:lightline.tabline          = {'left': [['buffers']], 'right': [['close']]}
let g:lightline.component_expand = {'buffers': 'lightline#bufferline#buffers'}
let g:lightline.component_type   = {'buffers': 'tabsel'}

" do not conceal anything !
set conceallevel=0

" disable unesafe cmd in per projects settings file
set secure
