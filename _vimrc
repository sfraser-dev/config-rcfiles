" Based on .vimrc from "Coming Home to Vim" by Steve Losh

" Use pathogen plugin / run-time manager
call pathogen#runtime_append_all_bundles()
" call pathogen#infect()
" call pathogen#helptags()

" Remember marks, registers, searches buffer list
" set viminfo='20,<50,s10,h,%
" Keep a big history
set history=1000

" vi-improved mode
set nocompatible

" Silent 
" set noerrorbells
" Switch to current files directory
" set autochdir

" Syntax highlighting
syntax on
" Change indentation behaviour based on filetype
filetype plugin indent on

" Auto format code
" gg=G  , gg=1G=Goto first line, "="=format, G=last line

" Line modifications
set modelines=0
set tabstop=4
set shiftwidth=4
set softtabstop=4
" Expand with spaces when using tab-key
set expandtab
set encoding=utf-8
set scrolloff=3
set autoindent
set showmode
set showcmd
" Cycle buffers without writing
set hidden
" File completion
set wildmenu
set wildmode=list:longest
set visualbell
" Line under cursor
set cursorline
" Update window title
" set title
set ttyfast
" Display cursor location
set ruler
" Allow backspacing in insert mode
set backspace=indent,eol,start
set laststatus=2
" set relativenumber
" Esc mode:se nu and :se nonu
set number
" Saves a .X.un~ binary revision file, use ":undo" or "u"in ESC 
" mode to undo last changes.
set undofile  

" See :help c.vim or :help: perl.vim
" folding settings: za=fold, zM=fold all, zR=unfold all
" set foldmethod=indent     " fold based on indent
set foldmethod=syntax       " fold based on indent
set foldnestmax=10          " deepest fold is 10 levels
set nofoldenable            " dont fold by default
set foldlevel=1             " this is just what i use
" set foldcolumn=2          " this is just what i use (left column, 
                            " messes up
                            " copying and pasting, even with the <F2> i
                            " paste no indent option

" No \v when searching
"nnoremap / /\v
"vnoremap / /\v

" Better searching
set ignorecase
set smartcase
set gdefault
set incsearch
set showmatch
set hlsearch

" Persobal leader (activation) for personal mappings (commands) 
let mapleader = ","

" Sswitch off text highlighting after a search
nnoremap <leader><space> :noh<cr> 
" Use % key to see matching braces in code
nnoremap <tab> %
vnoremap <tab> %

" Handle long lines better
" set wrap
" set textwidth=79
" set formatoptions=qrn1
" set colorcolumn=85

" A new vertical window
nnoremap <leader>w <C-w>v<C-w>l
" :vnew file.txt appears to be more useful thorough
" Switch windows with <C-w>{h,j,k,l}
" :NERDTree "t"=open file in new tab: "gt" (fwd tab),"gT" (bck tab)
" "s"=open in new vertical window (split), "i"=new horizontal window
" Terminator terminal better for splitting terminal windows, or uses
" Pytyle2 (based on Xmonad WM)
" goto next tab (gt)
map  <S-Right> :tabn<CR>
" goto next previous tab (gT)
map  <S-Left> :tabp<CR>
" new tab
map  <C-n> :tabnew<CR>      

" TComment mapleader, use ,c rather than ctrl-_ctrl-_
map <leader>c <c-_><c-_>
" Can select multiple lines in visual mode (ctrl-v)

" Call make from within vim (with a Makefile in ../../build/linux)
" !make -C ../../build/linux/

" Source the repmo.vim plugin which repeats last command,
" very useful for jumping forward X lines:
" eg: 10j (jump forward 10 lines)
" ";" (repeat last command, from repmo.vim)
so ~/.vim/autoload/repmo.vim

" Toggle indent off/on so can (copy and) paste without auto-indenting
nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>
set showmode

" Remember cusor position from last session
function! ResCur()
  if line("'\"") <= line("$")
    normal! g`"
    return 1
  endif
endfunction
augroup resCur
  autocmd!
  autocmd BufWinEnter * call ResCur()
augroup END

" If you find yourself always re :so ing your vimrc after you changed it, 
" have the following autocmd in your vimrc:
autocmd! bufwritepost .vimrc source %
