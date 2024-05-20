{ config, lib, pkgs, ... }:

{
  programs.beets = {
    enable = true;
    mpdIntegration = {
      enableStats = true;
      enableUpdate = true;
    };
    settings = {
      directory = "~/Music";
      #library = "~/Music/data/musiclibrary.db";
      #import.copy = "no";
      paths = {
        default = "$albumartist/$albumartist - $album - ($year)/$track $title";
      };
    };
  };
}
