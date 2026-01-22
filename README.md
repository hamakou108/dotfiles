# dotfiles

## Installation

### Clone the repository

```shell
git clone --recursive git@github.com:hamakou108/dotfiles.git
cd dotfiles
```

This repository depends on [hamakou108/lazyvim-starter](https://github.com/hamakou108/lazyvim-starter) as a submodule. So, you need to use `--recursive` option to clone the repository.

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
