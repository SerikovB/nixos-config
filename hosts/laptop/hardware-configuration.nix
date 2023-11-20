{ config, lib, pkgs, modulesPath, ... }:

{
	imports =
  		[ 
			(modulesPath + "/installer/scan/not-detected.nix")
  			];

	boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "usb_storage" "sd_mod" "sdhci_pci" ];
	boot.initrd.kernelModules = [ ];
	boot.kernelModules = [ "kvm-amd" ];
	boot.extraModulePackages = [ ];

	fileSystems."/" =
		{ 
			device = "/dev/disk/by-label/nixos";
		  	fsType = "ext4";
		};
	
	fileSystems."/media" =
		{ 
			device = "/dev/disk/by-label/nixos-media";
		  	fsType = "ext4";
		};
	
	fileSystems."/boot/efi" =
	  	{ 
			device = "/dev/disk/by-label/boot";
	    		fsType = "vfat";
	  	};
	
	swapDevices =
	  	[ 
			{ device = "/dev/disk/by-label/swap"; }
	  	];

	# Deprecated
	networking.useDHCP = lib.mkDefault true;
	# networking.interfaces.eno1.useDHCP = lib.mkDefault true;
	# networking.interfaces.wlo1.useDHCP = lib.mkDefault true;

	nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
	hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
