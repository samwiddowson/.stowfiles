# Sam's dotfiles -- stowed

This repository contains dotfiles managed with GNU Stow.

## Stow

Stow is a symlink farm manager that helps you manage your dotfiles by creating symbolic links from a central repository to their appropriate locations in your home directory.

The benefit of using Stow is that it keeps your dotfiles organized in a single directory while allowing you to easily deploy them to your home directory.

### Installing Stow
```shell
brew install stow
```

### Using Stow
From within the .stowfiles directory, `stow nvim` will symlink `nvim/.config/nvim` to `~/.config/nvim`

## General notes on the setup
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

## tmux

Remember: in tmux, before sourcing the new file, it will be Ctrl-B, r to source the new file

After that the tmux leader is Ctrl+Space.

Use `Ctrl+Space, I` (capital I) to install tmux plugins
