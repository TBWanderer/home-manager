{ pkgs, ... }:
{
	home.packages = [pkgs.mpv pkgs.alacritty pkgs.vesktop pkgs.clang-tools pkgs.nixd pkgs.lazygit];
	programs.wpaperd.enable = true;
	programs.alacritty.enable = true;
	programs.fish.enable = true;
	programs.fish.interactiveShellInit = ''
		set fish_greeting
		export PATH="/home/x/.local/bin:$PATH"
		export PATH="/home/x/.nix-profile/bin:$PATH"
	'';
	programs.fish.loginShellInit = ''
		export PATH="/home/x/.local/bin:$PATH"
		export PATH="/home/x/.nix-profile/bin:$PATH"
		nixGL Hyprland
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
		update = "echo '[.] Updating time' && sudo ntpd -qg && echo '[!] End of time updating' && home-manager switch --flake /home/x/.config/home-manager/";
		light = "brightnessctl s";
	};
	programs.starship.enable = true;
	programs.waybar  = {
		enable = true;
		style = ''
			* {
				border-radius: 10px;
				padding-right: 5px;
				padding-left: 5px;
				color: #cad3f5;
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

    			modules-center  = ["bluetooth" "custom/cava" "network"];
    			modules-left  = ["hyprland/workspaces" "hyprland/window"];
    			modules-right  = ["tray" "cpu" "memory" "custom/brightness" "custom/pipewire" "custom/battery" "hyprland/language" "clock"];
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
        			spacing = 5;
        			icon-size = 15;

    			};

				
				"cpu" = {
        			interval = 1;
        			format = " {usage}%";
        			states = {
            			"warning" = 70;
            			"critical" = 90;
        			};
    			};

    			"memory" = {
    	    	"interval" = 5;
				"format" = " {}%";
        		"states" = {
            		"warning" = 70;
            		"critical" = 90;
        			};
    			};

				"network" = {
					"interface" = ["wlan0" "enp4s0"];
    				"format-wifi" = " ";
    				"format-ethernet" = " ";
    				"format-disconnected" = " ";
    				"tooltip-format-wifi" = "{essid} ({signalStrength}%)  ";
    				"tooltip-format-ethernet" = "{ifname}  ";
    				"tooltip-format-disconnected" = "Disconnected";
				};
				
				"bluetooth" = {
					"format" = "󰀃 ";
					"format-connected" = "󱔸 ";
					"format-connected-battery" = "󱔸 ";
					# "format-device-preference" = [ "device1", "device2" ], // preference list deciding the displayed device
					
					"tooltip-format" = "{controller_alias}\t{controller_address}\n\n{num_connections} connected";
					"tooltip-format-connected" = "{controller_alias}\t{controller_address}\n\n{num_connections} connected\n\n{device_enumerate}";
					"tooltip-format-enumerate-connected" = "{device_alias}\t{device_address}";
					"tooltip-format-enumerate-connected-battery" = "{device_alias}\t{device_address}\t{device_battery_percentage}%";
					
					"on-click" = "blueman-manager";
				};

				"clock" = {
        			"format" = "{:%H:%M:%S}";
        			"format-alt" = "{:%d.%m.%y}";
					"interval" = 1;
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

				"custom/alsa" = { # Old version
    				format = "{}";
					exec = "sleep 0.05 && echo $(pamixer --get-mute)$(pamixer --get-volume) | sed 's/true/ /' | sed 's/false/ /'";
					on-click = "pamixer -t; pkill -x -RTMIN+11 waybar; ";
					on-scroll-up = "pamixer -i2; pkill -x -RTMIN+11 waybar";
					on-scroll-down = "pamixer -d2; pkill -x -RTMIN+11 waybar";
					signal = 11;
					interval = 1;
					tooltip = true;
    			};
				
				
        		
        		"custom/pipewire" = let pamixer = "${pkgs.pamixer}/bin/pamixer"; in {
            		format = "{}";
          			exec = "sleep 0.05 && echo $(${pamixer} --get-mute)$(${pamixer} --get-volume) | sed 's/true/󰸈 /' | sed 's/false/󰕾 /'";
          			on-click = "${pamixer} -t; pkill -x -RTMIN+11 waybar";
        			on-scroll-up = "${pamixer} -i2; pkill -x -RTMIN+11 waybar";
          			on-scroll-down = "${pamixer} -d2; pkill -x -RTMIN+11 waybar";
          			signal = 11;
          			interval = 5;
          			tooltip = false;
          		};

				"custom/battery" = {
					exec = "${../scripts/battery_module.sh}";
					interval = 2;
					format = {};
				};
				
				"custom/brightness" = {
					exec = "${../scripts/brightness_module} get";
					interval = 5;
					on-scroll-up = "${../scripts/brightness_module} raise > /dev/null && ${../scripts/brightness_module} get";
					on-scroll-down = "${../scripts/brightness_module} lower > /dev/null && ${../scripts/brightness_module} get";
				};

				"custom/cava" = {
					format = "{}";
					return-type = "text";
					max-length = 60;
					escape = true;
					tooltip = false;
					exec = "${import ./cava.nix { inherit pkgs; }}/bin/cava_waybar";
				};
			};
		};
	};
}
