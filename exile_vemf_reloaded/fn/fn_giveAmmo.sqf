/*
    Author: IT07

    Description:
    Adds magazines to given unit's vest/backpack if it flairTypes

    Params:
    _this: ARRAY
    _this select 0: OBJECT - unit to give ammo to
    _this select 1: STRING - primaryWeapon classname
    _this select 2: STRING - secondaryWeapon classname
    _this select 3: STRING - handGunWeapon classname

    Returns:
    BOOLEAN - true if successful
*/

private ["_done"];
_done = false;
if (_this isEqualType []) then
   {
      private ["_unit"];
      params [["_unit", objNull, [objNull]],["_classPrimary", "", [""]],["_classSecondary", "", [""]],["_classHandgun", "", [""]]];
      if not isNull _unit then
         {
            if local _unit then
               {
                  if not(_classPrimary isEqualTo "") then
                     {
                        private ["_mag"];
                        _mag = selectRandom (getArray (configFile >> "CfgWeapons" >> _classPrimary >> "magazines"));
                        for "_m" from 1 to 5 do
                           {
                              if not(_unit canAdd _mag) exitWith {};
                              _unit addItem _mag;
                           };
                     };
                  if not (_classSecondary isEqualTo "") then
                     {
                        if not(backPack _unit isEqualTo "") then
                           {
                              private ["_mag"];
                              _mag = selectRandom (getArray (configFile >> "CfgWeapons" >> _classSecondary >> "magazines"));
                              for "_m" from 1 to 3 do
                                 {
                                    if not(_unit canAdd _mag) exitWith {};
                                    _unit addItem _mag;
                                 };
                           };
                     };
                  if not (_classHandgun isEqualTo "") then
                     {
                        private ["_mag"];
                        _mag = selectRandom (getArray (configFile >> "CfgWeapons" >> _classHandgun >> "magazines"));
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
