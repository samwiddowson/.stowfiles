#!/bin/zsh

pkill -f mediaplayer.py
pkill waybar
pkill mako
pkill hypridle

sleep 0.3

hyprshutdown
