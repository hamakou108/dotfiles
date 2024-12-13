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

### Set your profiles

Rename author name and email in `gitconfig`.

```ini:config/git/gitconfig
[user]
	name = <your_name_here>
	email = <your_email_here>
```

## Requirements

## Acknowledgments
