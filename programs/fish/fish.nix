{ pkgs, ... }:
{
  programs.fish = {
    enable = true;

    shellAliases = {
      ll = "ls -a -l";
      la = "ls -a";
      ".." = "cd ..";
      c = "clear";
      vim = "nvim";
      gen = "sudo nixos-rebuild switch";
      pkgs = "nvim /home/pkngr/.config/nixpkgs/pkgs.nix";
      hs = "home-manager switch";
      gs = "cd /home/pkngr/Documents/epita/";
    };

    plugins = [
      {
        name = "theme-lambda";
        src = pkgs.fetchFromGitHub {
          owner = "hasanozgan";
          repo = "theme-lambda";
          rev = "9cf5825c31a1d09d37d87e681ac2fa1d771ef6d2";
          sha256 = "1aq8r27n4ifickg7my039k618d7dllknyi4g7x742hcy19zr1336";
        };
      }
      {
        name = "fish-ssh-agent";
        src = pkgs.fetchFromGitHub {
          owner = "danhper";
          repo = "fish-ssh-agent";
          rev = "fd70a2afdd03caf9bf609746bf6b993b9e83be57";
          sha256 = "1fvl23y9lylj4nz6k7yfja6v9jlsg8jffs2m5mq0ql4ja5vi5pkv";
        };
      }
    ];

    functions = { "fish_greeting" = builtins.readFile ./fish_greeting.fish; };
  };
}
