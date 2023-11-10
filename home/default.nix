{ config, pkgs, ... }:

let 
in {
  imports = [
    ./zsh   
    ./emacs
    #./bash
  ];
  
  xdg.enable = true;

  home.stateVersion = "23.05";
  home.username = "omen";
  home.homeDirectory = "/home/omen";

  home.file.".config/doom" = {
    source = ./doom;
  };
 #home.file.".emacs.d" = {
 #  source = pkgs.fetchFromGitHub {
 #    owner = "doomemacs";
 #    repo = "doomemacs";
 #    rev = "master";
 #    sha256 = "vrdwIu6F11OOSaS5SfgT/jx0Kvu7KaigthVGBENKR5k=";
 #  };
 #};

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    firefox
    kate
    #emacs
    docker

    # nix related
    nix-output-monitor
    emacs-all-the-icons-fonts
  ];

  programs = {
    # basic configuration of git, please change to your own
    git = {
      enable = true;
      userName = "Alexander Derevianko";
      userEmail = "alexander0derevianko@gmail.com";
    };

    # alacritty - a cross-platform, GPU-accelerated terminal emulator
    alacritty = {
      enable = true;
      # custom settings
      settings = {
        env.TERM = "xterm-256color";
        font = {
          size = 9;
          draw_bold_text_with_bright_colors = true;
        };
        scrolling.multiplier = 5;
        #selection.save_to_clipboard = true;
      };
    };

    neovim = {
      enable = true;
      #extraConfig = lib.fileContents ../path/to/your/init.vim;

      viAlias = true;
      vimAlias = true;
    };

    # Let home Manager install and manage itself.
    home-manager.enable = true;
  };
}
