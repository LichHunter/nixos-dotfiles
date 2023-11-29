{ config, lib, pkgs, ... }:

{
  programs = {
    git = {
      enable = true;
      userName = "Alexander";
      userEmail = "alexander0derevianko@gmail.com";
    };
  };
}
