# dotfiles

## Installation

Clone this repository.

```
$ git clone git@github.com:hamakou108/dotfiles.git
$ cd dotfiles
```

Run ``link.sh`` to create links to dotfiles.

```
$ ./bin/link.sh
```

## Requirements

### Neovim

- Python >3.8.0
- Node.js >12.13.1

Install client on Python and Node.js respectively.

```
$ pip install pynvim
$ npm install neovim
```

#### defx-icons

Install [Nerd Fonts](https://github.com/ryanoasis/nerd-fonts) and set it in your terminal, otherwise icons will be garbled.

```
brew tap homebrew/cask-fonts
brew install font-hack-nerd-font
```

#### coc.nvim

For coc-phpls, set Intelephense licence (license) key to environment variable.

```
export PHP_INTELEPHENSE_LICENCE_KEY='YOUR_LICENCE_KEY'
```

## Acknowledgments

- [yymm/.dotfiles](https://github.com/yymm/.dotfiles/tree/master/config/nvim)
- [craftzdog/dotfiles-public](https://github.com/craftzdog/dotfiles-public)

