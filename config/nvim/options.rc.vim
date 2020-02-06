" Display {{{
" No wrap by default
:set nowrap

" Display as much as possible of the last line in a window
:set display+=lastline

" The minimal number of screen lines or columns to keep around the cursor
:set scrolloff=2
:set sidescrolloff=4

" Syntax highlighting
:syntax on

" Colorscheme
:set background=dark
:colorscheme hybrid

" Show whitespace characters like tabs
:set list
:set listchars=tab:>-,extends:>,precedes:<,trail:-

" When a bracket is inserted, briefly jump to the matching one
:set showmatch
:set matchtime=1

" Print the line number in front of each line
:set number

" Status line
:set laststatus=2
":set statusline=%<%f\ %m\ %r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=\ LINE=%l/%L\ COLUMN=%c
"}}}

" Searching {{{
" Incremental and highligh search
:set incsearch
:set hlsearch

" Search pattern for upper case
:set ignorecase
:set smartcase

" Search help about the word under cursor (use "K").
:set keywordprg=:help
"}}}

" Moving {{{
" Allow specified keys to move to the previous/next line
:set whichwrap=b,s,h,l,<,>,[,],~
"}}}

" Editting {{{
" multi-byte character formatting
:set formatoptions+=mM

" Disable automatically insert the current comment leader
:set formatoptions-=or

" Allow Backspacing in Insert mode
:set backspace=indent,eol,start

" indenting and tabs by default
:set smartindent
:set expandtab
:set shiftwidth=2
:set tabstop=2
:set softtabstop=2

" Remove dust before saving the file
function! s:remove_dust()
  let cursor = getpos(".")
    " Remove spaces in the end of the line
    %s/\s\+$//ge
    " Convert tabs into spaces
    "%s/\t/  /ge
  call setpos(".", cursor)
  unlet cursor
endfunction
au BufWritePre * call <SID>remove_dust()
"}}}

" Completion {{{
" The maximum number of items to show in the popup menu for Insert mode completion
:set pumheight=10
"}}}

" Visual {{{
" enable virtual editing in visual-block mode
:set virtualedit+=block
"}}}

" Command line {{{
:set wildmenu
:set wildmode=longest,list,full
"}}}

" File {{{
" Character encoding (see also ":help encoding-names")
:set fileencoding=utf-8
:set fileencodings=utf-8,iso-2022-jp,cp932,sjjs,euc-jp
"}}}

" Buffer {{{
" keep the changed buffer without saving it
:set hidden
"}}}

" Others {{{
" Use clipboard register ('+' and '*') for all yank, delete, change
if (has('mac') && executable('pbcopy')) || (has('unix') && executable('xsel'))
  :set clipboard&
  :set clipboard+=unnamed
  :set clipboard+=unnamedplus
endif
"}}}

" Neovim {{{
if has('nvim')
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif
"}}}

