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

### Create coding agent credentials

Claude Code runs git and gh with credentials of their own, set in `env` of `config/claude/settings.json`, so that agents never use the 1Password SSH agent or the token `gh auth login` stores in the keychain:

- Commits are signed with `~/.ssh/id_ed25519_coding_agent_signing` instead of the 1Password key. A `SessionStart` hook (`config/claude/hooks/start-coding-agent-ssh-agent.sh`) loads the key into a dedicated ssh-agent, and agents sign through its socket at `~/.local/state/coding-agent/ssh-agent.sock` without being able to read the key.
- GitHub is reached over HTTPS with a fine-grained personal access token stored in `~/.config/gh-coding-agent`. SSH remote URLs are rewritten to HTTPS, and the keychain credential helper is disabled.

Create both on each machine:

1. Create the signing key without a passphrase, so that agents can sign unattended:

   ```shell
   ssh-keygen -t ed25519 -N "" -C "coding-agent-signing@$(hostname -s)" -f ~/.ssh/id_ed25519_coding_agent_signing
   ```

2. Register `~/.ssh/id_ed25519_coding_agent_signing.pub` on GitHub as a **Signing Key** only, not as an Authentication Key.
3. Create a fine-grained personal access token with your account as the resource owner, with Contents, Issues, and Pull requests set to read and write, and Actions and Commit statuses set to read-only. Leave out Workflows and Administration, so that agents can change neither workflows nor rulesets.
4. Copy the token, then store it without echoing it:

   ```shell
   mkdir -p ~/.config/gh-coding-agent && chmod 700 ~/.config/gh-coding-agent
   pbpaste | GH_CONFIG_DIR=~/.config/gh-coding-agent gh auth login --hostname github.com --git-protocol https --insecure-storage --with-token
   pbcopy < /dev/null
   ```

Processes started by git, such as `ssh-keygen` and the credential helper, run inside the sandbox even though git itself is excluded. The sandbox settings therefore allow reading the public key and the token directory, and connecting to the ssh-agent socket. The private key stays unreadable to agents, because hooks run outside the sandbox and only the hook reads it. The token stays readable, since gh and git need it; its repositories, permissions, and expiration limit what a leak can do.

## Requirements

## Acknowledgments

The Neovim configuration in `config/nvim` is derived from [LazyVim/starter](https://github.com/LazyVim/starter) and is licensed under the Apache License 2.0. See [config/nvim/README.md](config/nvim/README.md) for details.
