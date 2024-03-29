# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
	imports =
		[ # Include the results of the hardware scan.
		./hardware-configuration.nix
     		./pci-passthrough.nix
		];

# Use the systemd-boot EFI boot loader.
	boot.loader.systemd-boot.enable = true;
	boot.loader.efi.canTouchEfiVariables = true;

	networking.hostName = "Nixworth"; # Define your hostname.
# networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
	networking.networkmanager.enable = true;

# Set your time zone.
	time.timeZone = "Europe/Paris";

# The global useDHCP flag is deprecated, therefore explicitly set to false here.
# Per-interface useDHCP will be mandatory in the future, so this generated config
# replicates the default behaviour.
#	networking.useDHCP = false;
#	networking.interfaces.wlp1s0.useDHCP = false;

# Configure network proxy if necessary
# networking.proxy.default = "http://user:password@proxy:port/";
# networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

# Select internationalisation properties.
	i18n.defaultLocale = "en_US.UTF-8";
	console = {
		font = "Lat2-Terminus16";
		keyMap = "us";
	};

# Enable the X11 windowing system.
	services.xserver.enable = true;
# NVIDIA drivers.
	nixpkgs.config.allowUnfree = true;
	services.xserver.videoDrivers = [ "nvidia" ];
	hardware.opengl.enable = true;
	hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;

#Enable the GNOME Desktop Environement.
	services.xserver.desktopManager.gnome.enable = true;
	services.xserver.displayManager.gdm.enable = true;

#Enable the i3 WM:
	services.xserver.windowManager.i3.enable = true;
	services.xserver.windowManager.i3.package = pkgs.i3-gaps;

#Enable BSPWM WM:
	#services.xserver.windowManager.bspwm.enable = true;
	

# Configure keymap in X11
	services.xserver.layout = "us";
	services.xserver.xkbOptions = "eurosign:e";

# Enable CUPS to print documents.
	services.printing.enable = true;

# Enable sound.
	sound.enable = true;
	hardware.pulseaudio.enable = true;

# Enable touchpad support (enabled default in most desktopManager).
	services.xserver.libinput.enable = true;

# Define a user account. Don't forget to set a password with ‘passwd’.
	users.users.pkngr = {
		isNormalUser = true;
		createHome = true;
		shell = pkgs.fish;
		extraGroups = [ "wheel" "networkmanager" "qemu-libvirtd" ]; # Enable ‘sudo’ for the user.
	};
	nix.allowedUsers = [ "@wheel" ];

# List packages installed in system profile. To search, run:
# $ nix search wget
	environment.systemPackages = with pkgs; [
		vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
			wget
			curl
			git
			vim
			firefox
			python38
			fish
			unzip
			docker
			home-manager
	];
	fonts.fonts = with pkgs; [
		(nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" "JetBrainsMono"]; })
	];
programs.fish.enable = true;
services.tailscale.enable = true;
# Some programs need SUID wrappers, can be configured further or are
# started in user sessions.
# programs.mtr.enable = true;
# programs.gnupg.agent = {
#   enable = true;
#   enableSSHSupport = true;
# };

# List services that you want to enable:

# Enable the OpenSSH daemon.
 services.openssh.enable = true;

# Open ports in the firewall.
# networking.firewall.allowedTCPPorts = [ ... ];
# networking.firewall.allowedUDPPorts = [ ... ];
# Or disable the firewall altogether.
 networking.firewall.enable = false;

# This value determines the NixOS release from which the default
# settings for stateful data, like file locations and database versions
# on your system were taken. It‘s perfectly fine and recommended to leave
# this value at the release version of the first install of this system.
# Before changing this value read the documentation for this option
# (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
	system.stateVersion = "21.11"; # Did you read the comment?

}
