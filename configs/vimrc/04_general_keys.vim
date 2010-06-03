vmap <C-C> "+y
imap <C-V> <esc>"+gP
vmap <C-V> "+gP
vmap <C-X> "+x

map <S-Insert> <MiddleMouse>

nmap <C-y> dd
imap <C-y> <esc>ddi

"nmap ; :%s/\<<c-r>=expand("<cword>")<cr>\>/

nmap <F2> :w<cr>
vmap <F2> <esc>:w<cr>
imap <F2> <esc>:w<cr>

nmap <F5> <Esc>:BufExplorer<cr>
vmap <F5> <esc>:BufExplorer<cr>
imap <F5> <esc><esc>:BufExplorer<cr>

map <F6> :bp<cr>
vmap <F6> <esc>:bp<cr>
imap <F6> <esc>:bp<cr>

map <F7> :bn<cr>
vmap <F7> <esc>:bn<cr>
imap <F7> <esc>:bn<cr>

map <F8> :TlistToggle<cr>
vmap <F8> <esc>:TlistToggle<cr>
imap <F8> <esc>:TlistToggle<cr>

map <F9> :make<cr>
vmap <F9> <esc>:make<cr>
imap <F9> <esc>:make<cr>

map <F10> :bd<cr>
vmap <F10> <esc>:bd<cr>
imap <F10> <esc>:bd<cr>

map <F11> :Ex<cr>
vmap <F11> <esc>:Ex<cr>
imap <F11> <esc>:Ex<cr>

vmap < <gv
vmap > >gv

imap <Ins> <Esc>i

map <C-Q> <Esc>:qa<cr>
imap <C-S> <Esc>:w<CR>

