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

private [ "_r", "_m" ];
params [ "_this0", "_this1", "_this2", "_this3" ];
_r = [ ];
if not ( _this1 isEqualTo "" ) then
   {
      _m = selectRandom ( getArray ( configFile >> "CfgWeapons" >> _this1 >> "magazines" ) );
      for "_l" from 1 to 5 do
         {
            if not ( _this0 canAdd _m ) exitWith { };
            _this0 addItem _m;
         };
      _r pushBack true;
   };

if not ( _this2 isEqualTo "" ) then
   {
      if not ( ( backPack _this0 ) isEqualTo "" ) then
         {
            _m = selectRandom ( getArray ( configFile >> "CfgWeapons" >> _this2 >> "magazines" ) );
            for "_l" from 1 to 3 do
               {
                  if not ( _this0 canAdd _m ) exitWith { };
                  _this0 addItem _m;
               };
            _r pushBack true;
         };
   };

if not ( _this3 isEqualTo "" ) then
   {
      _m = selectRandom ( getArray ( configFile >> "CfgWeapons" >> _this3 >> "magazines" ) );
      for "_l" from 1 to 4 do
         {
            if not ( _this0 canAdd _m ) exitWith { };
            _this0 addItem _m;
         };
      _r pushBack true;
   };

if ( ( count _r ) > 0 ) then { _r = true; _r } else { _r = nil };
