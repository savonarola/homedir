set shell=bash

set nocompatible              " be iMproved
filetype off                  " required!

set rtp+=~/.vim/bundle/Vundle.vim/
call vundle#begin()

" let Vundle manage Vundle
" required!
Plugin 'VundleVim/Vundle.vim'

" Lang support

Plugin 'chr4/nginx.vim'

Plugin 'editorconfig/editorconfig-vim'

" Search helpers

Plugin 'rking/ag.vim'

" Common goodies

Plugin 'corntrace/bufexplorer'
Plugin 'Xuyuanp/git-nerdtree'
Plugin 'bling/vim-airline'
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'

" Custom configs

Plugin 'savonarola/vimfiles'

" Other common goodies

Plugin 'scrooloose/nerdcommenter'

call vundle#end()            " required
filetype plugin indent on    " required

if filereadable(glob("~/.vimrc.local"))
    source ~/.vimrc.local
endif
