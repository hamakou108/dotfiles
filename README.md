# dotfiles

## Installation

### Clone the repository

```shell
git clone git@github.com:hamakou108/dotfiles.git
cd dotfiles
```

### Create links

Then, Run ``link.sh`` to create links to dotfiles.

```shell
sh ./bin/link.sh
```

### Create Git local config

Create `~/.gitconfig.local` to store user-specific Git settings that should not be committed to this repository.

```shell:~/.gitconfig.local
[user]
	name = Your Name
	email = your.email@example.com
	signingkey = ssh-ed25519 AAAA...
```

## Requirements

## Acknowledgments

The Neovim configuration in `config/nvim` is derived from [LazyVim/starter](https://github.com/LazyVim/starter) and is licensed under the Apache License 2.0. See [config/nvim/README.md](config/nvim/README.md) for details.
