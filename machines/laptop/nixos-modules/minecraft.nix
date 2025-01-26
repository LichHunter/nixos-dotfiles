{ config, lib, pkgs, username, ... }:

with lib;

let
  cfg = config.dov.gaming.minecraft;
  modpack = pkgs.fetchPackwizModpack {
    url = "https://raw.githubusercontent.com/LichHunter/meatballcraft/refs/heads/main/pack.toml";
    packHash = "sha256-L5RiSktqtSQBDecVfGj1iDaXV+E90zrNEcf4jtsg+wk=";
  };
in {
  options.dov.gaming.minecraft.enable = mkEnableOption "minecraft server config";

  config = mkIf cfg.enable {
    users.users."${username}".packages = with pkgs; [
      prismlauncher
    ];

    # services.minecraft-servers.servers.cool-modpack = {
    #   enable = true;
    #   package = pkgs.fabricServers.fabric-1_18_2.override { loaderVersion = "0.14.9"; };
    #   symlinks = {
    #     "mods" = "${modpack}/mods";
    #   };
    # };
  };
}
