{ config, lib, pkgs, ... }:

with lib;

let
in {
  options.dov.hypr.enable = mkEnableOption "hypr config";
  options.dov.kanshi.enable = mkEnableOption "kanshi config";
  options.dov.shell.zsh.enable = mkEnableOption "zsh config";
  options.dov.shell.fish.enable = mkEnableOption "fish config";
  options.dov.browser.firefox.enable = mkEnableOption "firefox config";
  options.dov.browser.brave.enable = mkEnableOption "brave config";
  options.dov.browser.chrome.enable = mkEnableOption "chrome config";
  options.dov.vpn.enable = mkEnableOption "vpn config";
  options.dov.gaming.enable = mkEnableOption "gaming config";
}
