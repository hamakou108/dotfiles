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
make_link ${dotfiles_dir}/config/cmux/cmux.json ~/.config/cmux/cmux.json
make_link ${dotfiles_dir}/config/ghostty/config.ghostty ~/.config/ghostty/config.ghostty
make_link ${dotfiles_dir}/config/git/gitconfig ~/.gitconfig
make_link ${dotfiles_dir}/config/git/ignore ~/.config/git/ignore
make_link ${dotfiles_dir}/config/herdr/config.toml ~/.config/herdr/config.toml
make_link ${dotfiles_dir}/config/nvim ~/.config/nvim
make_link ${dotfiles_dir}/config/zsh/zshrc ~/.zshrc
make_link ${dotfiles_dir}/config/agents/AGENTS.md ~/.codex/AGENTS.md
make_link ${dotfiles_dir}/config/agents/AGENTS.md ~/.claude/CLAUDE.md
make_link ${dotfiles_dir}/config/agents/skills ~/.agents/skills
make_link ${dotfiles_dir}/config/claude/agents ~/.claude/agents
make_link ${dotfiles_dir}/config/claude/hooks ~/.claude/hooks
make_link ${dotfiles_dir}/config/claude/rules ~/.claude/rules

# link each skill rather than ~/.claude/skills itself, which Claude Code writes skills synced from the account into
for skill in ${dotfiles_dir}/config/agents/skills/*/; do
    make_link ${skill%/} ~/.claude/skills/$(basename ${skill})
done

# render configuration files that tools on this machine write to
bash ${dotfiles_dir}/bin/render-claude-settings.sh || exit 1

# update profiles
touch ~/.bash_profile
