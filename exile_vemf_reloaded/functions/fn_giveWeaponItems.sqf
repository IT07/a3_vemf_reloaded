/*
    Author: IT07

    Description:
    Gives random weapon attachments to given unit

    Params:
    _this: ARRAY
    _this select 0: OBJECT - unit

    Returns: BOOLEAN - true if no errors occured
*/

private ["_done"];
_done = false;
if (_this isEqualType []) then
{
   _unit = param [0, objNull, [objNull]];
   if not (isNull _unit) then
   {
      // primaryWeapon items
      private ["_randomPattern","_primaryWeapon"];
      _randomPattern = [1,0,1,0,1,1,1,1,0,0,1,1,1];
      _primaryWeapon = primaryWeapon _unit;
      if (selectRandom _randomPattern isEqualTo 1) then
      { // Select random scope
         private ["_scopes"];
         _scopes = getArray (configFile >> "CfgWeapons" >> _primaryWeapon >> "WeaponSlotsInfo" >> "CowsSlot" >> "compatibleItems");
         if ("allowTWS" call VEMFr_fnc_getSetting isEqualTo 0) then
         {
            private["_indexes"];
            _indexes = [];
            {
               if (_x find "tws" > -1) then
                  {
                     //["fn_giveWeaponItems", 0, format["This scope is not allowed: %1", _x]] spawn VEMFr_fnc_log;
                     _indexes pushBack _forEachIndex;
                  } else
                  {
                     if (_x find "TWS" > -1) then
                        {
                           //["fn_giveWeaponItems", 0, format["This scope is not allowed: %1", _x]] spawn VEMFr_fnc_log;
                           _indexes pushBack _forEachIndex;
                        };
                  };
            } forEach _scopes;
            {
               _scopes deleteAt _x;
            } forEach _indexes;
         };
         _unit addPrimaryWeaponItem (selectRandom _scopes);
      };
      if (selectRandom _randomPattern isEqualTo 1) then
      { // Select random muzzle
         _unit addPrimaryWeaponItem (selectRandom (getArray (configFile >> "CfgWeapons" >> _primaryWeapon >> "WeaponSlotsInfo" >> "MuzzleSlot" >> "compatibleItems")));
      };
      if (selectRandom _randomPattern isEqualTo 1) then
      { // Select random pointer
         _unit addPrimaryWeaponItem (selectRandom (getArray (configFile >> "CfgWeapons" >> _primaryWeapon >> "WeaponSlotsInfo" >> "PointerSlot" >> "compatibleItems")));
      };
      if (selectRandom _randomPattern isEqualTo 1) then
      { // Select random bipod
         _unit addPrimaryWeaponItem (selectRandom (getArray (configFile >> "CfgWeapons" >> _primaryWeapon >> "WeaponSlotsInfo" >> "UnderbarrelSlot" >> "compatibleItems")));
      };

      private ["_handgunWeapon","_randomPattern"];
      // handgunWeapon items
      _handgunWeapon = handgunWeapon _unit;
      _randomPattern = [1,0,1,0,0,1,0,0,0,0,1,1,1];
      if (selectRandom _randomPattern isEqualTo 1) then
      { // Select random scope
         _unit addHandgunItem (selectRandom (getArray (configFile >> "CfgWeapons" >> _handgunWeapon >> "WeaponSlotsInfo" >> "CowsSlot" >> "compatibleItems")));
      };
      if (selectRandom _randomPattern isEqualTo 1) then
      { // Select random muzzle
         _unit addHandgunItem (selectRandom (getArray (configFile >> "CfgWeapons" >> _handgunWeapon >> "WeaponSlotsInfo" >> "MuzzleSlot" >> "compatibleItems")));
      };
      _done = true;
   };
};
_done
