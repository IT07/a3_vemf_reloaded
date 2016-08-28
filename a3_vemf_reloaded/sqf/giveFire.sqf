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
    nothing
*/

params [ "_this0", "_this1", "_this2", "_this3" ];

if not ( _this1 isEqualTo "" ) then // primaryWeapon
   {
      private _m = selectRandom ( getArray ( configFile >> "CfgWeapons" >> _this1 >> "magazines" ) );
      for "_l" from 1 to 5 do
         {
            if not ( _this0 canAdd _m ) exitWith { };
            _this0 addItem _m;
         };
      _this0 addWeapon _this1;
      _this0 selectWeapon _this1;

      private _p = [ 1, 0, 1, 0, 1, 1, 1, 1, 0, 0, 1, 1, 1 ];
      if ( ( selectRandom _p ) isEqualTo 1 ) then
         { // Select random scope
            private _a = getArray ( configFile >> "CfgWeapons" >> _this1 >> "WeaponSlotsInfo" >> "CowsSlot" >> "compatibleItems" );
            if ( ( "allowTWS" call VEMFr_fnc_config ) isEqualTo "no" ) then
               {
                  private _b = ( [ [ "blacklists", "scopes" ], [ "thermal" ] ] call VEMFr_fnc_config ) select 0;
                  private _bin = [ ];
                  {
                     if ( ( ( ( toLower _x ) find "tws" ) > -1 ) OR ( _x in _b ) ) then { _bin pushBack _x };
                  } forEach _a;
                  { _a deleteAt ( _a find _x ) } forEach _bin;
               };
            _this0 addPrimaryWeaponItem ( selectRandom _a );
         };
      if ( ( selectRandom _p ) isEqualTo 1 ) then
         { // Select random muzzle
            _this0 addPrimaryWeaponItem ( selectRandom ( getArray ( configFile >> "CfgWeapons" >> _this1 >> "WeaponSlotsInfo" >> "MuzzleSlot" >> "compatibleItems" ) ) );
         };
      if ( ( selectRandom _p ) isEqualTo 1 ) then
         { // Select random pointer
            _this0 addPrimaryWeaponItem ( selectRandom ( getArray ( configFile >> "CfgWeapons" >> _this1 >> "WeaponSlotsInfo" >> "PointerSlot" >> "compatibleItems" ) ) );
         };
      if ( ( selectRandom _p ) isEqualTo 1 ) then
         { // Select random bipod
            _this0 addPrimaryWeaponItem ( selectRandom ( getArray ( configFile >> "CfgWeapons" >> _this1 >> "WeaponSlotsInfo" >> "UnderbarrelSlot" >> "compatibleItems" ) ) );
         };
   };

if not ( _this2 isEqualTo "" ) then // secondaryWeapon
   {
      if not ( ( backPack _this0 ) isEqualTo "" ) then
         {
            private _m = selectRandom ( getArray ( configFile >> "CfgWeapons" >> _this2 >> "magazines" ) );
            for "_l" from 1 to 3 do
               {
                  if not ( _this0 canAdd _m ) exitWith { };
                  _this0 addItem _m;
               };
         };
      _this0 addWeapon _this2;
   };

if not ( _this3 isEqualTo "" ) then // handgunWeapon
   {
      private _m = selectRandom ( getArray ( configFile >> "CfgWeapons" >> _this3 >> "magazines" ) );
      for "_l" from 1 to 4 do
         {
            if not ( _this0 canAdd _m ) exitWith { };
            _this0 addItem _m;
         };
      _this0 addWeapon _this3;

      _p = [ 1, 0, 1, 0, 0, 1, 0, 0, 0, 0, 1, 1, 1 ];
      if ( ( selectRandom _p ) isEqualTo 1 ) then
         { // Select random scope
            _this0 addHandgunItem ( selectRandom ( getArray ( configFile >> "CfgWeapons" >> _this3 >> "WeaponSlotsInfo" >> "CowsSlot" >> "compatibleItems" ) ) );
         };
      if ( ( selectRandom _p ) isEqualTo 1 ) then
         { // Select random muzzle
            _this0 addHandgunItem ( selectRandom ( getArray ( configFile >> "CfgWeapons" >> _this3 >> "WeaponSlotsInfo" >> "MuzzleSlot" >> "compatibleItems" ) ) );
         };
   };
