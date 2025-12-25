# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Language

Use English for all Git commit messages and documentation.

## Repository Overview

This is a macOS dotfiles repository that manages configuration files for various development tools. It uses symbolic links to connect config files from this repo to their expected locations.

## Setup Commands

```shell
# Clone with submodules (required - nvim config is a submodule)
git clone --recursive git@github.com:hamakou108/dotfiles.git

# Create symbolic links to all config files
sh ./bin/link.sh

# Install Homebrew packages
brew bundle --file=config/homebrew/Brewfile
```

## Structure

- `bin/link.sh` - Creates symlinks from this repo to home directory locations
- `config/git/gitconfig` - Git configuration (links to `~/.gitconfig`)
- `config/homebrew/Brewfile` - Homebrew package manifest
- `config/nvim/` - LazyVim configuration (submodule pointing to hamakou108/lazyvim-starter, links to `~/.config/nvim`)
- `config/zellij/` - Zellij terminal multiplexer config (links to `~/.config/zellij`)
- `config/zsh/zshrc` - Zsh configuration with oh-my-zsh (links to `~/.zshrc`)

## Key Dependencies

The zshrc expects these tools to be available (installed via Brewfile):

- **eza** - modern `ls` replacement (aliased as `ls`)
- **bat** - modern `cat` replacement (aliased as `cat`)
- **zoxide** - smart `cd` replacement (initialized on shell startup)
- **fd**, **ripgrep**, **dust**, **procs** - suggested alternatives for find/grep/du/ps
