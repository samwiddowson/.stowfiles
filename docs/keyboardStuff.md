# Notes on keyboard stuff

## Hyprland config for specific keyboards

To enable hyprland config for specific devices

- Get the name for the device to change from `hyprctl devices -j`
    - Note, tuxedo built-in laptop keyboard is `at-translated-set-2-keyboard`.
- Use a `devices {}` section which takes options just like the `input` section but overrides on a per-device basis.
- IMPORTANT: a `keyd` virtual keyboard will intercept inputs as a `keyd-virtual-keyboard`.
    - If `keyd` is used for an input device it will have to be referenced as the virtual keyboard in hyprland

## keyd

The following changes to make things behave a little more like MacOS:

- Note that this makes all SUPER+V and other similar keys remap as C-v etc
- swaps two keys which for some reason are the other way aroiund in macos even when using "GBPC" keyboard layout
- `sudo pacman -S keyd`
- `keyd monitor`
    - start typing and get a device id like `abcd:1234` for the keyboard to remap
- `sudo vim /etc/keyd/default.conf`
    - contents of the file:

```toml
[ids]
*

[main]
meta = layer(meta_as_ctrl)
grave = 102nd
102nd = grave

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

## Keebio Iris (or other) udev rules for using Via Configurator

- Use `keyd` to get the keyboard vendor id and product
    - in `abcd:1234`, `abcd` is vendor id and `1234` is product id
- Create `/etc/udev/rules.d/99-zz-keebio.rules` and add the following line:
    - `KERNEL=="hidraw*", ATTRS{idVendor}=="cb10", ATTRS{idProduct}=="1756", MODE="0666", TAG+="uaccess"`
    - confirm vendor id and idproduct match
- To apply the new rule without reboot:

```
sudo udevadm control --reload-rules
sudo udevadm trigger
```
