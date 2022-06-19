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
    nitrogen
    gnomeExtensions.pop-shell
    gnomeExtensions.dash-to-dock
    gnome.dconf-editor
    gnomeExtensions.pop-launcher-super-key


    #Terminal Programs
    alacritty
    zenith-nvidia
    traceroute
    neofetch
    lolcat
    feh

    #Games
    minecraft
    steam
	];
}
