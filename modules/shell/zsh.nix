# zsh
{ pkgs, vars, ... }:

{
	users.user.${vars.user} = {
		shell = pkgs.zsh;
		};

	programs.zsh = {
		enable = true;
		autosuggestion.enable = true;
		syntaxHighlighting.enable = true;
		enableCompletion = true;
		histFile = "${HOME}/.config/zsh/history"
	};

	programs.zsh.shlellInit = { ''
		''};
}
