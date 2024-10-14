{ config, lib, pkgs, username, ... }:

with lib;

let
  cfg = config.uzume.gitlab;
in {
  options.uzume.gitlab.enable = mkEnableOption "gitlab config";

  config = mkIf cfg.enable {
    sops.secrets = {
      "gitlab-db-password" = {
        owner = config.users.users.${username}.name;
        inherit (config.users.users.${username}) group;
      };
      "gitlab-root-password" = {
        owner = config.users.users.${username}.name;
        inherit (config.users.users.${username}) group;
      };
      "gitlab-secret" = {
        owner = config.users.users.${username}.name;
        inherit (config.users.users.${username}) group;
      };
      "gitlab-otp-secret" = {
        owner = config.users.users.${username}.name;
        inherit (config.users.users.${username}) group;
      };
      "gitlab-db-secret" = {
        owner = config.users.users.${username}.name;
        inherit (config.users.users.${username}) group;
      };
    };

    services.gitlab = {
      enable = true;
      databasePasswordFile = config.sops.secrets."gitlab-db-password".path;
      initialRootPasswordFile = config.sops.secrets."gitlab-root-password".path;
      secrets = {
        secretFile = config.sops.secrets."gitlab-secret".path;
        otpFile = config.sops.secrets."gitlab-otp-secret".path;
        dbFile = config.sops.secrets."gitlab-db-secret".path;
        jwsFile = pkgs.runCommand "oidcKeyBase" {} "${pkgs.openssl}/bin/openssl genrsa 2048 > $out";
      };
    };

    systemd.services.gitlab-backup.environment.BACKUP = "dump";
  };
}
