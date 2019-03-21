" Insert mode {{{
" Go back to Normal mode
inoremap <C-J> <Esc>
"}}}

" Normal mode {{{
" When 'wrap' on, go N screen lines up or down
nnoremap j gj
nnoremap k gk
nnoremap <Down> gj
nnoremap <Up> gk

" Yank the characters under the cursor until the end of the line
nnoremap Y y$
"}}}

" for denite
"nmap [denite] <Nop>
"nmap <C-J> [denite]
"nmap <silent> [denite]<C-P> :<C-u>Denite file_rec -highlight-mode-insert=Search<CR>
