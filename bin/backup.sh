#!/usr/bin/env sh

if [ ! -d "~/Backup" ]; then
    mkdir ~/Backup
fi

tar cfv ~/Backup/backup-$(date -d "today" +"%Y%m%d%H%M").tar ~/.gnupg ~/.ssh ~/Documents ~/Pictures ~/org ~/nixos-dotfiles
