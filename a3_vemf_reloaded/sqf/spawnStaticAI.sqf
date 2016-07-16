/*
    Author: IT07

    Description:
    spawns AI at all given locations in config file

    Params:
    none

    Returns:
    nothing
*/

if ((([["aiStatic"],["enabled"]] call VEMFr_fnc_config) select 0) isEqualTo 1) then
{
   ["spawnStaticAI", 2, "launching..."] ExecVM ("log" call VEMFr_fnc_scriptPath);
   ([["aiStatic"],["positions","amount"]] call VEMFr_fnc_config) params ["_s0","_s1"];
   ["spawnStaticAI", 2, "spawning AI on positions..."] ExecVM ("log" call VEMFr_fnc_scriptPath);
   {
      [_x, 2, _s1 select _foreachindex, ([[call VEMFr_fnc_whichMod],["aiMode"]] call VEMFr_fnc_config) select 0, "Static"] spawn VEMFr_fnc_spawnVEMFrAI;
   } forEach _s0;
};
