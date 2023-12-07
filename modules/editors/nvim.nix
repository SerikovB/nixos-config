# Nvim
{ lib, pkgs, ... }:

{
	programs.nixvim = {
		enable = true;
		viAlias = true;
		vimAlias = true;
		defaultEditor = true;

		autoCmd = [
			{
				event = "VimEnter";
				command = "set nofoldenable";
				desc = "Unfold all";
			}
			{
				event = "BufWrite";
				command = "%s/\\s\\+$//e";
				desc = "Remove whitspaces";
			}
			{
				even = "FileType";
				pattern = [
					"markdown"
					"org"
					"norg"
					];
				command = "setlocal conceallevel=2";
				desc = "Conceal Syntax Attribute";
			}
			{
      				event = "FileType";
      				pattern = [ "markdown" "org" "norg" ];
      				command = "setlocal spell spelllang=en,nl";
      				desc = "Spell Checking";
      			}
      			{
      				event = "FileType";
      				pattern = [ "markdown" "org" "norg" ];
      				command = ":TableModeEnable";
      				desc = "Table Mode";
      			}
		];

		options = {
      			number = true;
      			relativenumber = true;
      			hidden = true;
      			foldlevel = 99;
      			shiftwidth = 8;
      			tabstop = 8;
      			softtabstop = 8;
      			expandtab = true;
      			autoindent = true;
      			wrap = false;
      			completeopt = ["menu" "menuone" "noselect"];
      			pumheight = 15;
      			fileencoding = "utf-8";
      			swapfile = false;
      			timeoutlen = 2500;
      			conceallevel = 3;
    		};

	};
}
