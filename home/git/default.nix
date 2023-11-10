{ config, pkgs, ... }:

{
    # basic configuration of git, please change to your own
    programs.git = {
      enable = true;
      userName = "Alexander Derevianko";
      userEmail = "alexander0derevianko@gmail.com";
    };
}
