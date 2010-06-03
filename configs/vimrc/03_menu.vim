set wildmenu
set wcm=<Tab>
menu Encoding.koi8-r :e ++enc=koi8-r<CR>
menu Encoding.windows-1251 :e ++enc=cp1251<CR>
menu Encoding.cp866 :e ++enc=cp866<CR>
menu Encoding.utf-8 :e ++enc=utf8 <CR>

map <F3>        :emenu Encoding.<TAB>
map <C-e>       :emenu Encoding.<TAB>
imap <C-e>      <Esc>:emenu Encoding.<TAB>


menu FileFormat.UNIX :e ++ff=unix
menu FileFormat.DOS :e ++ff=dos
menu FileFormat.Mac :e ++ff=mac
map <F4>        :emenu FileFormat.<TAB>

