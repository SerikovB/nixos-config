# General hosts config file
{ config, lib, pkgs, unstable, inputs, vars, ... }:

{
	imports = ( 
		import ../modules/desktops ++
		import ../modules/editors ++
		import ../modules/hardware ++
		import ../modules/programs ++
		import ../modules/services ++
		import ../modules/shell ++
		import ../modules/theming ++
		import ../modules/virt
		) ++ [
			./env.nix
		];

	# Enable zsh
	programs.zsh.enable = true;
	
	# Users
	users.users.${vars.user} =  {
		isNormalUser = true;
		extraGroups = [
			"wheel"
			"video"
			"audio"
			"camera"
			"networkmanager"
			"lp"
			"scanner"
			];
		};
	
	# Timezone and locales
	time.timeZone = "Asia/Almaty";
	i18n = {
		defaultLocale = "en_US.UTF-8";
		supportedLocales = [
			"C.UTF-8/UTF-8"
			"en_US.UTF-8/UTF-8"
			];
		extraLocaleSettings = {
			LC_COLLATE = "C.UTF-8";
			};
		};
	
	# Networking
	networking.networkmanager.enable = true;

	# Console settings
	console = {
		font = "Lat2-Terminus16";
		keyMap = "us";
		};

	# Security
	security = {
		rtkit.enable = true;
		polkit.enable = true;
		};
	
	# Fonts
	fonts.fonts = with pkgs; [
		carlito
		vegur
		source-code-pro
		jetbrains-mono
		font-awesome
		corefonts
		( nerdfonts.override {
			fonts = [
				"FiraCode"
				];
			})
		];

	# System settings uncomment for autoupdates (conflicts with flake)
	system = {
		# autoUpgrade = {
		# 	enable = true;
		# 	channel = "https://nixos.org/channels/nixos-unstable";
		# 	};
		stateVersion = "23.05"; 
		};

	# Dconf
	programs = {
		dconf.enable = true;
		};

	# Services
	services = {
		printing = {
			enable = true;
			};
		pipewire = {
			enable = true;
			alsa = {
				enable = true;
				support32Bit = true;
			};
			pulse.enable = true;
			jack.enable = true;
			};
		openssh = {
			enable = true;
			allowSFTP = true;
			extraConfig = ''
				HostKeyAlgorithms +ssh-rsa
				'';
			};
		};

	# Nix config
	nix = {
		settings = {
			auto-optimise-store = true;
			use-xdg-base-directories = true;
			};
		gc = {
			automatic = true;
			dates = "weekly";
			options = "--delete-older-than 2d";
			};
		package = pkgs.nixVersions.unstable;
		registry.nixpkgs.flake = inputs.nixpkgs;
    		extraOptions = ''
      			experimental-features = nix-command flakes
      			keep-outputs          = true
      			keep-derivations      = true
    			'';
		};
	nixpkgs.config.allowUnfree = true;

	# Home-manager
	home-manager.users.${vars.user} = {
		home = {
			stateVersion = "22.05";
			};

		programs = {
			home-manager.enable = true;
			};
  		};
}
