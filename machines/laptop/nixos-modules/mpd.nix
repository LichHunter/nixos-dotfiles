{ config, lib, pkgs, ... }:

{
  systemd.services.mpd.environment = {
    # https://gitlab.freedesktop.org/pipewire/pipewire/-/issues/609
    XDG_RUNTIME_DIR = "/run/user/1000";
  };

  services.mpd = {
    enable = true;
    user = "${config.variables.username}";
    musicDirectory = "/home/${config.variables.username}/Music";
    extraConfig = ''
      audio_output {
          type "pipewire"
          name "My PipeWire Output"
      }
    '';
    network = {
      listenAddress = "any"; # if you want to allow non-localhost connections
    };
  };
}
