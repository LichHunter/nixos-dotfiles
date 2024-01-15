{ inputs, config, lib, pkgs, ... }:

{
  home-manager.users."omen" = {
    dconf.settings."org/gnome/desktop/interface".font-name = lib.mkForce "JetBrainsMono Nerd Font 12";
  };
}
