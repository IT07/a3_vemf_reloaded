/*
	Author: IT07

	Description:
	launches VEMFr (You don't say?)
*/

["Launcher", 2, format["/// STARTING v%1 \\\", getNumber (configFile >> "CfgPatches" >> "Exile_VEMF_Reloaded" >> "version")]] spawn VEMFr_fnc_log;
uiNamespace setVariable ["VEMFrUsedLocs", []];
uiNamespace setVariable ["VEMFrHcLoad", []];
[] spawn VEMFr_fnc_checkLoot; // Check loot tables if enabled
[] spawn VEMFr_fnc_missionTimer; // Launch mission timer
[] spawn VEMFr_fnc_spawnStaticAI; // Launch Static AI spawner
west setFriend [independent, 0];
independent setFriend [west, 0];
