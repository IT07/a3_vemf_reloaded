/*
    Author: IT07

    Description:
    Gives random weapon attachments to given unit

    Params:
    _this: ARRAY
    _this select 0: OBJECT - unit

    Returns: BOOLEAN - true if no errors occured
*/

private [("_r"),("_p"),("_w"),("_a"),("_bin")];
_u = param [0,objNull,[objNull]];
if not (isNull _u) then
   {
      _p = [1,0,1,0,1,1,1,1,0,0,1,1,1];
      _w = primaryWeapon _u;
      if ((selectRandom _p) isEqualTo 1) then
         { // Select random scope
            _a = getArray (configFile >> "CfgWeapons" >> _w >> "WeaponSlotsInfo" >> "CowsSlot" >> "compatibleItems");
            if (("allowTWS" call VEMFr_fnc_config) isEqualTo "no") then
               {
                  _bin = [];
                  {
                     if (((toLower _x) find "tws") > -1) then
                        {
                           _bin pushBack _x;
                        };
                  } forEach _a;
                  {
                     _a deleteAt (_a find _x);
                  } forEach _bin;
               };
            _u addPrimaryWeaponItem (selectRandom _a);
         };
      if ((selectRandom _p) isEqualTo 1) then
         { // Select random muzzle
            _u addPrimaryWeaponItem (selectRandom (getArray (configFile >> "CfgWeapons" >> _w >> "WeaponSlotsInfo" >> "MuzzleSlot" >> "compatibleItems")));
         };
      if ((selectRandom _p) isEqualTo 1) then
         { // Select random pointer
            _u addPrimaryWeaponItem (selectRandom (getArray (configFile >> "CfgWeapons" >> _w >> "WeaponSlotsInfo" >> "PointerSlot" >> "compatibleItems")));
         };
      if ((selectRandom _p) isEqualTo 1) then
         { // Select random bipod
            _u addPrimaryWeaponItem (selectRandom (getArray (configFile >> "CfgWeapons" >> _w >> "WeaponSlotsInfo" >> "UnderbarrelSlot" >> "compatibleItems")));
         };

      // handgunWeapon items
      _w = handgunWeapon _u;
      _p = [1,0,1,0,0,1,0,0,0,0,1,1,1];
      if ((selectRandom _p) isEqualTo 1) then
         { // Select random scope
            _u addHandgunItem (selectRandom (getArray (configFile >> "CfgWeapons" >> _w >> "WeaponSlotsInfo" >> "CowsSlot" >> "compatibleItems")));
         };
      if ((selectRandom _p) isEqualTo 1) then
         { // Select random muzzle
            _u addHandgunItem (selectRandom (getArray (configFile >> "CfgWeapons" >> _w >> "WeaponSlotsInfo" >> "MuzzleSlot" >> "compatibleItems")));
         };
      _r = true;
   };

if not(isNil"_r") then { _r };
