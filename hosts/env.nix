# Environment
{ pkgs, unstable, vars, ...}:

{
	environment.localBinInPath = true;
	environment.variables = {
		EDITOR = "${vars.editor}";
		TERMINAL = "${vars.terminal}";
		VISUAL = "${vars.editor}";
		ZDOTDIR = "${vars.zdotdir}";

		XDG_CACHE_HOME = "$HOME/.cache";
		XDG_CONFIG_HOME = "$HOME/.config";
		XDG_DATA_HOME = "$HOME/.local/share";
		XDG_BIN_HOME = "$HOME/.local/bin";
		XDG_STATE_HOME = "$HOME/.local/state";

		GTK_RC_FILES="$XDG_CONFIG_HOME/gtk-1.0/gtkrc";
		GTK2_RC_FILES="$XDG_CONFIG_HOME/gtk-2.0/gtkrc";

		};
	environment.systemPackages = with pkgs; [
		# Terminal
		btop
		nvtop
		coreutils
		git
		killall
		nix-tree
		pciutils
		usbutils
		wget
		curl

		# Devtools
		nodejs
		python3


		# Editors
		neovim

		# Audio/Video
		alsa-utils
		feh
		pavucontrol
		pipewire

		# Apps
		lutris
		kitty

		] ++ 
		# From unstable
		(with unstable; [
			librewolf
			]);
}
