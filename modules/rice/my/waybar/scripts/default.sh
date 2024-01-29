#!/usr/bin/env bash

if [[ $(pidof waybar) ]]; then
    kill $(pidof waybar)
fi

while pgrep -u $UID -x waybar > /dev/null; do sleep 1; done

if [[ ! $(pidof waybar) ]]; then
    waybar --config config --style style.css
fi
