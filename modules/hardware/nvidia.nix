{ config, pkgs, unstable, ... }:  

let
	nvidia-offload = pkgs.writeShellScriptBin "nvidia-offload" ''
		export __NV_PRIME_RENDER_OFFLOAD=1
		export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
		export __GLX_VENDOR_LIBRARY_NAME=nvidia
		export __VK_LAYER_NV_optimus=NVIDIA_only
		exec "$@"
		'';
in
{
	environment.systemPackages = [ nvidia-offload ];

	# Xserver drivers
	services.xserver.videoDrivers = [ "nvidia" ];

	# Nvidia settings
	hardware.nvidia = {
		modesetting.enable = true;
		# Experimental
		powerManagement.finegrained = true;
		
		# Nvidia open source drivers
		open = false;
		nvidiaSettings = true;

		# Which driver version to use
		package = config.boot.kernelPackages.nvidiaPackages.stable;

		prime = {
			offload = {
				enable = true;
				enableOffloadCmd = true;
				};
			sync = {
				enable = false;
				};
			amdgpuBusId = "PCI:7:0:0";
			nvidiaBusId = "PCI:1:0:0";
			};
		};
}
