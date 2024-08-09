# Sam's dotfiles -- stowed

## TO FIX
fix clipboard copy/paste (not sure if this is a local system issue or an nvim config issue)

## If using WSL
* install wsl via powershell (refer to Microsoft documentation)

## General
* install alacritty (if straight linux)
* install nvim
* install nvm
  * and node through this
* install ripgrep
* install prettierd: `npm i -g @fsouza/prettierd`
* install oh-my-posh
* install tmux
  * also install [tpm (tmux plugin manager)](https://github.com/tmux-plugins/tpm)
* install [ stow ](https://www.gnu.org/software/stow) from [ source ](https://ftp.gnu.org/gnu/stow)
* install yazi
* install eza
* install zoxide


## tmux
Remember: in tmux, before sourcing the new file, it will be Ctrl-B, r to source the new file

After that the tmux leader is Ctrl+Space.

Use Ctrl+Space, I (capital I) to install tmux plugins

## stow

usage: from within the .stowfiles directory, `stow nvim` will symlink the contents of the nvim subdirectory to the home directory

i.e. create the .config/nvim directory as a symlink to the one in .stowfiles


