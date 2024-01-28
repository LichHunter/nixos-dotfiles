{ config, lib, pkgs, ... }:

let
  swaylock-command = "swaylock --screenshots --clock --indicator-idle-visible --indicator-radius 100 --indicator-thickness 7 --ring-color 455a64 --key-hl-color be5046 --text-color ffc107 --line-color 00000000 --inside-color 00000088 --separator-color 00000000 --fade-in 0.1 --effect-scale 0.5 --effect-blur 7x3 --effect-scale 2 --effect-vignette 0.5:0.5 \"$@\"";
in {
  services.swayidle = {
    enable = true;

    events = [
      { event = "before-sleep"; command = "\"${pkgs.swaylock-effects}/bin/swaylock --screenshots --clock --indicator-idle-visible --indicator-radius 100 --indicator-thickness 7 --ring-color 455a64 --key-hl-color be5046 --text-color ffc107 --line-color 00000000 --inside-color 00000088 --separator-color 00000000 --fade-in 0.1 --effect-scale 0.5 --effect-blur 7x3 --effect-scale 2 --effect-vignette 0.5:0.5 \"$@\"\""; }
      { event = "lock"; command = "\"${pkgs.swaylock-effects}/bin/swaylock --screenshots --clock --indicator-idle-visible --indicator-radius 100 --indicator-thickness 7 --ring-color 455a64 --key-hl-color be5046 --text-color ffc107 --line-color 00000000 --inside-color 00000088 --separator-color 00000000 --fade-in 0.1 --effect-scale 0.5 --effect-blur 7x3 --effect-scale 2 --effect-vignette 0.5:0.5 \"$@\"\""; }
    ];

    timeouts = [
      { timeout = 60; command = "\"${pkgs.swaylock-effects}/bin/swaylock --screenshots --clock --indicator-idle-visible --indicator-radius 100 --indicator-thickness 7 --ring-color 455a64 --key-hl-color be5046 --text-color ffc107 --line-color 00000000 --inside-color 00000088 --separator-color 00000000 --fade-in 0.1 --effect-scale 0.5 --effect-blur 7x3 --effect-scale 2 --effect-vignette 0.5:0.5 \"$@\""; }
      #{ timeout = 90; command = "${pkgs.systemd}/bin/systemctl suspend"; }
    ];
  };
}
