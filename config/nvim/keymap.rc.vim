" Time in milliseconds to wait for a mapped sequence to complete
:set timeoutlen=3000

" Normal mode {{{
" When 'wrap' on, go N screen lines up or down
nnoremap j gj
nnoremap k gk
nnoremap <Down> gj
nnoremap <Up> gk

" Yank the characters under the cursor until the end of the line
nnoremap Y y$
"}}}

