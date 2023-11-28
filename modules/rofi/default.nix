{ config, lib, pkgs, ... }:

{
  programs.rofi = {
    enable = true;
    #theme = ./arc-dark.rasi;
    theme =
      let
        inherit (config.lib.formats.rasi) mkLiteral;
      in {
        "*" = {
          selected-normal-foreground=  mkLiteral "rgba ( 249, 249, 249, 100 % )";
          foreground=                  mkLiteral "rgba ( 196, 203, 212, 100 % )";
          normal-foreground=           mkLiteral "@foreground";
          alternate-normal-background= mkLiteral "rgba ( 64, 69, 82, 59 % )";
          red=                         mkLiteral "rgba ( 220, 50, 47, 100 % )";
          selected-urgent-foreground=  mkLiteral "rgba ( 249, 249, 249, 100 % )";
          blue=                        mkLiteral "rgba ( 38, 139, 210, 100 % )";
          urgent-foreground=           mkLiteral "rgba ( 204, 102, 102, 100 % )";
          alternate-urgent-background= mkLiteral "rgba ( 75, 81, 96, 90 % )";
          active-foreground=           mkLiteral "rgba ( 101, 172, 255, 100 % )";
          lightbg=                     mkLiteral "rgba ( 238, 232, 213, 100 % )";
          selected-active-foreground=  mkLiteral "rgba ( 249, 249, 249, 100 % )";
          alternate-active-background= mkLiteral "rgba ( 75, 81, 96, 89 % )";
          background=                  mkLiteral "rgba ( 45, 48, 59, 95 % )";
          alternate-normal-foreground= mkLiteral "@foreground";
          normal-background=           mkLiteral "@background";
          lightfg=                     mkLiteral "rgba ( 88, 104, 117, 100 % )";
          selected-normal-background=  mkLiteral "rgba ( 64, 132, 214, 100 % )";
          border-color=                mkLiteral "rgba ( 124, 131, 137, 100 % )";
          spacing=                     2;
          separatorcolor=              mkLiteral "rgba ( 29, 31, 33, 100 % )";
          urgent-background=           mkLiteral "rgba ( 29, 31, 33, 17 % )";
          selected-urgent-background=  mkLiteral "rgba ( 165, 66, 66, 100 % )";
          alternate-urgent-foreground= mkLiteral "@urgent-foreground";
          background-color=            mkLiteral "rgba ( 0, 0, 0, 0 % )";
          alternate-active-foreground= mkLiteral "@active-foreground";
          active-background=           mkLiteral "rgba ( 29, 31, 33, 17 % )";
          selected-active-background=  mkLiteral "rgba ( 68, 145, 237, 100 % )";
        };

        "window" = {
            background-color= mkLiteral "@background";
            border= mkLiteral "1";
            padding= mkLiteral "5";
        };
        "mainbox" = {
            border= mkLiteral "0";
            padding= mkLiteral "0";
        };
        "message" = {
            border= mkLiteral "2px 0px 0px";
            border-color= mkLiteral "@separatorcolor";
            padding= mkLiteral "1px";
        };
        "textbox" = {
            text-color= mkLiteral "@foreground";
        };
        "listview" = {
            fixed-height = 0;
            border= mkLiteral "2px 0px 0px ";
            border-color= mkLiteral "@separatorcolor";
            spacing= mkLiteral "2px";
            scrollbar=    true;
            padding= mkLiteral "2px 0px 0px";
        };
        "element" = {
            border=  0;
            padding= mkLiteral "1px";
        };
        "element.normal.normal" = {
            background-color= mkLiteral "@normal-background";
            text-color= mkLiteral "@normal-foreground";
        };
        "element.normal.urgent" = {
            background-color= mkLiteral "@urgent-background";
            text-color= mkLiteral "@urgent-foreground";
        };
        "element.normal.active" = {
            background-color= mkLiteral "@active-background";
            text-color= mkLiteral "@active-foreground";
        };
        "element.selected.normal" = {
            background-color= mkLiteral "@selected-normal-background";
            text-color= mkLiteral "@selected-normal-foreground";
        };
        "element.selected.urgent" = {
            background-color= mkLiteral "@selected-urgent-background";
            text-color= mkLiteral "@selected-urgent-foreground";
        };
        "element.selected.active" = {
            background-color= mkLiteral "@selected-active-background";
            text-color= mkLiteral "@selected-active-foreground";
        };
        "element.alternate.normal" = {
            background-color= mkLiteral "@alternate-normal-background";
            text-color= mkLiteral "@alternate-normal-foreground";
        };
        "element.alternate.urgent" = {
            background-color= mkLiteral "@alternate-urgent-background";
            text-color= mkLiteral "@alternate-urgent-foreground";
        };
        "element.alternate.active" = {
            background-color= mkLiteral "@alternate-active-background";
            text-color= mkLiteral "@alternate-active-foreground";
        };
        "scrollbar" = {
            width= mkLiteral "4px";
            border=       0;
            handle-color= mkLiteral "@normal-foreground";
            handle-width= mkLiteral "8px";
            padding=      0;
        };
        "mode-switcher" = {
            border= mkLiteral "2px 0px 0px";
            border-color= mkLiteral "@separatorcolor";
        };
        "button" = {
            spacing=    0;
            text-color= mkLiteral "@normal-foreground";
        };
        "button.selected" = {
            background-color= mkLiteral "@selected-normal-background";
            text-color= mkLiteral "@selected-normal-foreground";
        };
        "inputbar" = {
            spacing=    0;
            text-color= mkLiteral "@normal-foreground";
            padding= mkLiteral "1px";
        };
        "case-indicator" = {
            spacing= 0;
            text-color= mkLiteral "@normal-foreground";
        };
        "entry" = {
            spacing=    0;
            text-color= mkLiteral "@normal-foreground";
        };
        "prompt" = {
            spacing=    0;
            text-color= mkLiteral "@normal-foreground";
        };
        "inputbar" = {
            children= map mkLiteral [ "prompt" "textbox-prompt-colon" "entry" "case-indicator"];
        };
        "textbox-prompt-colon" = {
            expand=     false;
            str= mkLiteral ":";
            margin= mkLiteral "0px 0.3em 0em 0em";
            text-color= mkLiteral "@normal-foreground";
        };
      };
  };
}
