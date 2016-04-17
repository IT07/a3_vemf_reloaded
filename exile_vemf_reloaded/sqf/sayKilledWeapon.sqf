/*
   Author: IT07

   Description:
   handles the broadcast of a systemChat kill message
*/

_target = param [0, objNull, [objNull]];
_killer = param [1, objNull, [objNull]];
if not(isNull _target AND isNull _killer) then
{
   scopeName "outer";
   _dist = _target distance _killer;
   if (_dist > 1) then
   {
      private ["_curWeapon"];
      if (vehicle _killer isEqualTo _killer) then // If on foot
      {
         _curWeapon = currentWeapon _killer;
      };
      if not(vehicle _killer isEqualTo _killer) then // If in vehicle
      {
         _curWeapon = currentWeapon (vehicle _killer);
      };
      _sayKilled = param [2, 1, [1]];
      if (_sayKilled isEqualTo 1) then
      {
         _kMsg = format["(VEMFr) %1 [%2, %3m] AI", name _killer, getText(configFile >> "CfgWeapons" >> _curWeapon >> "displayName"), round _dist];
         [_kMsg, "sys"] spawn VEMFr_fnc_broadCast;
         breakOut "outer";
      };
      if (_sayKilled isEqualTo 2) then
      {
         VEMFrClientMsg = [format["(VEMFr) You [%1, %2m] AI", getText(configFile >> "CfgWeapons" >> _curWeapon >> "displayName"), round _dist], "sys"];
         (owner _killer) publicVariableClient "VEMFrClientMsg";
         VEMFrClientMsg = nil;
         breakOut "outer";
      };
   };
} else
{
   ["sayKilledWeapon.sqf", 0, "_killer isNull!"] spawn VEMFr_fnc_log;
};
