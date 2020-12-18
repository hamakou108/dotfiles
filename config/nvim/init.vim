" remove autocommands which are already present
augroup MyAutoCmd
  autocmd!
augroup END

" Map space key to mapleader. Mainly use mapleader to call plugin feature.
" Note: This definition must come before defining key mappings of plugins.
let mapleader = "\<Space>"

" dein settings {{{
" define the install directory of dein.vim (XDG_CACHE_HOME is for Neovim)
let s:cache_home = empty($XDG_CACHE_HOME) ? expand('~/.cache') : $XDG_CACHE_HOME
let s:dein_dir = s:cache_home . '/dein'
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

" git clone if the repository does noe exist
if !isdirectory(s:dein_repo_dir)
  execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
endif

" add runtime path
if isdirectory(s:dein_repo_dir)
  execute 'set runtimepath^=' . s:dein_repo_dir
endif
" }}}

" load plugins {{{
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)
  call dein#load_toml(expand('~/.config/nvim/dein.toml'),      {'lazy': 0})
  call dein#load_toml(expand('~/.config/nvim/dein_lazy.toml'), {'lazy': 1})
  call dein#end()
  call dein#save_state()
endif

if dein#check_install()
  call dein#install()
endif

autocmd VimEnter * call dein#call_hook('post_source')
" }}}

" load other settings {{{
runtime! options.rc.vim
runtime! keymap.rc.vim
runtime! filetype.rc.vim
" }}}

