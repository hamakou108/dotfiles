#!/bin/bash

# create links to configuration files
dotfiles_dir=$(cd $(dirname ${BASH_SOURCE:-$0}); cd ../; pwd)
ln -nsf ${dotfiles_dir}/config/nvim ~/.config/
ln -nsf ${dotfiles_dir}/config/nvim ~/.vim
ln -sf ${dotfiles_dir}/config/nvim/init.vim ~/.vimrc
ln -sf ${dotfiles_dir}/config/nvim/oni/config.tsx ~/.config/oni/config.tsx
ln -sf ${dotfiles_dir}/config/zsh/zshrc ~/.zshrc
ln -sf ${dotfiles_dir}/config/tmux/tmux.conf ~/.tmux.conf

# update profiles
touch ~/.bash_profile
touch ~/.zprofile
