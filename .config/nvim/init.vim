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

" 2 lines for cmd line
set cmdheight=2

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

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
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
" async linter
Plug 'w0rp/ale'
Plug 'davidhalter/jedi-vim', {'for': 'python'}
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'zchee/deoplete-jedi', {'for': 'python'}
Plug 'Vimjas/vim-python-pep8-indent', {'for': 'python'}
Plug 'majutsushi/tagbar'
Plug 'ervandew/supertab'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'ivalkeen/vim-simpledb', {'for': 'sql'}
" echo doc signature
Plug 'Shougo/echodoc.vim'

call plug#end()


" ale
let g:ale_sign_column_always = 1
let g:ale_statusline_format = ['⨉ %d', '⚠ %d', '⬥ ok']
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

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

" fzf
function! s:find_git_root()
  return system('git rev-parse --show-toplevel 2> /dev/null')[:-2]
endfunction
let g:fzf_history_dir = '~/.local/share/fzf-history'

command! ProjectFiles execute 'Files' s:find_git_root()
let $FZF_DEFAULT_COMMAND = 'ag --vimgrep --hidden --smart-case -g ""'
nmap <C-p> :ProjectFiles<cr>
nmap <C-b> :Buffers<cr>
nmap <C-n> :Ag<cr>
nmap <C-l> :BLines<cr>

" NERDTree
let NERDTreeIgnore=['\.pyc$', '\~$', '__pycache__'] "ignore files in NERDTree

" tagbar
nmap <silent> <leader>c :TagbarToggle<CR>

" jedi
let g:jedi#completions_enable = 0
let g:jedi#auto_vim_configuration = 0
let g:jedi#goto_assignments_command = '<leader>g'  " dynamically done for ft=python.
let g:jedi#goto_definitions_command = '<leader>d'  " dynamically done for ft=python.
let g:jedi#use_tabs_not_buffers = 0  " current default is 1.
let g:jedi#rename_command = '<Leader>gR'
let g:jedi#usages_command = '<Leader>gu'
let g:jedi#completions_enabled = 0
let g:jedi#smart_auto_mappings = 1


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

" ultisnip and superteb
let g:SuperTabDefaultCompletionType    = '<C-n>'
let g:SuperTabCrMapping                = 0
let g:UltiSnipsExpandTrigger           = '<tab>'
let g:UltiSnipsJumpForwardTrigger      = '<tab>'
let g:UltiSnipsJumpBackwardTrigger     = '<s-tab>'
let g:UltiSnipsListSnippets            = '<c-S>' 
call deoplete#custom#set('ultisnips', 'matchers', ['matcher_fuzzy'])

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
nmap <silent> <leader> :update<CR>
nmap <silent> <leader>t :NERDTreeToggle<CR>
nmap <silent> <leader>s :update<cr>:so ~/.config/nvim/init.vim<CR>
nmap <silent> <leader>i :e  ~/.config/nvim/init.vim<CR>
nmap <silent> <leader>x :update<CR>:bd<CR>
nmap <silent> <leader>h :nohlsearch<CR>
" copy relative path of current file
nmap <silent> <leader>f :let @+ = expand("%")<CR>
" add a line before, then a line after, then go back to initial line
nnoremap gA O<esc>jo<esc>k
" paste after line
nnoremap gP o<esc>p
" disable Ex mode
nnoremap Q <nop>

autocmd FileType python nnoremap <LocalLeader>i :!isort %<CR><CR>
autocmd FileType python nnoremap <LocalLeader>= :0,$!yapf<CR>
autocmd FileType python autocmd BufWritePre <buffer> %s/\s\+$//e
