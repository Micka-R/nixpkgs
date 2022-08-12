# put this file in /etc/nixos/
# change the settings tagged with "CHANGE:"
# and add 
#   ./pci-passthrough.nix
# to /etc/nixos/configuration.nix in `imports`

{config, pkgs, ... }:
{  
  # CHANGE: intel_iommu enables iommu for intel CPUs with VT-d
  # use amd_iommu if you have an AMD CPU with AMD-Vi
  boot.kernelParams = [ "intel_iommu=on" "iommu=pt" ];
    
  # These modules are required for PCI passthrough, and must come before early modesetting stuff
  boot.kernelModules = [ "kvm-intel" "vfio_pci"];
  
  # CHANGE: Don't forget to put your own PCI IDs here
#  boot.extraModprobeConfig ="options vfio-pci ids=10de:1f11,10de:10f9";
  
  environment.systemPackages = with pkgs; [
    virtmanager
    qemu
    OVMF
  ];
  
  virtualisation.libvirtd = {
    enable = true;
    onBoot = "ignore";
    onShutdown = "shutdown";
    qemu = {
	ovmf.enable = true;
        runAsRoot = true;
  };
};

 # Add binaries to path so that hooks can use it
  systemd.services.libvirtd = {
    path = let
             env = pkgs.buildEnv {
               name = "qemu-hook-env";
               paths = with pkgs; [
                 bash
                 libvirt
                 kmod
                 systemd
                 ripgrep
                 sd
               ];
             };
           in
           [ env ];
    preStart =
    ''
      chmod +x /var/lib/libvirt/hooks/qemu
      chmod +x /var/lib/libvirt/hooks/kvm.conf
      chmod +x /var/lib/libvirt/hooks/qemu.d/win10/prepare/begin/start.sh
      chmod +x /var/lib/libvirt/hooks/qemu.d/win10/release/end/stop.sh
    '';
  };

  
  # CHANGE: add your own user here
  users.groups.libvirtd.members = [ "root" "pkngr"];
  
  # CHANGE: use 
  #     ls /nix/store/*OVMF*/FV/OVMF{,_VARS}.fd | tail -n2 | tr '\n' : | sed -e 's/:$//'
  # to find your nix store paths
  virtualisation.libvirtd.qemu.verbatimConfig = ''
    nvram = [
      "/nix/store/k42akcjj7yk8srkpilf3ddrykh7clbr9-OVMF-202202-fd/FV/OVMF.fd:/nix/store/k42akcjj7yk8srkpilf3ddrykh7clbr9-OVMF-202202-fd/FV/OVMF_VARS.fd"
    ]
  '';

}
