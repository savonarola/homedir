function g:TabCompleteWrapper()
let col = col('.') - 1
if !col || getline('.')[col - 1] !~ '\k'
return "\<tab>"
else
return "\<space>\<backspace>\<c-p>"
endif
endfunction
imap <tab> <space><backspace><c-r>=g:TabCompleteWrapper()<cr>

set complete=""
set complete+=.
set complete+=k
set complete+=b
set complete+=t

set completeopt-=preview
set completeopt+=longest
set mps-=[:]
