{ config, lib, pkgs, ... }:

with lib;

{
  options.dov.kanshi.enable = mkEnableOption "kanshi config";
  options.dov.shell.zsh = {
    enable = mkEnableOption "zsh config";
    shellAliases = mkOption {
      type = types.attrs;
      default = {};
    };
  };
  options.dov.shell.fish.enable = mkEnableOption "fish config";
  options.dov.shell.addon.starship.enable = mkEnableOption "starship config";
  options.dov.browser.firefox.enable = mkEnableOption "firefox config";
  options.dov.browser.brave.enable = mkEnableOption "brave config";
  options.dov.browser.chrome.enable = mkEnableOption "chrome config";
  options.dov.browser.qutebrowser.enable = mkEnableOption "qutebrowser config";
  options.dov.vpn.enable = mkEnableOption "vpn config";
  options.dov.gaming.enable = mkEnableOption "gaming config";
}
