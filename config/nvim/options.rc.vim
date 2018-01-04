" <表示>
" 構文毎の色分け
:syntax on
" 文番号の表示
:set number
" 不可視文字の表示
:set list
:set listchars=tab:>-,extends:>,precedes:<,trail:-
"対応する括弧の強調表示
:set showmatch
" 上下・左右の視界の確保
:set scrolloff=2
:set sidescrolloff=4

" remove dust before saving the file
function! s:remove_dust()
  let cursor = getpos(".")
    " remove space in the end of the line
    %s/\s\+$//ge
    " convert tab character into space
    "%s/\t/  /ge
  call setpos(".", cursor)
  unlet cursor
endfunction
au BufWritePre * call <SID>remove_dust()

" <検索>
" インクリメンタルサーチの有効化
:set incsearch
"ヒット結果のハイライト表示
:set hlsearch
" 検索時に大文字小文字を区別しない
:set ignorecase
" 検索文字が大文字なら小文字を検索しない
:set smartcase

" <移動>
" 折り返しの無効化
:set nowrap

" 行を跨いでの移動
:set whichwrap=b,s,h,l,<,>,[,],~

" <Tabとインデント>
" インデント，行末，行頭でのbackspaceを有効化
:set backspace=indent,eol,start
" オートインデントの有効化
:set smartindent
" Tabをスペースに変更
:set expandtab
:set tabstop=2
:set softtabstop=2
" インデント幅の設定
:set shiftwidth=2

" <その他>
" マウス入力の有効化
:set mouse=a
" ステータス行の表示と設定
:set laststatus=2
":set statusline=%<%f%m%r%h%w\ LINE=%l/%L\ COLUMN=%c
:set statusline=%<%f\ %m\ %r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=\ LINE=%l/%L\ COLUMN=%c
" 文字のエンコーディング
" :set encoding=utf-8
:set fileencoding=utf-8
:set fileencodings=utf-8,iso-2022-jp,cp932,sjjs,euc-jp
" 改行コードのエンコーディング
:set fileformat=unix "max, dos
" use clipboard register ('+' and '*') for all yank, delete, change
if (has('mac') && executable('pbcopy')) || (has('unix') && executable('xsel'))
  set clipboard&
  set clipboard+=unnamed
  set clipboard+=unnamedplus
endif
" GNOMEの場合に256色表示を有効にする
if $COLORTERM == 'gnome-terminal'
  set t_Co=256
endif
" ssh接続などで256色表示を有効にする
if $TERM == 'screen'
  set t_Co=256
endif
" colorschemeの設定
colorscheme jellybeans

" Neovim
if has('nvim')
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif
