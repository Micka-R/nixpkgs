{ config, pkgs, ... }:
let
  nixpkgs-tars = "https://github.com/NixOS/nixpkgs/archive/";
in {
  nixpkgs.config = {
    packageOverrides = pkgs: {
      pr176303 = import (fetchTarball 
        "${nixpkgs-tars}4c7afbe511d57bae821315819365d01dea0dd344.tar.gz") 
          { config = config.nixpkgs.config; };
    };
  };
	home.packages = with pkgs; [

  pr176303.pop-launcher
  ];
}
