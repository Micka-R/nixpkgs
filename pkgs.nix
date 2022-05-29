{ pkgs, ... }: {
	home.packages = with pkgs; [
    
    # Languages
  	lua
    python38
    dotnet-sdk_5
    
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

    #Terminal Programs
    alacritty
    zenith-nvidia
    traceroute
    neofetch
    lolcat
    feh

    #Games
    minecraft
	];
}
