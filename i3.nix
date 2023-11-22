{ config, lib, pkgs, ... }:

let
  mod = "Mod4";
in {
  xsession.windowManager.i3 = {
    enable = true;
    package = pkgs.i3-gaps;

    config = {
      modifier = mod;

      fonts = {
        names = ["xft:URWGothic-Book"];
        size = 11.0;
      };

      keybindings = lib.mkOptionDefault {
        "${mod}+p" = "exec ${pkgs.rofi}/bin/rofi -show run";
        "${mod}+x" = "exec sh -c '${pkgs.maim}/bin/maim -s | xclip -selection clipboard -t image/png'";
        "${mod}+Shift+x" = "exec sh -c '${pkgs.i3lock}/bin/i3lock -c 222222 & sleep 5 && xset dpms force of'";
        "${mod}+Return" = "exec alacritty";
        "${mod}+Shift+Return" = "exec dolphin";

        # Focus
        "${mod}+j" = "focus left";
        "${mod}+k" = "focus down";
        "${mod}+l" = "focus up";
        "${mod}+semicolon" = "focus right";

        # Move
        "${mod}+Shift+j" = "move left";
        "${mod}+Shift+k" = "move down";
        "${mod}+Shift+l" = "move up";
        "${mod}+Shift+semicolon" = "move right";

        # My multi monitor setup
        "${mod}+m" = "move workspace to output DP-2";
        "${mod}+Shift+m" = "move workspace to output DP-5";

        "${mod}+u" = "border none";
        "${mod}+y" = "border pixel 1";
        "${mod}+n" = "border normal";

        "${mod}+h" = "split h;exec notify-send 'tile horizontally'";
        "${mod}+v" = "split v;exec notify-send 'tile vertically'";
        "${mod}+q" = "split toggle";
        "${mod}+f" = "fullscreen toggle";

        "${mod}+s" = "layout stacking";
        "${mod}+w" = "layout tabbed";
        "${mod}+e" = "layout toggle split";
        "${mod}+Shift+space" = "floating toggle";
      };

      startup = [
        {
          command = "nitrogen --set-scaled ~/Wallpapers/wallpaper.png";
          notification = false;
          always = true;
        }
        {
          command = "nm-applet";
          notification = false;
        }
        {
          command = "compton -b";
        }
        {
          command = "pkill polybar; polybar main-bar";
          notification = false;
          always = true;
        }
      ];

      # Set to empty to remove default i3bar
      bars = [];

      floating.criteria = [
        { title = "alsamixer"; }
        { title = "File Transfer*"; }
        { title = "i3_help"; }
        { class = "GParted"; }
        { class = "Lxappearence"; }
        { class = "Nitrogen"; }
      ];

      gaps = {
        inner = 10;
        outer = -4;
        smartGaps = true;
      };

      colors = {
        background = "#1f1f1f";
        focused = {
          border = "#c6c6c6";
          background = "#1f1f1f";
          text = "#c6c6c6";
          indicator = "#8abeb7";
          childBorder = "#8abeb7";
        };
        focusedInactive = {
          border = "#c6c6c6";
          background = "#1f1f1f";
          text = "#c6c6c6";
          indicator = "#8abeb7";
          childBorder = "#8abeb7";
        };
        unfocused = {
          border = "#c6c6c6";
          background = "#1f1f1f";
          text = "#c6c6c6";
          indicator = "#8abeb7";
          childBorder = "#8abeb7";
        };
        urgent = {
          border = "#c6c6c6";
          background = "#1f1f1f";
          text = "#c6c6c6";
          indicator = "#8abeb7";
          childBorder = "#8abeb7";
        };
        placeholder = {
          border = "#c6c6c6";
          background = "#1f1f1f";
          text = "#c6c6c6";
          indicator = "#8abeb7";
          childBorder = "#8abeb7";
        };
      };
    };
  };
}
