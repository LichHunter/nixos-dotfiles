{ config, lib, pkgs, ... }:

{
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      PermitRootLogin = null;
    };
  };
}
