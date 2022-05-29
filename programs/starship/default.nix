{ config, pkgs, libs, ... }:
{
  home.packages = with pkgs; [
    starship
  ];
  programs.starship = {
    enable = true;
# Configuration written to ~/.config/starship.toml
    settings = {
      add_newline = false;

      character = {
        success_symbol = "[❯](bold green)";
        error_symbol = "[✗ ❯](bold red)";
      };

      line_break = {
        disabled = true;
      };

      directory = {
        format = "[$path]($style)[$read_only]($read_only_style) ";
# style = "bold  #50fa7b";
        read_only = "🔒";
        read_only_style = "red";
        home_symbol = "🏠";
      };

# package.disabled = true;
    };
  };
}

