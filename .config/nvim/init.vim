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
" set t_Co=256

set ignorecase
set smartcase

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
" set textwidth=120       " break lines when line length increases
set tabstop=4           " use 4 spaces to represent tab
set softtabstop=4
set shiftwidth=4        " number of spaces to use for auto indent

set colorcolumn=120

" folding
" autocmd FileType python setlocal softtabstop=4 tabstop=4 shiftwidth=4 textwidth=119 foldmethod=indent foldnestmax=2

" make vim views creation / loading automatic
autocmd BufWinLeave *.* mkview
autocmd BufWinEnter *.* silent! loadview 

let maplocalleader = "\<Space>"

set showcmd             " show (partial) command in status line

set number
call plug#begin('~/.vim/plugged')

Plug 'AaronLasseigne/yank-code'
Plug 'airblade/vim-gitgutter'
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
Plug 'bling/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'myusuf3/numbers.vim'
" async linter
Plug 'w0rp/ale'
" python dev
Plug 'davidhalter/jedi-vim', {'for': 'python'}
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'zchee/deoplete-jedi', {'for': 'python'}
Plug 'Vimjas/vim-python-pep8-indent', {'for': 'python'}
Plug 'tweekmonster/django-plus.vim'
Plug 'airblade/vim-rooter'
Plug 'majutsushi/tagbar'
" Plug 'ervandew/supertab'
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'
Plug 'mattn/emmet-vim'
" haskell
" Plug 'neovimhaskell/haskell-vim'
" todo.txt
Plug 'freitass/todo.txt-vim'

call plug#end()

" supertab
" let g:SuperTabDefaultCompletionType = "<c-n>"

" ale
let g:ale_sign_column_always = 1
let g:ale_statusline_format = ['⨉ %d', '⚠ %d', '⬥ ok']
nmap <silent> <C-j> <Plug>(ale_next_wrap)

" markdown
let g:vim_markdown_folding_disabled = 1

" fugitive
nnoremap gs :Gstatus<CR>
nnoremap gw :Gwrite<CR>
nnoremap go :Gcommit<CR>
nnoremap gD :Gdiff<CR>
set diffopt+=vertical

" airline
let g:airline_theme='base16'
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1

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
nnoremap <silent> <localleader>c :TagbarToggle<CR>

" jedi
let g:jedi#auto_vim_configuration = 0
let g:jedi#goto_assignments_command = '<localleader>g'  " dynamically done for ft=python.
let g:jedi#goto_definitions_command = '<localleader>d'  " dynamically done for ft=python.
let g:jedi#use_tabs_not_buffers = 0  " current default is 1.
let g:jedi#rename_command = '<localleader>gR'
let g:jedi#usages_command = '<localleader>gu'
let g:jedi#completions_enabled = 0
let g:jedi#smart_auto_mappings = 1
let g:jedi#force_py_version = 3

" Use deoplete.
set completeopt=menu,menuone
let g:deoplete#enable_at_startup = 1
let g:deoplete#auto_complete_delay = 30 
" Use smartcase.
let g:deoplete#enable_smart_case = 1
let g:deoplete#sources#jedi#show_docstring = 1
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function() abort
    " return deoplete#close_popup() 
    return deoplete#close_popup() . "\<CR>"
endfunction

" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> deoplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS>  deoplete#smart_close_popup()."\<C-h>"

" neosnippet
" Plugin key-mappings.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)
imap <expr><TAB>
 \ pumvisible() ? "\<C-n>" :
 \ neosnippet#expandable_or_jumpable() ?
 \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
 \ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
" Tell Neosnippet about the other snippets
let g:neosnippet#snippets_directory='/home/choco/.vim/mysnippets'

" echodoc
let g:echodoc#enable_at_startup = 1

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
nnoremap <silent> <localleader> :update<CR>
nnoremap <silent> <localleader>t :NERDTreeToggle<CR>
nnoremap <silent> <localleader>s :update<cr>:so ~/.config/nvim/init.vim<CR>
nnoremap <silent> <localleader>i :e  ~/.config/nvim/init.vim<CR>
nnoremap <silent> <localleader>x :update<CR>:bd<CR>
nnoremap <silent> <localleader>h :nohlsearch<CR>
" copy relative path of current file
nnoremap <silent> <localleader>f :let @+ = expand("%")<CR>
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
autocmd Filetype python set textwidth=120
autocmd Filetype python set colorcolumn=120
autocmd Filetype python set softtabstop=4
autocmd Filetype python set expandtab
autocmd Filetype python set autoindent

" haskell
let g:haskell_enable_quantification = 1   " to enable highlighting of `forall`
let g:haskell_enable_recursivedo = 1      " to enable highlighting of `mdo` and `rec`
let g:haskell_enable_arrowsyntax = 1      " to enable highlighting of `proc`
let g:haskell_enable_pattern_synonyms = 1 " to enable highlighting of `pattern`
let g:haskell_enable_typeroles = 1        " to enable highlighting of type roles
let g:haskell_enable_static_pointers = 1  " to enable highlighting of `static`
let g:haskell_backpack = 1                " to enable highlighting of backpack keywords

" yank code plugin
vmap <localleader>y :YankCode<CR>

" Jinja
au BufNewFile,BufRead *.jinja set ft=jinja

" disable unesafe cmd in per projects settings file
set secure
