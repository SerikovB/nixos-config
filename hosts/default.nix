{ lib, inputs, nixpkgs, nixpkgs-unstable, home-manager, nur, hyprland, vars, ...}: 

let
	system = "x86_64-linux";

  	pkgs = import nixpkgs {
    		inherit system;
    		config.allowUnfree = true;
  		};

	unstable = import nixpkgs-unstable {
		inherit system;
		config.allowUnfree = true;
		};

in
{
	laptop = lib.nixosSystem {
		inherit system;
		specialArgs = {
			inherit inputs unstable vars;
			host = {
				hostName = "nixos-laptop";
				mainMonitor = "eDP-1";
				secondMonitor = "";
				};
			};
		modules = [
			./laptop
			./configuration.nix

			home-manager.nixosModules.home-manager {
				home-manager.useGlobalPkgs = true;
				home-manager.useUserPackages = true;
				}
			];
		};
	}
