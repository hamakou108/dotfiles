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

`link.sh` also renders `~/.claude/settings.json` from `config/claude/settings.json` as a regular file, so that changes written by Claude Code or herdr are kept out of this repository. `${HOME}` in the template is replaced with the home directory. Rendering requires `jq`, which recent macOS versions include and the Brewfile installs. To apply changes to the template, run:

```shell
bash ./bin/render-claude-settings.sh
```

If the existing file differs from the template, the script prints the difference and backs up the file before overwriting it, so changes made on the machine since the last render are replaced. Move any change worth keeping into the template, or reapply it after rendering.

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
