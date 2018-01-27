" 挿入モードからノーマルモード
inoremap <C-J> <Esc>

" ファイルの直前までの絶対パスを補完
cnoremap <C-X> <C-R>=expand("%:p:h")<CR>/

" ファイルの絶対パスを補完
cnoremap <C-Z> <C-R>=expand("%:p:r")<CR>

" 表示行で移動する．
nnoremap j gj
nnoremap k gk
nnoremap <Down> gj
nnoremap <Up> gk

" 日本語の行の連結時には空白を入力しない．
set formatoptions+=mM

" 画面最後の行をできる限り表示する．
set display+=lastline

" for denite
"nmap [denite] <Nop>
"nmap <C-J> [denite]
"nmap <silent> [denite]<C-P> :<C-u>Denite file_rec -highlight-mode-insert=Search<CR>
