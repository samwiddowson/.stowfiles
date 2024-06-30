# Sam's dotfiles -- stowed

## TO FIX
switch no-longer-maintained NVIM Packer package manager to [lazy.nvim](https://github.com/folke/lazy.nvim)

## If using WSL
* install wsl via powershell (refer to Microsoft documentation)

## General
* install nvim
  * If using Ubuntu it can be with `sudo snap install nvim --classic`
  * better to just build from source though
* update apt `sudo apt update`
* install build-essentials: `sudo apt install build-essential`
* install ripgrep: `sudo apt install ripgrep`
* install prettierd: `npm i -g @fsouza/prettierd`
* install oh-my-posh (I don't think the required stuff is included here)
* install tmux
  * also install [tpm (tmux plugin manager)](https://github.com/tmux-plugins/tpm)
* install [ stow ](https://www.gnu.org/software/stow) from [ source ](https://ftp.gnu.org/gnu/stow)

## tmux
Remember: in tmux, before sourcing the new file, it will be Ctrl-B, r to source the new file

After that the tmux leader is Ctrl+Space.

Use Ctrl+Space, I (capital I) to install tmux plugins

## stow

usage: from within the .stowfiles directory, `stow nvim` will symlink the contents of the nvim subdirectory to the home directory

i.e. create the .config/nvim directory as a symlink to the one in .stowfiles


