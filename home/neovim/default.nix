{ config, pkgs, ... }:

{
    programs.neovim = {
      enable = true;
      #extraConfig = lib.fileContents ../path/to/your/init.vim;

      viAlias = true;
      vimAlias = true;
    };
}
