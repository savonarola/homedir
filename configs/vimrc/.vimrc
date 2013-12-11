set nocompatible              " be iMproved
filetype off                  " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required!
Bundle 'gmarik/vundle'

Bundle 'tpope/vim-fugitive'
Bundle 'rosstimson/scala-vim-support'
Bundle 'scrooloose/nerdtree'
Bundle 'mileszs/ack.vim'
Bundle 'bling/vim-airline'
Bundle 'corntrace/bufexplorer'
Bundle 'vim-scripts/VimClojure'
Bundle 'mattn/codepad-vim'
Bundle 'tpope/vim-fugitive'
Bundle 'mattn/gist-vim'
Bundle 'tpope/vim-rails'
Bundle 'vim-scripts/taglist.vim'

Bundle 'savonarola/vimfiles'
Bundle 'scrooloose/nerdcommenter'

filetype plugin indent on     " required!
