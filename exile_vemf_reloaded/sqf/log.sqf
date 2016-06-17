/*
    Author: IT07

    Description:
    will log given data if debug is enabled

    Params:
    _this: ARRAY - contains data required for logging
    _this select 0: STRING - prefix. Use "" if none
    _this select 1: SCALAR - 0 = error, 1 = info, 2 = special
    _this select 2: STRING - the thing to log

    Returns:
    nothing (use spawn, not call)
*/

if ("debugMode" call VEMFr_fnc_getSetting > 0) then
{
   scopeName "outer";
   private ["_prefix","_type","_line","_doLog"];
   params [["_prefix","",[""]], ["_type",3,[0]], ["_line","",[""]]];

   _doLog = { diag_log text format["IT07: [exile_vemf_reloaded] %1 -- %2: %3", _prefix, _this, _line] };
   _debugMode = "debugMode" call VEMFr_fnc_getSetting;
   if (_type isEqualTo 0) then
   {
      if (_debugMode isEqualTo 1 OR _debugMode isEqualTo 3) then
      {
         "ERROR" call _doLog;
         breakOut "outer";
      };
   };
   if (_type isEqualTo 1) then
   {
      if (_debugMode isEqualTo 2 OR _debugMode isEqualTo 3) then
      {
         "INFO" call _doLog;
         breakOut "outer";
      };
   };
   if (_type isEqualTo 2) then // This bypasses _debugMode setting. Always logs given params even if debugMode is set to 0
   {
      "SYSTEM" call _doLog;
      breakOut "outer";
   };
};
