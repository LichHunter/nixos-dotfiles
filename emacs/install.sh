#!/usr/bin/env sh

if ! command -v emacs &> /dev/null
then
    echo "emacs is not on your path"
    exit
fi

git clone --depth 1 https://github.com/hlissner/doom-emacs ~/.config/emacs
~/.config/emacs/bin/doom install
