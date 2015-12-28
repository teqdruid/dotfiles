set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.

" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
Plugin 'L9'
" Git plugin not hosted on GitHub
Plugin 'git://git.wincent.com/command-t.git'

Plugin 'teqdruid/commenter'

" Bundle 'tpope/vim-markdown'
Bundle 'vim-pandoc/vim-pandoc'
" Bundle 'altercation/vim-colors-solarized'

Plugin 'Valloric/YouCompleteMe'
Plugin 'airblade/vim-gitgutter'

Plugin 'vim-scripts/scons.vim'

""""""""
" Examples:
" git repos on your local machine (i.e. when working on your own plugin)
" Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
" Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Avoid a name conflict with L9
" Plugin 'user/L9', {'name': 'newL9'}
""""""""

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList          - list configured plugins
" :PluginInstall(!)    - install (update) plugins
" :PluginSearch(!) foo - search (or refresh cache first) for foo
" :PluginClean(!)      - confirm (or auto-approve) removal of unused plugins
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

" Switch syntax highlighting on
syntax on

" SCons syntax highlighting
au BufNewFile,BufRead SCons* set filetype=scons 

" For all text files set 'textwidth' to 78 characters.
autocmd! FileType text setlocal textwidth=68

" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid or when inside an event handler
" (happens when dropping a file on gvim).
autocmd! BufReadPost *
  \ if line("'\"") > 0 && line("'\"") <= line("$") |
  \   exe "normal g`\"" |
  \ endif


""""""""""""""""""""""""""""""""""""""""""""""""""""""

"see :h 'option' for more info on any of these
set backspace=indent,eol,start " allow backspacing over everything in insert mode
set history=1000 " keep 1000 lines of command line history
set ruler " show the cursor position all the time
set showcmd " display incomplete commands
set hlsearch " highlight bits that match current search (do /asdf<ENTER> to remove)
set incsearch " do incremental searching
set confirm "ask to save instead of failing with an error
set clipboard+=unnamed "by default copy/paste with the X11 clipboard ("* register)
"set background=dark "make things look !ugly with a dark background
set listchars=tab:\|\ ,trail:.,extends:>,precedes:<,eol:$ " what to show when I hit :set list
"set statusline=%F%m%r%h%w\ [%{GitBranch()}]\ [%Y]\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ [%04l,%04v][%p%%]\ [LEN=%L]
set laststatus=2 "always show above status line
set mouse=a "allow mouse usage in terms (scrolling, highlighting, pasting, etc.)
set mousehide " Hide the mouse when typing text
set scrolloff=10 "try to keep at least 5 lines above and bellow the cursor when scrolling
set autoindent "enable the following line
set smartindent "do the Right Thing
set nocindent "use indent scripts
set cinoptions=:0,l1,g0,(0,Ws,k2s,J1,)1000,*1000 " setup cindent correctly. see :help cinoptions-values
set expandtab "tab key -> spaces
set shiftwidth=4 "indent by 4 spaces
set noshiftround "don't round indent to multiples of shiftwidth
set tabstop=8 "tab characters are drawn as 8 spaces
set softtabstop=4 "treat 4 spaces like a tab
set showcmd "show partial commands in the right or the status area
set hidden "allow hidden buffers. VERY GOOD. see help
set nobackup "dont make those filename~ files (they have bitten me many times)
set noswapfile "more trouble than they're worth
set wildmenu "show possible completions in command (:) mode (try hitting tab twice)
set wildmode=list:longest,full "make the wildmenu behave more like bash
set wildignore+=*.o,*.git,*.svn "ignore these files
set wildignore+=*/build/* "ignore these dirs
set ignorecase "dont care about case in searches, etc.
set smartcase "care about case if I enter any capital letters
let mapleader = ',' "use , instead of \ as the 'leader' key (used in some plugins)
set nostartofline "don't go to the start of line after certain commands
set formatoptions-=o "don't insert comment chars when I hit o or O
set formatoptions+=j " remove comment mark when joining lines
" Breaks python code:
"set formatoptions+=a "automatically reflow comment blocks (:h fo-table)
set autoread "automatically reread files that have been updated. useful with git
set gdefault " the /g flag on :s substitutions by default
set virtualedit=block " allow block selections to go past the end of lines

let python_highlight_all=1 "highlight everything possible in python
let python_highlight_space_errors=0 "except spacing issues
let perl_extended_vars=1 " highlight advanced perl vars inside strings

set number "show line numbers

"use control-[hjkl] to move between windows
nnoremap <silent><C-j> <C-w>j
nnoremap <silent><C-k> <C-w>k
nnoremap <silent><C-l> <C-w>l
nnoremap <silent><C-h> <C-w>h

nnoremap <C-p> :CommandT<CR>

"use shift-[hl] to move between buffers (tabs if you use MiniBufExplorer)
nnoremap <silent><S-h> :MBEbp<CR>
nnoremap <silent><S-l> :MBEbn<CR>

"use readline maps in command mode
cnoremap <C-a> <HOME>
cnoremap <C-e> <END>

"disable this when in the QuickFix window
"autocmd FileType qf nunmap <S-h>
"autocmd FileType qf nunmap <S-l>
autocmd! FileType qf set nospell
autocmd! FileType conque_term set nospell
autocmd! FileType haskell set nospell

"dont require a shift to enter command mode
nnoremap ; :
"make shift Y behave like shift-[cd] (copy to end of line)
nnoremap Y y$

"a cool debugging line (hit _if in 'normal' (not insert) mode to try it)
nnoremap _if ofprintf(0<C-d>stderr, "{%s}:{%d} - \n", __FILE__, __LINE__);<Esc>F\i 
autocmd! FileType cpp nnoremap _if ocout << __FILE__ << " " << __LINE__  << " " << __FUNCTION__ << " - " << endl;<Esc>F"i 

"use shift-w to save the file as root (I forget to use "sudo vim" a lot)
command! -bar -nargs=0 W  :silent exe "write !sudo tee % >/dev/null"|silent edit!

"autosave on make
"cabbr make wa\|make

"better indentation (keeps selection)
vnoremap > >gv
vnoremap < <gv

" use ghc functionality for haskell files
au Bufenter *.hs compiler ghc

" autodetect scons files
au BufNewFile,BufRead SCons* set filetype=scons 

" allow use of tab and s-tab in command-t window
let g:CommandTSelectNextMap=['<C-n>', '<C-j>', '<Down>', '<Tab>']
let g:CommandTSelectPrevMap=['<C-p>', '<C-k>', '<Up>', '<S-Tab>']

autocmd! FileType go setlocal sts=4 ts=4 noexpandtab

"If using vim7 
if version >= 700
  autocmd! FileType tex setlocal grepprg=grep\ -nH\ $*
  set spell "enable spell checking use ":set nospell" to turn it off for a single buffer
  set spelllang=en_us "use US dictionary for spelling
  set completeopt=longest,menu,preview "make auto-complete less stupid
endif

if version >= 703
    set undofile
    set undodir=~/.vim-undo/
endif

autocmd! BufWritePost .vimrc source %
autocmd! BufWritePost .gvimrc source %

if filereadable('./SConstruct')
    set makeprg=scons
endif

let g:ycm_confirm_extra_conf = 0
let g:ycm_enable_diagnostic_signs = 0

let g:CommandTMaxDepth = 17
let g:CommandTMaxFiles = 100000
let g:CommandTFileScanner = "find"

autocmd! FileType c,cpp nnoremap <silent>gg :YcmComplete GoTo<CR>

set nolazyredraw
