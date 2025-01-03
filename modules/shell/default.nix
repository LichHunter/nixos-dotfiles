{ config, lib, pkgs, ... }:

{
  imports = [
    ./bash
    ./zsh
    ./fish
    ./addon
  ];
}
