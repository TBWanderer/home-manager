{ pkgs, ... }:
{
	home.packages = [pkgs.alacritty pkgs.vesktop pkgs.clang-tools pkgs.nixd pkgs.lazygit];
	programs.wpaperd.enable = true;
	programs.alacritty.enable = true;
	programs.fish.enable = true;
	programs.fish.interactiveShellInit = ''
		set fish_greeting
	'';
	programs.fish.shellAliases = {
		q = "exit";
		l = "ls -a -F";
		ls = "eza --icons";
		lg = "lazygit";
		cls = "clear";
		c = "clear";
		o = "nvim";
		vim = "nvim";
		rebuild = "home-manager switch --flake /home/x/.config/home-manager/";
		light = "brightnessctl s";
	};
	programs.starship.enable = true;
	programs.waybar  = {
		enable = true;
		style = ''
			* {
				border-radius: 10px;
				padding-right: 5px;
			}
		'';
		settings = {
			bar = {
    			position = "top";
    			height = 45;
    			width = 1900;
    			spacing = 15;
				margin-top = 5;
				margin-bottom = 5;

    			modules-center  = ["hyprland/window"];
    			modules-left  = ["hyprland/workspaces"];
    			modules-right  = ["tray" "custom/alsa" "custom/battery" "hyprland/language" "clock"];

				"hyprland/workspaces" = {
					format = "{icon}";
					on-scroll-up = "hyprctl dispatch workspace e+1";
					on-scroll-down = "hyprctl dispatch workspace e-1";
					on-click = "activate";
					all-outputs = false;
					format-icons = {
        				"1" = "1";
						"2" = "2";
						"3" = "3";
						"4" = "4";
						"5" = "5";
						"6" = "6";
						"7" = "7";
						"8" = "8";
						"9" = "9";
						"10" = "0";
						urgent = "!";
    				};
				};

				"tray" = {
        			spacing = 10;
        			icon-size = 20;
    			};

				"clock" = {
        			"format" = "{:%H:%M}";
        			"format-alt" = "{:%Y-%m-%d}";
    			};

				"hyprland/window" = {
    				format = "{}";

    				separate-outputs = false;
    				max-length = 20;
				};

				"hyprland/language" = {
    				format = "{}";
    				format-us = "US";
    				format-ru = "RU";
				};

				"custom/alsa" = {
    				format = "{}";
					exec = "echo $(pamixer --get-mute)$(pamixer --get-volume) | sed 's/true/ /' | sed 's/false/) /'";
					on-click = "pamixer -t; pkill -x -RTMIN+11 waybar";
					on-scroll-up = "pamixer -i2; pkill -x -RTMIN+11 waybar";
					on-scroll-down = "pamixer -d2; pkill -x -RTMIN+11 waybar";
					signal = 11;
					interval = 10;
					tooltip = true;
    			};

				"custom/battery" = {
					exec = "${../battery_module.sh}";
					interval = 5;
					format = {};
				};
			};
		};
	};
}
