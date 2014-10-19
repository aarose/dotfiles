"Vundle told me to do this
set nocompatible
filetype off

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

"Vundle plugins below
Plugin 'gmarik/Vundle.vim' "let Vundle manage Vundle (required)
Plugin 'scrooloose/syntastic'
Plugin 'altercation/vim-colors-solarized'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required



" Syntax highlighting for code
syntax on

"Tab == 4 spaces
set expandtab
set ts=4

"Search is case-insensitive
set ignorecase
set smartcase

"System clipboard enabled
set clipboard^=unnamedplus

"Line to delineate where the 80char limit is
set colorcolumn=80
:hi ColorColumn ctermbg=Blue ctermfg=white
