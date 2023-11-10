{ config, pkgs, ... }:

{
  imports = [
    ./zsh   
    #./bash
  ];

  # This value determines the home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update home Manager without changing this value. See
  # the home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "23.05";

  home.username = "omen";
  home.homeDirectory = "/home/omen";

  # link the configuration file in current directory to the specified location in home directory
  # home.file.".config/i3/wallpaper.jpg".source = ./wallpaper.jpg;

  # link all files in `./scripts` to `~/.config/i3/scripts`
  # home.file.".config/i3/scripts" = {
  #   source = ./scripts;
  #   recursive = true;   # link recursively
  #   executable = true;  # make all files executable
  # };

  # encode the file content in nix configuration file directly
  # home.file.".xxx".text = ''
  #     xxx
  # '';

  # basic configuration of git, please change to your own
  programs.git = {
    enable = true;
    userName = "Alexander Derevianko";
    userEmail = "alexander0derevianko@gmail.com";
  };

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    firefox
    kate
    emacs
    docker

    # nix related
    nix-output-monitor
  ];

  # alacritty - a cross-platform, GPU-accelerated terminal emulator
  programs.alacritty = {
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

  programs.neovim = {
    enable = true;
    #extraConfig = lib.fileContents ../path/to/your/init.vim;

    viAlias = true;
    vimAlias = true;
  };

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}
