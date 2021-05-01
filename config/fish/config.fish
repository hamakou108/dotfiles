# License : MIT
#
# Note: only for MacOS

################################################################################
set -x LANG en_US.UTF-8

alias ls='ls -FG'
alias la='ls -aFG'
alias ll='ls -lFG'

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

alias mkdir='mkdir -p'

# enable alist after "sudo"
alias sudo='sudo '

################################################################################
# Fisher
# After fisher command has been sourced, run `fisher update` manually. Don't
# write `fisher update` in this file, or Fish would get into infinite loop.
if test ! (type fisher >/dev/null 2>&1)
    curl -sL https://git.io/fisher | source
end

################################################################################
# Tmux
alias tmux='tmux -2'
set -x TERM screen-256color

# split window like ide
alias ide='~/ide.sh'

################################################################################
# SSH
alias ssh='set -x TERM screen ssh'

################################################################################
# NeoVim
# alias
if test (type nvim)
    alias vi=(which nvim)
    alias vim=(which nvim)
    alias editor=(which nvim)
    function vimdiff
        set -l nvim_path (which nvim)
        command $nvim_path -d $argv
    end
end

# XDG_CONFIG_HOME
set -x XDG_CONFIG_HOME $HOME/.config

################################################################################
# GNU command utilities
fish_add_path /usr/local/opt/coreutils/libexec/gnubin
fish_add_path /usr/local/opt/ed/libexec/gnubin
fish_add_path /usr/local/opt/findutils/libexec/gnubin
fish_add_path /usr/local/opt/gnu-sed/libexec/gnubin
fish_add_path /usr/local/opt/gnu-tar/libexec/gnubin
fish_add_path /usr/local/opt/grep/libexec/gnubin

if test -d /usr/local/opt/coreutils/libexec/gnubin
    alias ls='ls -F --color=auto'
    alias la='ls -aF --color=auto'
    alias ll='ls -lF --color=auto'
end

################################################################################
# anyenv (https://github.com/anyenv/anyenv)
if test (type anyenv)
    anyenv init - fish | source
    if test ! -d (anyenv root)/plugins/anyenv-update
        mkdir -p (anyenv root)/plugins
        git clone https://github.com/znz/anyenv-update.git (anyenv root)/plugins/anyenv-update
    end
end

################################################################################
# pipenv
# if pipenv is installed and executable
if test (type pipenv)
    # to avoid the bug on macOS
    # cf. https://pipenv-ja.readthedocs.io/ja/translate-ja/diagnose.html#valueerror-unknown-locale-utf-8
    if test (uname) = 'Darwin'
        set -x LC_ALL en_US.UTF-8
    end
    # enable auto completion
    pipenv --completion | source
end

################################################################################
# awscli@1 (brew)
# cf. https://github.com/aws/aws-cli/issues/1079
fish_add_path /usr/local/opt/awscli@1/bin
if test (type aws_completer)
    complete --command aws --no-files --arguments '(begin; set --local --export COMP_SHELL fish; set --local --export COMP_LINE (commandline); aws_completer | sed \'s/ $//\'; end)'
end

