/*
    Author: IT07

    Description:
    Adds magazines to given unit's vest/backpack if it flairTypes

    Params:
    _this: ARRAY
    _this select 0: OBJECT - unit to give ammo to

    Returns:
    BOOLEAN - true if successful
*/

private ["_done"];
_done = false;
if (_this isEqualType []) then
   {
      private ["_unit"];
      _unit = param [0, objNull, [objNull]];
      if not isNull _unit then
         {
            if local _unit then
               {
                  if not(primaryWeapon _unit isEqualTo "") then
                     {
                        private ["_weapon","_mag","_magMass","_vestMass","_itemMass"];
                        _weapon = primaryWeapon _unit;
                        _mag = selectRandom (getArray (configFile >> "CfgWeapons" >> _weapon >> "magazines"));
                        for "_m" from 1 to 5 do
                           {
                              if not(_unit canAdd _mag) exitWith {};
                              _unit addItem _mag;
                           };
                     };
                  if not (secondaryWeapon _unit isEqualTo "") then
                     {
                        if not(backPack _unit isEqualTo "") then
                           {
                              private ["_weapon","_mag","_magMass"];
                              _weapon = secondaryWeapon _unit;
                              _mag = selectRandom (getArray (configFile >> "CfgWeapons" >> _weapon >> "magazines"));
                              for "_m" from 1 to 3 do
                                 {
                                    if not(_unit canAdd _mag) exitWith {};
                                    _unit addItem _mag;
                                 };
                           };
                     };
                  if not (handGunWeapon _unit isEqualTo "") then
                     {
                        private ["_weapon","_mag","_magMass","_uniformMass"];
                        _weapon = handGunWeapon _unit;
                        _mag = selectRandom (getArray (configFile >> "CfgWeapons" >> _weapon >> "magazines"));
                        for "_m" from 1 to 4 do
                           {
                              if not(_unit canAdd _mag) exitWith {};
                              _unit addItem _mag;
                           };
                     };
                  _done = true;
               } else // If unit is not local
               {
                  ["fn_giveAmmo", 0, format["%1 is not local. Can not execute!", _unit]] ExecVM "exile_vemf_reloaded\sqf\log.sqf";
               };
         } else // If unit isNull
         {
            ["fn_giveAmmo", 0, "_unit isNull. Can not execute!"] ExecVM "exile_vemf_reloaded\sqf\log.sqf";
         };
   } else
   {
      ["fn_giveAmmo", 0, "_this is not an ARRAY"] ExecVM "exile_vemf_reloaded\sqf\log.sqf";
   };
_done
