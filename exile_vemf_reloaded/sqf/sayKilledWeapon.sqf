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


_crWpn = "Weapon";
if (vehicle _k isEqualTo _k) then { _crWpn = currentWeapon _k };
if not(vehicle _k isEqualTo _k) then { _crWpn = currentWeapon (vehicle _k) };
_dist = _t distance _k;

_sk = "sayKilled" call VEMFr_fnc_config;
if (_sk isEqualTo 1) then { [format["(VEMFr) %1 [%2, %3m] %4", _nk, getText(configFile >> "CfgWeapons" >> _crWpn >> "displayName"), round _dist, if (("sayKilledName" call VEMFr_fnc_config) > 0) then {_nt} else {"AI"}]] ExecVM "exile_vemf_reloaded\sqf\systemChatToClient.sqf" };
if (_sk isEqualTo 2) then { [format["(VEMFr) You [%1, %2m] %4", getText(configFile >> "CfgWeapons" >> _crWpn >> "displayName"), round _dist, if (("sayKilledName" call VEMFr_fnc_config) > 0) then {_nt} else {"AI"}]] ExecVM "exile_vemf_reloaded\sqf\systemChatToClient.sqf" };
