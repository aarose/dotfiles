"Vundle told me to do this
set nocompatible
filetype off

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

"Vundle plugins below
Plugin 'gmarik/Vundle.vim' "let Vundle manage Vundle (required)
Plugin 'scrooloose/syntastic'  " linting engine
Plugin 'altercation/vim-colors-solarized'
Plugin 'scrooloose/nerdtree'  " filesystem tree explorer
Plugin 'Valloric/YouCompleteMe'  " fuzzy-search code completion engine


" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required


" Open NERDTree with Ctrl-n
map <C-a> :NERDTreeToggle<CR>


" Syntax highlighting for code
syntax on

"Tab == 4 spaces
set expandtab
set tabstop=4
set shiftwidth=4 " number of spaces to use when auto-indenting

" insert tabs on the start of a line according to shiftwidth, not tabstop
" set smarttab

"Search is case-insensitive
set ignorecase
set smartcase

"System clipboard enabled
set clipboard^=unnamedplus

"Line to delineate where the 80char limit is
set colorcolumn=80
:hi ColorColumn ctermbg=Blue ctermfg=white

" No bells ringing
set visualbell
set noerrorbells
