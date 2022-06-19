{ pkgs, ... }:
let
  bg = "#282a36";
  fg = "#f8f8f2";
  cat-black = "#161320";
  cat-green = "#ABE9B3";
in {
  programs.rofi = {
    enable = true;   
    package = pkgs.rofi.override {
        plugins = with pkgs; [
          rofi-emoji
        ];
      };
    extraConfig = {
      modi = "run,drun,filebrowser,emoji";
      show-incons = true;
      icon-theme = "Papirus";
      drun-display-format = "{icon} {name}";
    };
    font = "Source Code Pro Medium 13";

  };
}

