" ========= Location info =========
" Linux and Mac OS: ~/.vimrc
" MS-DOS and Win32: $VIM\_vimrc
" Portable GVIM: .\Data\settings\vimrc
" Installed GVIM: $HOME\_vimrc
" Neovim: $HOME\AppData\Local\nvim\init.vim


" ========= General Settings ==========
" Use Vim settings, rather than Vi settings (This must be first!)
set nocompatible

" Generic editor settings (Spellcheck, line numbers, etc..)
set backspace=indent,eol,start whichwrap+=<,>,[,]
set history=50
set ruler
set showcmd
set nospell
set number
set autoread
set belloff=all

" Search settings
set hlsearch
set incsearch
set ignorecase

" Disable backup and swap files
set noswapfile
set nowritebackup
set nobackup

" Set whitespace characters and mapping for ":set list"
" Source: https://stackoverflow.com/questions/1675688/make-vim-show-all-white-spaces-as-a-character
:set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<,space:␣
noremap <F5> :set list!<CR>
inoremap <F5> <C-o>:set list!<CR>
cnoremap <F5> <C-c>:set list!<CR>

" Set tabs to 4 spaces
" Source: https://www.youtube.com/watch?v=SsoOG6ZeyUI
set ts=4
set softtabstop=4 
set shiftwidth=4
set expandtab   
     
" Set intendtation settings
set autoindent
set smartindent
set breakindent
set pastetoggle=<F2>
    
" Disable autoindent when pasting text
" Source: https://coderwall.com/p/if9mda/automatically-set-paste-mode-in-vim-when-pasting-in-insert-mode
let &t_SI .= "\<Esc>[?2004h"
let &t_EI .= "\<Esc>[?2004l"

" Prevent newlines from breaking in middle of a word
set formatoptions=l
set lbr

" Enable mouse in terminal emulator
if has('mouse')
  set mouse=a
endif

" Set file formats
set fileformat=unix
set encoding=utf-8
set fileencoding=utf-8

" Change working directory to current file's directory
" Source: https://superuser.com/questions/195022/vim-how-to-synchronize-nerdtree-with-current-opened-tab-file-path
autocmd BufEnter * lcd %:p:h

" Change HOME directory
" Added due to me wanting a different home directory on some computers
"if has ('win32')
    " let $HOME = "C:\\users\\cadmus"
"elseif has ('unix')
    " let $HOME = "/home/cadmus"


" ========= Session Settings ==========
if has ('win32')
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
vmap <C-c> "+y
vmap <C-x> "+c
vmap <C-v> c<ESC>"+p
imap <C-v> <ESC>"+pa

" Alt-Space is system menu
if has("gui")
  noremap <M-Space> :simalt ~<CR>
  inoremap <M-Space> <C-O>:simalt ~<CR>
  cnoremap <M-Space> <C-C>:simalt ~<CR>
endif


" ========= Tab Navigation Mappings =========
" Have to do this by uname since modern MacOS responds as unix
" Source: https://vi.stackexchange.com/questions/2572/detect-os-in-vimscript
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
" Set plugin directory based on Windows or Linux/MacOS
" TODO: Need to turn this into an array and call it in a loop instead of maintaining two plugin lists

" Install vim-plug if not found
" Source: https://github.com/junegunn/vim-plug/wiki/tips
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

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
    Plug 'ap/vim-buftabline'
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
    Plug 'ap/vim-buftabline'
    call plug#end()
endif


" ========= Plugin Mappings ==========
" Set PATH to git for windows fzf embedded usage on vim
" let $PATH = "C:\\Program Files\\Git\\usr\\bin;" . $PATH

" NERDtree (,nt in visual mode)
let mapleader = ","
nmap <leader>nt :NERDTree<cr>

" fzf (; in visual mode)
map ; :Files<cr>


" ========= Colorscheme and Font Settings ==========
" This needs to be below the plugins as onedark is a plugin
try
    colorscheme onedark
catch /^Vim\%((\a\+)\)\=:E185/
    echo "[!] Colorscheme missing, using default"
    colorscheme default
endtry

if has ('gui_running')
    if has ('gui_win32')
    	set guifont=Consolas:h10:cANSI
    elseif has ('gui_macvim')
        set guifont=Monaco:h11
    else
        set guifont=Consolas\ 10
    endif
endif
