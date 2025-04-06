{ config, lib, pkgs, ... }:

{
  imports = [
    ./brave
    ./chrome
    ./firefox
    ./qutebrowser
    ./vivaldi
    ./ladybird
    ./librewolf
    ./zen
  ];
}
