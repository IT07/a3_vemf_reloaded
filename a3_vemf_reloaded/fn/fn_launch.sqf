/*
	Author: IT07

	Description:
	launches VEMFr (You don't say?)
*/

if (isNil "VEMFrHasStarted") then
	{
		VEMFrHasStarted = call compileFinal "true";
		[("Launcher"),(2),(format["/// booting VEMFr v%1 (%2) \\\", getText (configFile >> "CfgPatches" >> "a3_vemf_reloaded" >> "version"), call VEMFr_fnc_whichMod])] ExecVM ("log" call VEMFr_fnc_scriptPath);
		uiNamespace setVariable ["VEMFrUsedLocs", []];
		uiNamespace setVariable ["VEMFrHcLoad", [[],[]]];

		if (("overridesToRPT" call VEMFr_fnc_config) isEqualTo "yes") then { [] ExecVM ("overrides" call VEMFr_fnc_scriptPath) };

		{
			_h = [] ExecVM format["a3_vemf_reloaded\sqf\%1.sqf", _x];
			if ((_x isEqualTo "checkClasses") OR (_x isEqualTo "spawnStaticAI")) then { waitUntil { if (scriptDone _h) then {true} else {uiSleep 0.1; false} } };
		} forEach [("checkClasses"),("missionTimer"),("REMOTEguard"),("spawnStaticAI")];

		if ((call VEMFr_fnc_whichMod) isEqualTo "Epoch") then { west setFriend [independent, 0]; independent setFriend [west, 0] };
	} else { [("Launcher"),(0),(format["a3_vemf_reloaded FAILED to launch! VEMFrHasStarted (%1) is already defined!", VEMFrHasStarted])] ExecVM ("log" call VEMFr_fnc_scriptPath) };
