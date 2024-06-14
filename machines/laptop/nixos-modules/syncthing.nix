{ config, lib, pkgs, username, ... }:

with lib;

{
  options.dov.services.syncthing.enable = mkEnableOption "syncthing config";
  config = mkIf config.dov.services.syncthing.enable {
    services = {
      syncthing = {
        enable = true;
        user = "${username}";
        dataDir = "/home/${username}/syncthing";
        overrideDevices = false;     # overrides any devices added or deleted through the WebUI
        overrideFolders = false;     # overrides any folders added or deleted through the WebUI
        settings = {
          devices = {
            "phone" = { id = "JB36PIN-J4Q23RA-T6TJ5RE-E4ZHCG7-RJKJEXT-RHBIGNO-ITHI5IY-TFOCOAP"; };
            "server" = { id = "P3OYK6Y-QH6KZJR-QT4BHZW-PZRUUEA-FJARXZ5-QNCLXMH-YAAQABD-WBQY5QQ"; };
          };
          folders = {
            "Documents" = {         # Name of folder in Syncthing, also the folder ID
              path = "/home/${username}/Documents/shared";    # Which folder to add to Syncthing
            devices = [ "phone" "server" ];      # Which devices to share the folder with
            };
            # "Example" = {
              #   path = "/home/myusername/Example";
              #   devices = [ "device1" ];
              #   ignorePerms = false;  # By default, Syncthing doesn't sync file permissions. This line enables it for this folder.
              # };
          };
        };
      };
    };
  };
}
