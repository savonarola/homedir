function! s:Ghci()
    !ghci %
endfunction

function! s:GhciExt()
    !gnome-terminal --hide-menubar -x ghci %
endfunction
 
command! Gh call s:Ghci()
command! Ge call s:GhciExt()

