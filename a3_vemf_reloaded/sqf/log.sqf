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

if ( ( "debugMode" call VEMFr_fnc_config ) > 0 ) then
{
   scopeName "_top";
   params [ "_p", "_t", "_l" ];
   _do = { diag_log text format [ "IT07: [VEMFr] %1 -- %2: %3", _p, _this, _l ] };
   _m = "debugMode" call VEMFr_fnc_config;
   if ( _t isEqualTo 0 ) then
   {
      if ( ( _m isEqualTo 1 ) OR ( _m isEqualTo 3 ) ) then
      {
         "ERROR" call _do;
         breakOut "_top";
      };
   };
   if ( _t isEqualTo 1 ) then
   {
      if ( ( _m isEqualTo 2 ) OR ( _m isEqualTo 3 ) ) then
      {
         "INFO" call _do;
         breakOut "_top";
      };
   };
   if ( _t isEqualTo 2 ) then // This bypasses _m setting. Always logs given params even if debugMode is set to 0
   {
      "SYSTEM" call _do;
      breakOut "_top";
   };
};
