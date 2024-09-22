{ config, lib, pkgs, ... }:

{
  services.hydra = {
    enable = true;
    port = 3050;
    hydraURL = "http://uzume:3050";
    notificationSender = "hydra@uzume";
  };
}
