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
# Homebrew
if command -q which brew
    set -x HOMEBREW_PREFIX (brew --prefix)

    # for Apple Silicon
    switch (uname -m)
    case "arm64"
        fish_add_path $HOMEBREW_PREFIX/bin
    end

    ################################################################################
    # Fisher
    # After fisher command has been sourced, run `fisher update` manually. Don't
    # write `fisher update` in this file, or Fish would get into infinite loop.
    if ! type -q fisher
        curl -sL https://git.io/fisher | source
    end

    ################################################################################
    # Tmux
    alias tmux='tmux -2'
    set -x TERM screen-256color

    ################################################################################
    # SSH
    alias ssh='set -x TERM screen ssh'

    ################################################################################
    # NeoVim
    # alias
    if type -q nvim
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
    fish_add_path $HOMEBREW_PREFIX/opt/coreutils/libexec/gnubin
    fish_add_path $HOMEBREW_PREFIX/opt/ed/libexec/gnubin
    fish_add_path $HOMEBREW_PREFIX/opt/findutils/libexec/gnubin
    fish_add_path $HOMEBREW_PREFIX/opt/gnu-sed/libexec/gnubin
    fish_add_path $HOMEBREW_PREFIX/opt/gnu-tar/libexec/gnubin
    fish_add_path $HOMEBREW_PREFIX/opt/grep/libexec/gnubin

    if test -d $HOMEBREW_PREFIX/opt/coreutils/libexec/gnubin
        alias ls='ls -F --color=auto'
        alias la='ls -aF --color=auto'
        alias ll='ls -lF --color=auto'
    end

    ################################################################################
    # asdf
    source $HOMEBREW_PREFIX/opt/asdf/libexec/asdf.fish
end
