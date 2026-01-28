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
- Install Yabai and skhd for tiling window management on macOS
    - brew install asmvik/formulae/yabai
    - brew install koekeishiya/formulae/skhd
    - create a sudoers entry for yabai as per the instructions after installation
        - at time of writing: `echo "$(whoami) ALL=(root) NOPASSWD: sha256:$(shasum -a 256 $(which yabai) | cut -d " " -f 1) $(which yabai) --load-sa" | sudo tee /private/etc/sudoers.d/yabai`

## tmux

The tmux configuration included here is fairly specialised to my workflow and keybind preferences.

The tmux plugins require tpm (tmux plugin manager) to be installed (see above).

Before sourcing the included configuration, it will be necessary to press the following keybinds to source the new file: `Ctrl-B, r`

After that the tmux leader will be `Ctrl+Space`.

Use `Ctrl+Space, I` (capital I) to install tmux plugins. This will improve the status bar with git information and other useful features.

## Yabai
Yabai is a tiling window manager for macOS. The configuration included here is tailored to my preferences.

Yabai and skhd (simple hotkey daemon) need to be installed separately (see above instructions).

To start, stop or restart yabai, use the following commands:
```shell
yabai --start-service
yabai --stop-service
yabai --restart-service
```
