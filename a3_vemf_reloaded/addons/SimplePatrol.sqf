/*
   Author: IT07

   Description:
   a simple addon for VEMFr that makes a unit patrol from one position to the next

   Params:
   none

   Returns:
   nothing
*/

( [ [ "addonSettings", "SimplePatrol" ], [ "aiMode", "from", "to", "interval", "enableAttack", "combatMode", "behaviour", "speed" ] ] call VEMFr_fnc_config ) params [ "_ms0", "_ms1", "_ms2", "_ms3", "_ms4", "_ms6", "_ms7", "_ms8" ];

if ( _ms0 isEqualTo "random" ) then
   {
      private "_arr";
      _arr = [ 0, 1, 2 ];
      if ( ( "Apex" call VEMFr_fnc_modAppID ) in ( getDLCs 1 ) ) then { _arr append [ 3, 4 ] };
      _ms0 = selectRandom _arr;
   };

if ( _ms0 isEqualTo "manual" ) then { _ms0 = -1 };
if ( _ms7 isEqualTo "random" ) then { _ms7 = selectRandom [ "CARELESS", "SAFE", "AWARE", "DANGER", "STEALTH" ] };

{
   _grp = ( [ _x, 1, 1, _ms0, "SimplePatrol" ] call VEMFr_fnc_spawnVEMFrAI ) select 0;
   _grp allowFleeing 0;
   _grp setBehaviour _ms7;
   _grp setCombatMode _ms6;
   _b = call {
      private "_r";
      if ( _ms4 isEqualTo "false" ) then { _r = false };
      if ( _ms4 isEqualTo "true" ) then { _r = true };
      if not ( isNil "_r" ) then { _r };
   };
   _grp enableAttack _b;

   _wp0 = _grp addWaypoint [ _ms2 select _forEachIndex, 2, 1 ];
   _wp0 setWaypointBehaviour _ms7;
   _wp0 setWaypointCombatMode _ms6;
   _wp0 setWaypointSpeed _ms8;
   _wp0 setWaypointTimeOut [ _ms3, _ms3, _ms3 ];
   _wp0 setWaypointType "MOVE";

   _wp1 = _grp addWaypoint [ _x, 2, 2 ];
   _wp1 setWaypointBehaviour _ms7;
   _wp1 setWaypointCombatMode _ms6;
   _wp1 setWaypointSpeed _ms8;
   _wp1 setWaypointTimeOut [ _ms3, _ms3, _ms3 ];
   _wp1 setWaypointType "MOVE";

   _wp2 = _grp addWaypoint [ _ms2 select _forEachIndex, 2, 3 ];
   _wp2 setWaypointBehaviour _ms7;
   _wp2 setWaypointCombatMode _ms6;
   _wp2 setWaypointSpeed _ms8;
   _wp2 setWaypointTimeOut [ _ms3, _ms3, _ms3 ];
   _wp2 setWaypointType "CYCLE";

   [ _grp ] ExecVM ( "signAI" call VEMFr_fnc_scriptPath );

} forEach _ms1;
