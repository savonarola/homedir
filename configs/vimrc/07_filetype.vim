filetype plugin on

au FileType perl set iskeyword=@,48-57,_,192-255,:

au BufRead,BufNewFile *.phps set filetype=php
au BufRead,BufNewFile *.thtml set filetype=php
au BufRead,BufNewFile *.pl set filetype=perl
au BufRead,BufNewFile *.pm set filetype=perl
au BufRead,BufNewFile *.rb set filetype=ruby
au BufRead,BufNewFile *.hrl set filetype=erlang
au BufRead,BufNewFile *.haml set filetype=haml

