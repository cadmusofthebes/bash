" ========= Location info =========
" Linux and Mac OS: ~/.vimrc
" MS-DOS and Win32: $VIM\_vimrc
" Portable GVIM: .\Data\settings\vimrc
" Installed GVIM: $HOME\_vimrc
" Neovim: $HOME\AppData\Local\nvim\init.vim



" ========= Update Info =========
" Last Update: 08/11/21
"   - Updated commented out sessions to match uncommented ones
"   - Added smart word wrapping



" ========= General Settings ==========
" Generic settings
set nocompatible                                        " Use Vim settings, rather than Vi settings (This must be first!)
set backspace=indent,eol,start whichwrap+=<,>,[,]       " Allow backspacing over everything and cursor keys wrap lines
set history=50                                          " Keep 50 lines of command line history
set ruler                                               " Show the cursor position at the bottom of the page
set showcmd                                             " Display incomplete commands
set incsearch                                           " Do incremental searching
set nospell                                             " Disable spellchecking
set number                                              " Enable line numbers
set ignorecase                                          " Ignore case in searching
set autoread                                            " Autoread changed files instead of asking
set belloff=all                                         " Turn off bell sounds for all events     
set hlsearch                                            " Highlight searches
set pastetoggle=<F2>                                    " Set paste toggle key for auto-indentation
set breakindent                                         " Set smart word wrap

" Backup and swap file management
set noswapfile
set nowritebackup
set nobackup

" Set tabs to 4 spaces and auto-indent
set ts=4
set softtabstop=4 shiftwidth=4 expandtab
set autoindent

" Prevent newlines from breaking in middle of a word
set formatoptions=l
set lbr

" Don't use Ex mode, use Q for formatting
map Q gq

" Enable mouse in terminal emulator
if has('mouse')
  set mouse=a
endif



" ========= Colors and Font Settings ==========
try
    colorscheme atom
catch /^Vim\%((\a\+)\)\=:E185/
    colorscheme darkblue
endtry

if has('gui_running')
    if has('gui_win32')
    	set guifont=Consolas:h10:cANSI
    else
        set guifont=Consolas\ 10
    endif
endif



" ========= Session Settings ==========
if has('win32')
    map <F7> :mksession! $HOME\sessions\main.vim <cr>             " Quick write session
    map <F10> :source $HOME\sessions\main.vim <cr>                " Quick load session
    " autocmd! VimLeave * mksession! $HOME\sessions\main.vim      " Automatically save the session when leaving vim
    " autocmd! VimEnter * source $HOME\sessions\main.vim          " Automatically load the session when entering vim
elseif has ('unix')
    map <F7> :mksession! ~/vim/sessions/main.vim <cr>             " Quick write session
    map <F10> :source ~/vim/sessions/main.vim <cr>                " Quick load session
    " autocmd! VimLeave * mksession! ~/vim/sessions/main.vim      " Automatically save the session when leaving vim
    " autocmd! VimEnter * source ~/vim/sessions/main.vim          " Automatically load the session when entering vim
endif



" ========= Windows Style Mappings =========
" Forces CTRL+C, CTRL+V, CTRL+P to act as copy/cut/paste
source $VIMRUNTIME/mswin.vim
behave mswin

" backspace in Visual mode deletes selection
vnoremap <BS> d

" Setup virtualedit for pasting in Insert/Visual mode
exe 'inoremap <script> <C-V>' paste#paste_cmd['i']
exe 'vnoremap <script> <C-V>' paste#paste_cmd['v']
imap <S-Insert> <C-V>
vmap <S-Insert> <C-V>

" Alt-Space is system menu
if has("gui")
  noremap <M-Space> :simalt ~<CR>
  inoremap <M-Space> <C-O>:simalt ~<CR>
  cnoremap <M-Space> <C-C>:simalt ~<CR>
endif

" CTRL-F4 is close window
noremap <C-F4> <C-W>c
inoremap <C-F4> <C-O><C-W>c
cnoremap <C-F4> <C-C><C-W>c
onoremap <C-F4> <C-C><C-W>c



" ========= Plugin Mappings ==========
" Set PATH to git for windows fzf embedded usage on vim
" let $PATH = "C:\\Program Files\\Git\\usr\\bin;" . $PATH

" NERDtree (,nt in visual mode)
let mapleader = ","
nmap <leader>nt :NERDTree<cr>

" fzf (; in visual mode)
map ; :Files<cr>



" ========= Tab Control Mappings =========
" Have to do this by uname since modern MacOS responds as unix
let os=substitute(system('uname'), '\n', '', '')
if os == 'Darwin' || os == 'Mac'
    nnoremap H gT
    nnoremap L gt
elseif has('win32') || has('unix')
    nnoremap <C-Left> :tabprevious<CR>
    nnoremap <C-Right> :tabnext<CR>
    nnoremap <silent> <A-Left> :tabm -1<CR>
    nnoremap <silent> <A-Right> :tabm +1<CR>
endif



" ========= Plugins =========
if has('win32')
    call plug#begin('~\AppData\Local\vim')
    Plug 'joshdick/onedark.vim'
    Plug 'vim-scripts/loremipsum'
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
    Plug 'tpope/vim-eunuch'
    Plug 'tpope/vim-surround'
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'scrooloose/nerdtree'
    call plug#end()
elseif has('unix')
    call plug#begin('~/.vim/plugged')
    Plug 'joshdick/onedark.vim'
    Plug 'vim-scripts/loremipsum'
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
    Plug 'tpope/vim-eunuch'
    Plug 'tpope/vim-surround'
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'scrooloose/nerdtree'
    call plug#end()
endif
