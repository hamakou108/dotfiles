#!/bin/sh

# create links to configuration files
dotfiles_dir=$(cd $(dirname ${BASH_SOURCE:-$0}); cd ../; pwd)
ln -nsf ${dotfiles_dir}/config/nvim ~/.config/
ln -nsf ~/.config/nvim ~/.vim
ln -sf ~/.config/nvim/init.vim ~/.vimrc
ln -sf ${dotfiles_dir}/config/nvim/init.vim ~/.vimrc
ln -sf ${dotfiles_dir}/config/zsh/zshrc ~/.zshrc
ln -sf ${dotfiles_dir}/tmux.conf ~/.tmux.conf

# update profiles
touch ~/.bash_profile
touch ~/.zprofile
