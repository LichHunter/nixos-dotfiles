{ config, lib, pkgs, ... }:

{
  services.gitea = {
    enable = true;

    settings = {
      service = {
        DISABLE_REGISTRATION = true;
      };
    };
  };
}