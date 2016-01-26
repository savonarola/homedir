set shell=bash

set nocompatible              " be iMproved
filetype off                  " required!

set rtp+=~/.vim/bundle/Vundle.vim/
call vundle#begin()

" let Vundle manage Vundle
" required!
Plugin 'VundleVim/Vundle.vim'

Plugin 'tpope/vim-fugitive'
Plugin 'rosstimson/scala-vim-support'
Plugin 'Xuyuanp/git-nerdtree'
Plugin 'bling/vim-airline'
Plugin 'corntrace/bufexplorer'
Plugin 'vim-scripts/VimClojure'
Plugin 'mattn/codepad-vim'
Plugin 'mattn/webapi-vim'
Plugin 'mattn/gist-vim'
Plugin 'tpope/vim-rails'
Plugin 'vim-scripts/taglist.vim'
Plugin 'Keithbsmiley/rspec.vim'
Plugin 'terryma/vim-multiple-cursors'

Plugin 'savonarola/vimfiles'
Plugin 'ingydotnet/yaml-vim'
Plugin 'scrooloose/nerdcommenter'
Plugin 'mileszs/ack.vim'
Plugin 'motus/pig.vim'
Plugin 'elixir-lang/vim-elixir'
Plugin 'lambdatoast/elm.vim'
Plugin 'evanmiller/nginx-vim-syntax'
Plugin 'rking/ag.vim'

call vundle#end()            " required
filetype plugin indent on    " required

