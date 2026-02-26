#!/bin/zsh

pkill -f mediaplayer.py
pkill waybar
pkill mako
pkill hypridle
pkill hyprsunset
pkill wl-paste

# pkill hyprls
tmux kill-server

sleep 0.3

hyprshutdown
