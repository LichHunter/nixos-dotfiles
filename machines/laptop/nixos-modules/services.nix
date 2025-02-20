{ config, lib, pkgs, ... }:

{
  services = {
    xserver = {
      enable = true;
      xkb = {
        layout = "us,ru";
        options = "grp:grp:shifts_toggle";
      };
    };

    printing.enable = true;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    pulseaudio.enable = false;

    udev = {

      packages = with pkgs; [
        qmk
        qmk-udev-rules # the only relevant
        qmk_hid
        via
        vial
      ]; # packages

    }; # udev
  };
}
