/*
   Author: IT07

   Description:
   handles the broadcast of a systemChat kill message
*/

(_this select 0) params [
	["_t", objNull, [objNull]],
	["_nt", "", [""]]
];
(_this select 1) params [
	["_k", objNull, [objNull]],
	["_nk", "", [""]]
];


private ["_crWpn","_cfg"];
if (vehicle _k isEqualTo _k) then { _crWpn = currentWeapon _k; _cfg = "CfgWeapons" }
else { _crWpn = typeOf (vehicle _k); _cfg = "CfgVehicles" };
_dist = _t distance _k;

_sk = "sayKilled" call VEMFr_fnc_config;
if (_sk < 2) then { [format["(VEMFr) %1 [%2] %3 (%4m)", _nk, getText(configFile >> _cfg >> _crWpn >> "displayName"), if (("sayKilledName" call VEMFr_fnc_config) > 0) then {_nt} else {"AI"}, round _dist]] ExecVM "exile_vemf_reloaded\sqf\systemChatToClient.sqf" }
else { [format["(VEMFr) You [%1] %2 (%3m)", getText(configFile >> _cfg >> _crWpn >> "displayName"), if (("sayKilledName" call VEMFr_fnc_config) > 0) then {_nt} else {"AI"}, round _dist]] ExecVM "exile_vemf_reloaded\sqf\systemChatToClient.sqf" };
