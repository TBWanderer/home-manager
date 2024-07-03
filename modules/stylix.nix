{ pkgs, ... }:
{
	stylix = {
		enable = true;
		image = ../wallpaper.jpeg;
		opacity = {
			terminal = 0.8;
			desktop = 0.8;
		};
		fonts = rec {
			sizes = {
				terminal = 17;
			};
			serif = {
				package = (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; });
				name = "JetBrainsMono Nerd Font";
			};
			sansSerif = serif;
			monospace = serif;
			emoji = {
				package = pkgs.noto-fonts-emoji;
				name = "Noto Color Emoji";
			};
		};
		cursor = {
			name = "Vimix-Cursors";
			size = 24;
			package = pkgs.vimix-cursor-theme;
		};
		base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-macchiato.yaml";
		polarity = "dark";
	};
}
