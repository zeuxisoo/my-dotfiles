" Vundle
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'

Plugin 'gmarik/vundle'
Plugin 'tomasr/molokai'
Plugin 'Yggdroot/indentLine' " If mac, need brew install vim with v7.4
call vundle#end()
filetype plugin indent on

" Plugin - tomasr/molokai
colorscheme molokai

" Custom
set tabstop=4                   " numbers of spaces of tab character
set shiftwidth=4                " numbers of spaces to (auto)indent
set softtabstop=4               " must same as shiftwidth
set laststatus=2                " allways show status line
set scrolloff=3                 " keep 3 lines when scrolling
set linespace=0                 " line space, only work in GUI

set autoindent                  " auto indent
set cindent                     " c / java indent style
set copyindent                  " copy the previous indentation on autoindenting

set smarttab                    " insert tabs on the start of a line according to
set expandtab                   " tabs are converted to spaces, use only when required

set visualbell                  " turn on visual sound
set noerrorbells                " disable sound on error
set t_vb=                       " disable sound on error
set tm=500                      " disable sound on error

set wrap                        " word wrap without line breaks
set linebreak                   " word wrap without line breaks
set nolist                      " word wrap without line breaks

set backspace=indent,eol,start  " backspace can handle indent, eol and start
set history=1000                " keep 1000 lines of command line history
set undolevels=1000             " use many muchos levels of undo
set number                      " show line numbers
set numberwidth=4               " line numbers width
set nobackup                    " do not keep a backup file
set noswapfile                  " do not keep a backup file
set nowritebackup               " do not keep a backup file
set ruler                       " show the cursor position all the time
set autoread                    " auto read when file is changed from outside
set cursorline                  " highlight current line
set title                       " automatically set screen title
set showmode                    " show input or replace mode at bottom
set nobomb                      " no BOM(Byte Order Mark)
set nofoldenable                " folding off
set nostartofline               " don't jump to first character when paging
set splitright                  " always open vertical split window in the right side
set splitbelow                  " always open horizontal split window below
set scrolloff=5                 " start scrolling when n lines away from margins
set showtabline=2               " always show tab
set wildmenu                    " make tab completion for files/buffers act like bash
set wildmode=list:longest
set viminfo=                    " disable .viminfo file
set ttyfast                     " send more chars while redrawing
set hlsearch                    " search highlighting
set incsearch                   " incremental search
set ignorecase                  " ignore case when searching
set smartcase                   " if there are caps, go case-sensitive
set t_Co=256                    " using GUI color settings in a termina
set shortmess=Ia                " remove splash wording tips screen
set hidden                      " support change file when exists unsave file

filetype on                     " enable filetype detection
filetype indent on              " enable filetype-specific indenting
filetype plugin on              " enable filetype-specific plugins

syntax on                       " syntax highlighing
syntax enable                   " syntax highlighing

" leader
let mapleader=","

" file encoding
set encoding=utf-8
set fileencodings=ucs-bom,utf-8,big5,euc-jp,gbk,euc-kr,utf-bom,iso8859-1,euc-jp,utf-16le,latin1
set fenc=utf-8 enc=utf-8 tenc=utf-8
scriptencoding utf-8

" remove tailing whitespace
autocmd BufWritePre * :%s/\s\+$//e

" cancel highlight keyword on search
noremap ; :nohlsearch<CR>

" identation tab and shift+tab in normal, visual mode, insert mode
nmap <TAB> v>
nmap <S-TAB> v<
vmap <TAB> >gv
vmap <S-TAB> <gv
imap <S-TAB> <Esc><<i

" support ctrl+c and ctrl+v
noremap <C-c> y
noremap <C-v> P

" support ctrl+a
map <C-A> ggVG

" auto set paste mode when command+v entered
" - https://github.com/ConradIrwin/vim-bracketed-paste
if &term =~ "xterm.*" || &term =~ "screen*"
  function! WrapForTmux(s)
    if !exists('$TMUX')
      return a:s
    endif

    let tmux_start = "\<Esc>Ptmux;"
    let tmux_end = "\<Esc>\\"

    return tmux_start . substitute(a:s, "\<Esc>", "\<Esc>\<Esc>", 'g') . tmux_end
  endfunction

  let &t_SI .= WrapForTmux("\<Esc>[?2004h")
  let &t_EI .= WrapForTmux("\<Esc>[?2004l")

  function! XTermPasteBegin(ret)
    set pastetoggle=<f29>
    set paste
    return a:ret
  endfunction

  execute "set <f28>=\<Esc>[200~"
  execute "set <f29>=\<Esc>[201~"
  map <expr> <f28> XTermPasteBegin("i")
  imap <expr> <f28> XTermPasteBegin("")
  vmap <expr> <f28> XTermPasteBegin("c")
  cmap <f28> <nop>
  cmap <f29> <nop>
endif
