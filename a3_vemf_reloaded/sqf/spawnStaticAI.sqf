/*
    Author: IT07

    Description:
    spawns AI at all given locations in config file

    Params:
    none

    Returns:
    nothing
*/

( [ [ "aiStatic" ], [ "enabled", "positions", "amount" ] ] call VEMFr_fnc_config ) params [ "_s0", "_s1", "_s2" ];
if ( _s0 isEqualTo "yes" ) then
   {
      [ "spawnStaticAI", 2, "spawning AI on positions..." ] ExecVM ( "log" call VEMFr_fnc_scriptPath );
      _uc = _s2 select _forEachIndex;
      { [ _x, 2, ( _uc / 2 ) + ( round random ( _uc / 2 ) ), ( [ [ call VEMFr_fnc_whichMod ], [ "aiMode" ] ] call VEMFr_fnc_config ) select 0, "Static" ] spawn VEMFr_fnc_spawnVEMFrAI } forEach _s1;
   };
