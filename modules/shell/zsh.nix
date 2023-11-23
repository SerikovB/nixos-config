# zsh
{ pkgs, vars, ... }:

{
	users.users.${vars.user} = {
		shell = pkgs.zsh;
		};

	programs.zsh = {
		enable = true;
		autosuggestions.enable = true;
		syntaxHighlighting.enable = true;
		enableCompletion = true;
		histFile = "$HOME/.config/zsh/history";
	};

}
