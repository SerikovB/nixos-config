{ pkgs, ... }:  

{
	imports = [
		./hardware-configuration.nix
		];

	boot = {
		loader = {
			grub = {
				enable = true;
				devices = [ "nodev" ];
				efiSupport = true;
				configurationLimit = 5;
				};
			efi = {
				canTouchEfiVariables = true;
				efiSysMountPoint = "/boot/efi";
				};
			timeout = 1;
			};
		kernelPackages = pkgs.linuxPackages;
		initrd.kernelModules = [ "amdgpu" ];
		};
	
	# Hardware accelation
	hardware = {
		opengl = {
			enable = true;
			extraPackages = with pkgs; [
				rocm-opencl-icd
				rocm-opencl-runtime
				amdvlk
				];
			extraPackages32 = with pkgs; [
				driversi686Linux.amdvlk
				];
			driSupport = true;
			driSupport32Bit = true;
			};
		sane = {
			enable = true;
			extraBackends = [ pkgs.sane-airscan ];
			};
		};
	
	# Laptop modules
	# laptop.enable = true;
	programs.light.enable = true;
	
	# Hyprland
	# hyprland.enable = true;
	services.xserver.enable = true;
	services.xserver.displayManager.sddm.enable = true;
	services.xserver.desktopManager.plasma5.enable = true;
	services.xserver.displayManager.defaultSession = "plasmawayland";

	# Environment
	environment = {
		systemPackages = with pkgs; [

			];
		};
}
