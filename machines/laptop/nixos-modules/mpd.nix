{ config, lib, pkgs, username, ... }:

{
  systemd.services.mpd.environment = {
    # https://gitlab.freedesktop.org/pipewire/pipewire/-/issues/609
    XDG_RUNTIME_DIR = "/run/user/1000";
  };

  services.mpd = {
    enable = true;
    user = "${username}";
    musicDirectory = "/home/${username}/Music";
    extraConfig = ''
      audio_output {
          type "pipewire"
          name "My PipeWire Output"
      }
      audio_output {
        type                    "fifo"
        name                    "my_fifo"
        path                    "/tmp/mpd.fifo"
        format                  "44100:16:2"
      }
    '';
    network = {
      listenAddress = "any"; # if you want to allow non-localhost connections
    };
  };
}
