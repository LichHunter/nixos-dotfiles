## enter root and nix-shell
``` bash
sudo su
nix-shell -p neovim git
```

## clone configuration and checkout impermanence branch
``` bash
git clone https://github.com/LichHunter/nixos-dotfiles
git checkout impermanence
```

## disko formatting command
```bash
sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko -- --mode disko ./disko.nix --arg device '"/dev/nvme0n1"'
```

## move confuration to /mnt/persist/nixos
```bash
mkdir -p /mnt/persist/nixos 
cp -r /home/nixos/nixos-dotfiles /mnt/persist/nixos
```

## installing nixos
```bash
nixos-install --root /mnt --flake /mnt/persist/nixos#default
```

