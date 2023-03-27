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

" Set color column to 80 for JCL/COBOL dev
set colorcolumn=80

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
" Source:
" https://superuser.com/questions/195022/vim-how-to-synchronize-nerdtree-with-current-opened-tab-file-path
autocmd BufEnter * lcd %:p:h

" Change HOME directory
" Added due to me wanting a different home directory on some computers
"if has ('win32')
    " let $HOME = "C:\\users\\cadmus"
"elseif has ('unix')
    " let $HOME = "/home/cadmus"


" ========= Session Settings ==========
if has ('win32')
    " Notes
    map <F7> :mksession! $HOME\sessions\main.vim <cr>             " Quick write session
    map <F9> :source $HOME\sessions\main.vim <cr>                " Quick load session
    " autocmd! VimLeave * mksession! $HOME\sessions\main.vim      " Automatically save the session when leaving vim
    " autocmd! VimEnter * source $HOME\sessions\main.vim          " Automatically load the session when entering vim
    " Code
    map <F8> :mksession! $HOME\sessions\code.vim <cr>             " Quick write session
    map <F10> :source $HOME\sessions\code.vim <cr>                " Quick load session
elseif has ('unix')
    " Notes
    map <F7> :mksession! ~/vim/sessions/main.vim <cr>             " Quick write session
    map <F9> :source ~/vim/sessions/main.vim <cr>                " Quick load session
    " autocmd! VimLeave * mksession! ~/vim/sessions/main.vim      " Automatically save the session when leaving vim
    " autocmd! VimEnter * source ~/vim/sessions/main.vim          " Automatically load the session when entering vim
    " Code
    map <F8> :mksession! ~/vim/sessions/code.vim <cr>             " Quick write session
    map <F10> :source ~/vim/sessions/code.vim <cr>                " Quick load session
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
" Check to see if vim-plug is installed
" Source: https://gist.github.com/miguelgrinberg/527bb5a400791f89b3c4da4bd61222e4
let need_to_install_plugins = 0
if has('win32')
	if empty(glob('$HOME\vimfiles\autoload\plug.vim'))
		silent !curl -fLo $HOME/vimfiles/autoload/plug.vim --create-dirs
			\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    	let need_to_install_plugins = 1
	endif
elseif has('unix')
	if empty(glob('~/.vim/autoload/plug.vim'))
		silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
			\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
		let need_to_install_plugins = 1
	endif
endif

" Set plugin directory based on Windows or Linux/MacOS
" TODO: Need to turn this into an array and call it in a loop instead of maintaining two plugin lists
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

" Install plugins automatically if vim-plug was missing
" Source: https://github.com/davidmytton/dotfiles/blob/main/dot_vimrc
if need_to_install_plugins == 1
    echo "[*] Installing plugins..."
    !silent PlugInstall
    echo "[*] Done!"
    q
endif


" ========= Plugin Mappings ==========
" Set PATH to git for windows fzf embedded usage on vim
" let $PATH = "C:\\Program Files\\Git\\usr\\bin;" . $PATH

" Open and close NERDTree with CTRL + N
map <silent> <C-n> :NERDTreeToggle<CR>

" Start NERDTree and put the cursor back in the other window.
autocmd VimEnter * NERDTree ~/Documents | wincmd p

" Close the tab if NERDTree is the only window remaining in it.
"autocmd BufEnter * if tabpagenr('$') > 1 && !len(filter(tabpagebuflist(), 'getbufvar(v:val,"&ft") != "nerdtree"')) | tabclose | endif

" Open the existing NERDTree on each new tab.
"autocmd BufWinEnter * if getcmdwintype() == '' | silent NERDTreeMirror | endif

" Make nerdtree open files in new tabs with enter
let NERDTreeMapOpenInTab='<ENTER>'

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


" ========= JCL Syntax Highlighting ==========
" source: https://github.com/moshix/mvs/blob/master/vimrc
syn case ignore
syn keyword jclKwd pgm proc class dsn[ame] msgclass space disp contained
syn keyword jclKwd parm member cond msglevel order lrecl recfm unit contained
syn keyword jclKwd sysout outlim blksize region dcb amp notify contained
syn keyword jclKwd then shr old new mod catlg rlse delete pass keep contained 
syn keyword jclKwd cyl trk vol retain ser label recorg sysda contained 
syn keyword jclKwd dummy  contained 
syn keyword jclCKwd pgm proc class dsn[ame] msgclass space disp contained
syn keyword jclCKwd parm member cond msglevel order lrecl recfm unit contained
syn keyword jclCKwd sysout outlim blksize region dcb amp contained
syn keyword jclCKwd then shr old new mod catlg rlse delete pass keep contained 
syn keyword jclCKwd cyl trk vol retain ser label recorg sysda contained 
syn keyword jclCKwd dummy  contained 
syn keyword jclPgm idcams iebcopy sort icegener adrdssu ftp rexec contained
syn keyword jclPgm iebgener iefbr14 contained
syn keyword jclCPgm idcams iebcopy sort icegener adrdssu ftp rexec contained
syn keyword jclCPgm iebgener iefbr14 contained
syn match jclMainCommand +^//[^* ]*\s\+EXEC+hs=e-3  contained
syn match jclMainCommand +^//[^* ]*\s\+DD+hs=e-1  contained
syn match jclMainCommand +^//[^* ]*\s\+INCLUDE+hs=e-6 contained
syn match jclMainCommand +^//[^* ]*\s\+JCLLIB+hs=e-5 contained
syn match jclMainCommand +^//[^* ]*\s\+JOB+hs=e-2 contained
syn match jclMainCommand +^//[^* ]*\s\+SET+hs=e-2 contained
syn match jclCMainCommand +^//[^* ]*\s\+EXEC+hs=e-3 contained
syn match jclCMainCommand +^//[^* ]*\s\+DD+hs=e-1 contained 
syn match jclCMainCommand +^//[^* ]*\s\+INCLUDE+hs=e-6 contained
syn match jclCMainCommand +^//[^* ]*\s\+JCLLIB+hs=e-5 contained
syn match jclCMainCommand +^//[^* ]*\s\+JOB+hs=e-2 contained
syn match jclCMainCommand +^//[^* ]*\s\+SET+hs=e-2 contained 
syn match jclCond +^//[^* ]*\s\+ELSE+ contained
syn match jclOperator  "[()]" contained
syn match jclCOperator +[()]+ contained
syn match jclNumber +\<\d\+\>+ contained
syn match jclCNumber +\<\d\+\>+ contained
syn match jclDsn +\(\(\w\{1,8}\.\)\+\w\{1,8}\((\w\{1,8})\)\?\|\(&&\w\{1,8}\)\)+ contained
syn match jclCDsn +\(\(\w\{1,8}\.\)\+\w\{1,8}\((\w\{1,8})\)\?\|\(&&\w\{1,8}\)\)+ contained
syn region  jclDblQuote start=+"+ skip=+[^"]+ end=+"+ contained
syn region  jclSnglQuote start=+'+ skip=+[^']+ end=+'+ contained
syn region  jclCDblQuote start=+"+ skip=+[^"]+ end=+"+ contained
syn region  jclCSnglQuote start=+'+ skip=+[^']+ end=+'+ contained
syn cluster jclConditional contains=jclCMainCommand,jclCIF,jclCData,jclCKwd,jclCond,jclCDblQuote,jclCSnglQuote,jclCComment,jclCOperator,jclCDsn,jclCPgm,jclCNumber
syn region jclIF matchgroup=jclCond start=+^//\w*\s\+IF+ end=+^//\w*\s\+ENDIF+ contains=@jclConditional contained 
syn region jclCIF matchgroup=jclCond start=+^//\w*\s\+IF+ end=+^//\w*\s\+ENDIF+ contains=@jclConditional contained
syn match jclCComment   +^//\*.*$+ contained
syn cluster jclNonConditional contains=jclMainCommand,jclKwd,jclIf,jclOperator,jclDblQuote,jclSnglQuote,jclDsn,jclPgm,jclNumber
syn match jclComment    +^//\*.*$+
syn match jclData   +^\([^/]\|/[^*/]\).*$+
syn match jclStatement  +^//[^*].*$+ transparent contains=@jclNonConditional
syn match jclCData  +^\([^/]\|/[^*/]\).*$+ contained

" Define the default highlighting.
" For version 5.7 and earlier: only when not done already
" For version 5.8 and later: only when an item doesn't have highlighting yet
if version >= 508 || !exists("did_jcl_syntax_inits")
if version < 508
let did_jcl_syntax_inits = 1
command -nargs=+ HiLink hi link <args>
else
command -nargs=+ HiLink hi def link <args>
endif
HiLink jclIF    Normal
HiLink jclCIF   Normal
HiLink jclCond  WarningMsg
HiLink jclCComm Statement
HiLink jclCComment Comment 
HiLink jclKwd Statement
HiLink jclCKwd Statement
HiLink jclMainCommand Type 
HiLink jclCMainCommand WarningMsg
HiLink jclOperator  Operator
HiLink jclCOperator Operator
HiLink jclDsn Normal 
HiLink jclCDsn Normal 
HiLink jclData Special
HiLink jclCData Special
HiLink jclPgm Function
HiLink jclCPgm Function
HiLink jclNumber Number
HiLink jclCNumber Number
HiLink jclDblQuote    jclSnglQuote
HiLink jclSnglQuote String
HiLink jclCDblQuote   jclCSnglQuote
HiLink jclCSnglQuote    String
HiLink jclCIF jclIF
HiLink jclComment       Comment
HiLink jclCComment        Comment
HiLink jclComm      Statement
HiLink jclLabel       Label
syn sync fromstart  " syncronize from start
delcommand HiLink
endif
