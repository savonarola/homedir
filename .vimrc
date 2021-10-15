set shell=bash

set nocompatible              " be iMproved
filetype off                  " required!

set rtp+=~/.vim/bundle/Vundle.vim/
call vundle#begin()

" let Vundle manage Vundle
" required!
Plugin 'VundleVim/Vundle.vim'

" Lang support

"Plugin 'rosstimson/scala-vim-support'
"Plugin 'vim-scripts/VimClojure'
"Plugin 'motus/pig.vim'
Plugin 'elixir-lang/vim-elixir'
"Plugin 'lambdatoast/elm.vim'
Plugin 'chr4/nginx.vim'
Plugin 'digitaltoad/vim-pug'
Plugin 'vim-erlang/vim-erlang-runtime'

Plugin 'editorconfig/editorconfig-vim'

" Search helpers

Plugin 'rking/ag.vim'

" Common goodies

Plugin 'corntrace/bufexplorer'
Plugin 'Xuyuanp/git-nerdtree'
Plugin 'bling/vim-airline'
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'
Plugin 'airblade/vim-gitgutter'
Plugin 'vim-syntastic/syntastic'

" Custom configs

Plugin 'savonarola/vimfiles'

" Other common goodies

Plugin 'scrooloose/nerdcommenter'

call vundle#end()            " required
filetype plugin indent on    " required

if filereadable(glob("~/.vimrc.local"))
    source ~/.vimrc.local
endif
