/*
   Author: IT07

   Description:
   handles the cleanup of AI gear and handles kill effects

   Params:
   _this select 0: OBJECT (the AI)
*/

_t = _this select 0;

( [ [ "aiCleanup" ], [ "removeLaunchers", "aiDeathRemovalEffect", "removeHeadGear" ] ] call VEMFr_fnc_config ) params [ "_ms0", "_ms1", "_ms2" ];
if ( _ms0 isEqualTo "yes" ) then
   {
      _sw = secondaryWeapon _t;
      if not ( _sw isEqualTo "" ) then
         {
            _t removeWeaponGlobal _sw;
            _mssls = getArray ( configFile >> "cfgWeapons" >> _sw >> "magazines" );
            {
               if ( _x in _mssls ) then { _t removeMagazineGlobal _x };
            } forEach ( magazines _t );
         };
   };
if ( _ms2 isEqualTo "yes" ) then { removeHeadGear _t };

if ( _ms1 isEqualTo "yes" ) then // If killEffect enabled
   {
      playSound3D [ "A3\Missions_F_Bootcamp\data\sounds\vr_shutdown.wss", _t, false, getPosASL _t, 2, 1, 60 ];
      for "_u" from 1 to 12 do
      {
         if not ( isObjectHidden _t ) then { _t hideObjectGlobal true }
            else { _t hideObjectGlobal false };
         uiSleep 0.12;
      };
      _t hideObjectGlobal true;
      removeAllWeapons _t;
      // Automatic cleanup yaaay
      deleteVehicle _t;
   } else
      {
         _mod = call VEMFr_fnc_whichMod;
         if ( _mod isEqualTo "Exile" ) then
            {
               _v = ( [ [ _mod ],[ "aiMoney" ] ] call VEMFr_fnc_config ) select 0;
               if ( _v > 0 ) then { _t setVariable [ "exilemoney", 2 + ( ( round random _v ) - 2 ), true ] };
            };
      };
