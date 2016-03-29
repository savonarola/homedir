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
Plugin 'savonarola/vim-erlang-runtime'

call vundle#end()            " required
filetype plugin indent on    " required

if filereadable(glob("~/.vimrc.local"))
    source ~/.vimrc.local
endif

