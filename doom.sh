#!/bin/sh

DOOM="$HOME/.emacs.d"

  git clone https://github.com/hlissner/doom-emacs.git $DOOM
  alacritty -e $DOOM/bin/doom -y install & disown

