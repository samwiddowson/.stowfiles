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
    - terminal stuff:
        - fzf
        - ripgrep
        - ffmpeg
        - fd
        - yazi
        - eza
        - zoxide
        - imagemagick
    - mpd
    - wiremix (TUI audio device/volume manager)
    - impala (TUI network connection manager)
- hyprland
    - `sudo pacman -S hyprland hyprpolkitagent hyprpaper hyprlock hypridle hyprshutdown hyprsysteminfo waybar wofi`
    - `yay -S hyprshutdown hyprworm`
    - run `hyprctl monitors` to get monitor names and tweak `hypr/.config/hypr/land/monitors.conf`
- keyd
    - for some changes that allow me to use macos muscle memory.
        - Note that this makes all SUPER+V and other similar keys remap as C-v etc
        - `sudo pacman -S keyd`
        - `sudo vim /etc/keyd/default.conf`
            - contents of the file:

```toml
[ids]
*

[main]
meta = layer(meta_as_ctrl)

[meta_as_ctrl:M]
c = C-c
v = C-v
x = C-x
a = C-a
z = C-z
w = C-w
r = C-r
t = C-t
```

- `sudo systemctl enable --now keyd`

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
