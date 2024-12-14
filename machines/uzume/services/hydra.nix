{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.uzume.hydra;
in {
  options.uzume.hydra.enable = mkEnableOption "hydra config";

  config = mkIf cfg.enable {
    services.hydra = {
      enable = true;
      port = 3050;
      hydraURL = "http://uzume:3050";
      notificationSender = "hydra@uzume";
    };
  };
}
