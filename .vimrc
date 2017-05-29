set shell=bash

set nocompatible              " be iMproved
filetype off                  " required!

set rtp+=~/.vim/bundle/Vundle.vim/
call vundle#begin()

" let Vundle manage Vundle
" required!
Plugin 'VundleVim/Vundle.vim'

" Lang support

Plugin 'rosstimson/scala-vim-support'
Plugin 'vim-scripts/VimClojure'
Plugin 'ingydotnet/yaml-vim'
Plugin 'motus/pig.vim'
Plugin 'elixir-lang/vim-elixir'
Plugin 'lambdatoast/elm.vim'
Plugin 'evanmiller/nginx-vim-syntax'

Plugin 'editorconfig/editorconfig-vim'

" Framework support

Plugin 'tpope/vim-rails'
Plugin 'Keithbsmiley/rspec.vim'

" Search helpers

Plugin 'dyng/ctrlsf.vim'
Plugin 'mileszs/ack.vim'
Plugin 'rking/ag.vim'

" Common goodies

Plugin 'corntrace/bufexplorer'
Plugin 'Xuyuanp/git-nerdtree'
Plugin 'bling/vim-airline'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'tpope/vim-fugitive'

" Remote services

Plugin 'mattn/codepad-vim'
Plugin 'mattn/webapi-vim'
Plugin 'mattn/gist-vim'

" Custom configs

Plugin 'savonarola/vimfiles'

" Other common goodies

Plugin 'scrooloose/nerdcommenter'


call vundle#end()            " required
filetype plugin indent on    " required

if filereadable(glob("~/.vimrc.local"))
    source ~/.vimrc.local
endif
