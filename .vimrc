" <Plugins>
"
" dein settings {{{
"if &compatible
"  set nocompatible
"endif

" the path of directory including dein.vim
let s:cache_home = empty($XDG_CACHE_HOME) ? expand('~/.cache') : $XDG_CACHE_HOME
" the path of directory including dein.vim
let s:dein_dir = s:cache_home . '/dein'
" the path of dein.vim
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

" If there isn't dein, git clone.
if !isdirectory(s:dein_repo_dir)
  execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
endif
let &runtimepath = s:dein_repo_dir .",". &runtimepath

" read plugin lists and create cache
let s:toml_file = fnamemodify(expand('<sfile>'), ':h').'/dein.toml'
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir, [$MYVIMRC, s:toml_file])
  " These files are plugin lists (TOML)
  let s:toml      = expand('~/.dein.toml')
  let s:lazy_toml = expand('~/.dein_lazy.toml')
  call dein#load_toml(s:toml,      {'lazy': 0})
  call dein#load_toml(s:lazy_toml, {'lazy': 1})
  call dein#add('nanotech/jellybeans.vim', {'merged': 0})
  call dein#end()
  call dein#save_state()
endif

if dein#check_install()
  call dein#install()
endif

" }}}

au BufRead,BufNewFile *.md set filetype=markdown

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
" 拡張子がtexのファイルを編集するときだけ折り返しを有効化する．
if expand("%:t") =~ ".*\.tex"
  :set wrap
endif
" 拡張子がtxtのファイルを編集するときだけ折り返しを有効化する．
if expand("%:t") =~ ".*\.txt"
  :set wrap
endif
" 拡張子がhtmlのファイルを編集するときだけ折り返しを有効化する．
if expand("%:t") =~ ".*\.html"
  :set wrap
endif
" 拡張子がmdのファイルを編集するときだけ折り返しを有効化する．
if expand("%:t") =~ ".*\.md"
  :set wrap
endif
" 行を跨いでの移動
:set whichwrap=b,s,h,l,<,>,[,],~

" <Tabとインデント>
" インデント，行末，行頭でのbackspaceを有効化
:set backspace=indent,eol,start
" オートインデントの有効化
:set smartindent
" Tabをスペースに変更
:set expandtab
:set tabstop=4
:set softtabstop=4
" インデント幅の設定
:set shiftwidth=4

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
" 無名レジスタに入るデータを，+レジスタ（クリップボード）にも入れる
"if (executalble('pbcopy') || executalble('xclip') || executalble('xsel')) || has('clipboard')
"  :set clipboard+=unnamedplus
"end if
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

" Neovim
if has('nvim')
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif
