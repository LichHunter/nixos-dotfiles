#!/usr/bin/env bash

yad --title "Desktop Help" --form --width=325 --height=400 --text="<b>Choose Waybar</b>" \
    --image "dialog-question" --image-on-top \
    --field="<b>Wabar default</b>:fbtn" 'bash -c "~/.config/waybar/default.sh"' \
    --field="<b>Wabar alt-1</b>:fbtn" 'bash -c "~/.config/waybar/alt-1.sh"' \
    --buton=Cancel!gtk-cancel:1
