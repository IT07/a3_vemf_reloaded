/*
    Author: IT07

    Description:
    spawns AI at all given locations in config file

    Params:
    none

    Returns:
    nothing
*/

if (([["aiStatic"],["enabled"]] call VEMFr_fnc_getSetting) select 0 isEqualTo 1) then
{
   ["spawnStaticAI", 2, "launching..."] ExecVM "exile_vemf_reloaded\sqf\log.sqf";
   _settings = [["aiStatic"],["positions","amount"]] call VEMFr_fnc_getSetting;
   _positions = _settings select 0;
   ["spawnStaticAI", 2, "spawning AI on positions..."] ExecVM "exile_vemf_reloaded\sqf\log.sqf";
   _amounts = _settings select 1;
   {
      [_x, 2, _amounts select _foreachindex, "aiMode" call VEMFr_fnc_getSetting, "Static"] spawn VEMFr_fnc_spawnVEMFrAI;
   } forEach _positions;
};
