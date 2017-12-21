# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
  # We have color support; assume it's compliant with Ecma-48
  # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
  # a case would tend to support setf rather than setaf.)
  color_prompt=yes
    else
  color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# prevent miss
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'

# prevent delete all files
#alias rm='trash-put'

# ifort
#source /opt/intel/composer_xe_2013.5.192/bin/compilervars.sh intel64
#source /opt/intel/composer_xe_2013.1.117/bin/compilervars.sh intel64 # megalodon or kanegon
#source /opt/intel/bin/compilervars.sh intel64

# prompt setting
export PS1="\[\e[1;37m\][\d \t \u@\h \W]\n\$\[\e[m\] "

# do not logout by Ctrl-D
set ignoreeof

# tmux
alias tmux='tmux -2'
export TERM=xterm-256color

# ssh
alias ssh='TERM=screen ssh'

## ssh-agent
#SSH_ROOT="$HOME/.ssh"
#SSH_AGENT_FILE="$SSH_ROOT/ssh-agent-info"
#AGENT_SOCK_FILE="/tmp/ssh-agent-$USER"
#test -f $SSH_AGENT_FILE && source $SSH_AGENT_FILE
#if ! ssh-add -l > /dev/null; then
#  ssh-agent > $SSH_AGENT_FILE
#  source $SSH_AGENT_FILE
#  ssh-add "$SSH_ROOT/id_rsa@tccmp-s" "$SSH_ROOT/id_rsa@github" "$SSH_ROOT/id_rsa@conoha"
#  #ssh-add `ls "$SSH_ROOT"/id_rsa@*`
#fi
#if test $SSH_AUTH_SOCK && [ $SSH_AUTH_SOCK != $AGENT_SOCK_FILE ]; then
#  ln -sf $SSH_AUTH_SOCK $AGENT_SOCK_FILE && export SSH_AUTH_SOCK=$AGENT_SOCK_FILE
#fi
#
## pyenv (you need to set environment variables only if you cloned pyenv from GitHub)
##export PYENV_ROOT="$HOME/.pyenv"
##export PATH="$PYENV_ROOT/bin:$PATH"
##eval "$(pyenv init -)"
#
## anaconda
## If you only use anaconda, you should set path
##export PATH="$PYENV_ROOT/versions/anaconda3-4.0.0/bin/:$PATH"
## If you also use pyenv, you should not set path but use activate
#alias activate="source $PYENV_ROOT/versions/anaconda3-4.0.0/bin/activate"
#
## XDG_CONFIG_HOME
#export XDG_CONFIG_HOME=$HOME/.config

