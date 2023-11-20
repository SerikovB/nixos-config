{
  description = "Flake config file";

  inputs = {
	# Defaults to stable
	nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";
	nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

	# Home-manager
	home-manager = {
		url = "github:nix-community/home-manager/release-23.05";
		inputs.nixpkgs.follows = "nixpkgs";
		};

	# Nix user repository
	nur = {
		url = "github:nix-community/NUR";	
		};

	# Hyprland nix
	hyprland = {
		url = "github:hyprwm/Hyprland";
		inputs.nixpkgs.follows = "nixpkgs-unstable";
		};
  };

  outputs = inputs @ { self, nixpkgs, nixpkgs-unstable, nur, home-manager, hyprland, ...} :
  	let
		vars = {
			user = "sbk";
			location = "$HOME/.config/flake";
			editor = "nvim";
			terminal = "kitty";
			zdotdir = "$HOME/zsh";
			};
	in {
		nixosConfigurations = (
			import ./hosts {
				inherit (nixpkgs) lib;
				inherit inputs nixpkgs nixpkgs-unstable home-manager nur hyprland vars;
				}	
			);
		};
	}
