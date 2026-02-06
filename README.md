# Sam's dotfiles -- stowed

This repository contains dotfiles managed with GNU Stow.

## Stow

Stow is a symlink farm manager that helps you manage your dotfiles by creating symbolic links from a central repository to their appropriate locations in your home directory.

The benefit of using Stow is that it keeps your dotfiles organized in a single directory while allowing you to easily deploy them to your home directory.

### Installing Stow

```shell
sudo pacman -Syu stow
```

### Using Stow

From within the .stowfiles directory, `stow nvim` will symlink `nvim/.config/nvim` to `~/.config/nvim`

## General notes on the setup

- better shell
  - install zsh and zsh-completions
- install stow (see above)
- install nvim
  - install ripgrep (required for nvim plugins)
- A nicer terminal application
  - install kitty
    - Install 0xProto nerd font
- For Node development:
  - install nvm
  - and node through this
  - install prettierd: `npm i -g @fsouza/prettierd`
  - install eslint: `npm i -g eslint`
- Prettier CLI:
  - install oh-my-posh
    - Install 0xProto nerd font (if not already done for kitty)
- Terminal multiplexer:
  - install tmux
    - also install [tpm (tmux plugin manager)](https://github.com/tmux-plugins/tpm)
- Recommended additional tools:
  - fzf
  - fd
  - yazi
  - eza
  - zoxide
  - imagemagick

## zsh

To change to `zsh` shell:

- `chsh -l` to list available shells
- `chsh -s /full/path/to/shell`

## tmux

The tmux configuration included here is fairly specialised to my workflow and keybind preferences, but feel free to adapt it to your needs.

The tmux plugins require tpm (tmux plugin manager) to be installed (see above).

Before sourcing the included configuration, it will be necessary to press the following keybinds to source the new file: `Ctrl-B, r`

After that the tmux leader will be `Ctrl+Space`.

Use `Ctrl+Space, I` (capital I) to install tmux plugins. This will improve the status bar with git information and other useful features.

## to look into

[Chezmoi](https://www.chezmoi.io/) might be a better alternative to managing dotfiles across environments (i.e. Linux an MacOS) than my current method of branching:
