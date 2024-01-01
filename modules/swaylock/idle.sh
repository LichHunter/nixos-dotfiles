#!/usr/bin/env sh

swayidle \
	timeout 60 '~/.config/swaylock/lock.sh --grace 10 --fade-in 4' \
	timeout 80 'swaymsg "output * dpms off"' \
	resume 'swaymsg "output * dpms on"' \
	before-sleep '~/.config/swaylock/lock.sh'
