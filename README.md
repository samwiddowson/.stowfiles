# Sam's dotfiles -- stowed

## stow

`pacman -S stow`

usage: from within the .stowfiles directory, `stow nvim` will symlink `.stowfiles/nvim/.config/nvim` to `~/.config/nvim`

## General

- install stow (see above)
- install kitty (if straight linux)
- install nvim
- install nvm
  - and node through this
- install ripgrep
- install prettierd: `npm i -g @fsouza/prettierd`
- install eslint: `npm i -g eslint`
- install oh-my-posh
- install tmux
  - also install [tpm (tmux plugin manager)](https://github.com/tmux-plugins/tpm)
- install [ stow ](https://www.gnu.org/software/stow) from [ source ](https://ftp.gnu.org/gnu/stow)
- install yazi
- install eza
- install zoxide

## tmux

Remember: in tmux, before sourcing the new file, it will be Ctrl-B, r to source the new file

After that the tmux leader is Ctrl+Space.

Use `Ctrl+Space, I` (capital I) to install tmux plugins
