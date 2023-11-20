{ config, lib, pkgs, vars, ... }:

{
	config = {
		services = {
			tlp = {
				enable = false;
				settings = {
					CPU_SCALING_GOVERNOR_ON_AC = "performance";
        				CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

        				CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
        				CPU_ENERGY_PERF_POLICY_ON_AC = "performance";

        				CPU_MIN_PERF_ON_AC = 0;
        				CPU_MAX_PERF_ON_AC = 100;
        				CPU_MIN_PERF_ON_BAT = 0;
        				CPU_MAX_PERF_ON_BAT = 20;
					};
				};
			auto-cpufreq = {
				enable = true;
				settings = {
					battery = {
						governor = "powersave";
						turbo = "never";
						};
					charger = {
						governor = "performance";
						turbo = "auto";
						};
					};
				};
			};

		home-manager.users.${vars.user} = {
      			services = {
        			cbatticon = {
          				enable = true;
          				criticalLevelPercent = 10;
          				commandCriticalLevel = ''notify-send "battery critical!"'';
          				lowLevelPercent = 30;
          				iconType = "standard";
					};
				};
			};
		};
	}
