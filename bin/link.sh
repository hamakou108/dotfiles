#!/bin/bash

function make_link () {
    src=$1
    dst=$2

    if [[ -e $dst && ! -L $dst ]]; then
        echo "$dst is not a symbolic link"
        return 1
    fi

    if [[ ! -e $(dirname $dst) ]]; then
        mkdir -p $(dirname $dst)
    fi

    if [[ -f $src ]]; then
        ln -sf $src $dst
    elif [[ -d $src ]]; then
        ln -nsf $src $dst
    fi
}

# create links to configuration files
dotfiles_dir=$(cd $(dirname ${BASH_SOURCE:-$0}); cd ../; pwd)
make_link ${dotfiles_dir}/config/nvim           ~/.config/nvim
make_link ${dotfiles_dir}/config/nvim           ~/.vim
make_link ${dotfiles_dir}/config/nvim/init.vim  ~/.vimrc
make_link ${dotfiles_dir}/config/git/gitconfig  ~/.gitconfig
make_link ${dotfiles_dir}/config/zsh/zshrc      ~/.zshrc
make_link ${dotfiles_dir}/config/tmux/tmux.conf ~/.tmux.conf
make_link ${dotfiles_dir}/config/oni/config.tsx ~/.config/oni/config.tsx
make_link ${dotfiles_dir}/config/hyper/hyper.js ~/.hyper.js
make_link ${dotfiles_dir}/bin/ide.sh            ~/ide.sh

# update profiles
touch ~/.bash_profile
touch ~/.zprofile
