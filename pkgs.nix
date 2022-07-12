{ pkgs, ... }: {
	home.packages = with pkgs; [
    
    #Languages
  	lua
    python38
    dotnet-sdk_6

    #Desktopapps
    discord
    teams
		bitwarden
    libreoffice
    postman
    arandr
    ventoy-bin

    #IDE
		jetbrains.rider
    vscode

    #Extensions
    i3lock-fancy
    rofi
    picom
    networkmanagerapplet
    pavucontrol
    rofi
    gnomeExtensions.pop-shell
    gnomeExtensions.pop-launcher-super-key
    gnomeExtensions.dock-from-dash
    gnome.gnome-tweaks

    #Terminal Programs
    alacritty
    zenith-nvidia
    traceroute
    neofetch
    lolcat
    feh
    thefuck

    #Games
    polymc
	];
}
