/*
	Author: IT07

	Description:
	launches VEMFr (You don't say?)
*/

if isNil "VEMFrHasStarted" then
	{
		VEMFrHasStarted = call compileFinal "true";
		["Launcher", 2, format["/// STARTING VEMFr v%1 \\\", getText (configFile >> "CfgPatches" >> "exile_vemf_reloaded" >> "version")]] ExecVM "exile_vemf_reloaded\sqf\log.sqf";
		uiNamespace setVariable ["VEMFrUsedLocs", []];
		uiNamespace setVariable ["VEMFrAttackedFlags", []];
		uiNamespace setVariable ["VEMFrHcLoad", [[],[]]];

		[] spawn
			{
				if (("overridesToRPT" call VEMFr_fnc_config) isEqualTo 1) then
					{
						_r = configProperties [configFile >> "CfgVemfReloadedOverrides", "true", false];
						{
							if (isClass _x) then
								{
									_c1 = configName _x;
									_l1 = configProperties [configFile >> "CfgVemfReloadedOverrides" >> _c1, "true", false];
									{
										if (isClass _x) then
											{
												_c2 = configName _x;
												_l2 = configProperties [configFile >> "CfgVemfReloadedOverrides" >> _c1 >> _c2, "true", false];
												{
													if not(isClass _x) then
														{
															["overridesToRPT", 1, format["Overriding 'CfgVemfReloaded >> %1 >> %2 >> %3'", _c1, _c2, configName _x]] ExecVM "exile_vemf_reloaded\sqf\log.sqf";
														};
												} forEach _l2;
											} else
											{
												["overridesToRPT", 1, format["Overriding 'CfgVemfReloaded >> %1 >> %2", _c1, configName _x]] ExecVM "exile_vemf_reloaded\sqf\log.sqf";
											};
									} forEach _l1;
								} else
								{
									["overridesToRPT", 1, format["Overriding 'CfgVemfReloaded >> %1'", configName _x]] ExecVM "exile_vemf_reloaded\sqf\log.sqf";
								};
						} forEach _r;
					};

				_s = ["checkLoot","missionTimer","REMOTEguard","spawnStaticAI"];
				{
					ExecVM format["exile_vemf_reloaded\sqf\%1.sqf", _x];
				} forEach _s;

				west setFriend [independent, 0];
				independent setFriend [west, 0];
			};
	} else
	{
		["Launcher", 0, format["exile_vemf_reloaded FAILED to launch! VEMFrHasStarted (%1) is already defined!", VEMFrHasStarted]] ExecVM "exile_vemf_reloaded\sqf\log.sqf";
	};
