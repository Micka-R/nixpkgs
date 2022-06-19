{ pkgs, lib, ... }:

{
  xsession.windowManager.i3 = {
    enable = true;
    package = pkgs.i3-gaps;
    config = rec {
      modifier = "Mod4";
      bars = [ ];

      gaps = {
        inner = 10;
        outer = 5;
      };

      focus = {
        followMouse = false;

      };

      window = {
        border = 4;
      };

      colors = {
        focused = {
          background = "#285577"; 
          border = "#F5C2E7"; 
          childBorder = "#F5C2E7"; 
          indicator = "#F5C2E7"; 
          text = "#ffffff";
          };

        focusedInactive = { 
          background = "#5f676a"; 
          border = "#333333"; 
          childBorder = "#222222"; 
          indicator = "#292d2e"; 
          text = "#ffffff"; 
          };

        unfocused = { 
          background = "#222222"; 
          border = "#333333"; 
          childBorder = "#222222"; 
          indicator = "#292d2e"; 
          text = "#888888"; 
          };

        urgent = { 
          background = "#900000"; 
          border = "#2f343a"; 
          childBorder = "#900000"; 
          indicator = "#900000"; 
          text = "#ffffff"; 
        };

        placeholder =  { 
          background = "#0c0c0c"; 
          border = "#000000";
          childBorder = "#0c0c0c"; 
          indicator = "#000000"; 
          text = "#ffffff"; 
        };
      };

      keybindings = lib.mkOptionDefault {
        "XF86AudioMute" = "exec amixer set Master toggle";
        "XF86AudioLowerVolume" = "exec amixer set Master 4%-";
        "XF86AudioRaiseVolume" = "exec amixer set Master 4%+";
        "XF86MonBrightnessDown" = "exec brightnessctl set 4%-";
        "XF86MonBrightnessUp" = "exec brightnessctl set 4%+";
        "${modifier}+Return" = "exec alacritty";
        "${modifier}+d" = "exec rofi -show drun";
        "${modifier}+Alt" = "exec rofi -show window";
        "${modifier}+Esc" = "exec i3lock-fancy";
        "${modifier}+q" = "kill";
        "${modifier}+Shift+x" = "exec systemctl suspend";
        "${modifier}+r" = "mode resize";
      };

      startup = [
        {
          command = "exec i3-msg workspace 1";
          always = true;
          notification = false;
        }
        {
          command = "polybar top &";
          always = true;
          notification = false;
        }
        {
          command = "${pkgs.feh}/bin/feh --bg-fill ~/background.png";
          always = true;
          notification = false;
        }
	      {
	        command = "picom --experimental-backends --backend glx";
	        always = true;
	        notification = false;
	      }
        {
          command = "nm-applet";
          always = true;
          notification = false;
        }
        {
          command = "exec --no-startup-id unity-settings-daemon";
          always = true;
          notification = false;
        }
      ];
    };
  };
}


