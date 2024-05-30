{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    fftw
  ];

  programs.ncmpcpp = {
    enable = true;
    bindings = [
      { key = "j"; command = "scroll_down"; }
      { key = "k"; command = "scroll_up"; }
      { key = "J"; command = [ "select_item" "scroll_down" ]; }
      { key = "K"; command = [ "select_item" "scroll_up" ]; }
    ];
    settings = {
      user_interface = "alternative";
      colors_enabled = "yes";
      visualizer_fifo_path = "/tmp/mpd.fifo";
      visualizer_output_name = "my_fifo";
      visualizer_sync_interval = "30";
      visualizer_in_stereo = "yes";
      visualizer_type = "wave";# (spectrum/wave)
      #visualizer_type = "spectrum";
    };
  };
}
