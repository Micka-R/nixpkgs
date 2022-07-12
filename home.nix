{ pkgs, ... }: {
	programs.neovim = {
	  enable = true;
	};
	imports = [
		./pkgs.nix
    ./epkgs.nix
		./config.nix
    ./programs/i3.nix
		./programs/nvim/default.nix
		./programs/starship/default.nix
    ./programs/polybar.nix
    ./programs/fish/fish.nix
    ./programs/alacritty.nix
    #./programs/rofi.nix
	];
	home.keyboard = {
		layout = "us";
		variant = "intl";
	}; 
}
