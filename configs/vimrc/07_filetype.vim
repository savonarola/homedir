filetype plugin on

au FileType perl set iskeyword=@,48-57,_,192-255,:
au FileType haskell set includeexpr=substitute(v:fname,'\\.','/','g')
au FileType scss set noexpandtab
au FileType haml set expandtab
au FileType perl set expandtab
au FileType ruby set expandtab

au BufRead,BufNewFile *.phps set filetype=php
au BufRead,BufNewFile *.thtml set filetype=php
au BufRead,BufNewFile *.pl set filetype=perl
au BufRead,BufNewFile *.pm set filetype=perl
au BufRead,BufNewFile *.ru set filetype=ruby
au BufRead,BufNewFile *.rb set filetype=ruby
au BufRead,BufNewFile *.json_builder set filetype=ruby
au BufRead,BufNewFile *.hrl set filetype=erlang
au BufRead,BufNewFile *.haml set filetype=haml
au BufRead,BufNewFile *.hs set filetype=haskell
au BufRead,BufNewFile *.coffee set filetype=coffee
au BufNewFile,BufRead *.scss set filetype=scss
au BufNewFile,BufRead *.config set filetype=erlang

