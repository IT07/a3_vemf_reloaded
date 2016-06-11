/*
   Author: IT07

   Description:
   handles the broadcast of a systemChat kill message
*/

_target = param [0, objNull, [objNull]];
_killer = param [1, objNull, [objNull]];
_curWeapon = "Weapon";
if (vehicle _killer isEqualTo _killer) then // If on foot
   {
      _curWeapon = currentWeapon _killer;
   };
if not(vehicle _killer isEqualTo _killer) then // If in vehicle
   {
      _curWeapon = currentWeapon (vehicle _killer);
   };

_dist = _target distance _killer;
_sayKilled = "sayKilled" call VEMFr_fnc_getSetting;
if (_sayKilled isEqualTo 1) then
   {
      [format["(VEMFr) %1 [%2, %3m] AI", name _killer, getText(configFile >> "CfgWeapons" >> _curWeapon >> "displayName"), round _dist]] ExecVM "exile_vemf_reloaded\sqf\systemChatToClient.sqf";
   };
if (_sayKilled isEqualTo 2) then
   {
      [format["(VEMFr) You [%1, %2m] AI", getText(configFile >> "CfgWeapons" >> _curWeapon >> "displayName"), round _dist]] ExecVM "exile_vemf_reloaded\sqf\systemChatToClient.sqf";
   };
