function! s:FindEmAll(needle, path)
    cgetexpr system('find '.a:path.' -type f -not \( -iname "*.swp" -or -iname "*.jpg" -or -iname "*.png" -or -iname "*.gif" -or -iname "*.log" \) -print0 \| xargs -0 egrep -n "'.a:needle.'" \| sed -e "s/:(\d+)/\|$1\|/"' )
    copen
    wincmd L
endfunction
 
command! -complete=file -nargs=+ Find call s:FindEmAll(<f-args>)

set path+=./**
set suffixesadd=.pl,.pm,.yml,.yaml,.hs " for `gf' (open file under cursor)
map <C-H> :Moccur<cr>

