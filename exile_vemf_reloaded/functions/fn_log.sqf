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

private ["_loggingEnabled"];
_loggingEnabled = "debugMode" call VEMFr_fnc_getSetting;
if not(_loggingEnabled isEqualTo 0) then
{
   private ["_prefix","_type","_line","_doLog"];
   _prefix = param [0, "", [""]];
   _type = param [1, 3, [0]];
   _line = param [2, "", [""]];
   _doLog =
   {
      diag_log text format["IT07: [exile_vemf_reloaded] %1 -- %2", _prefix, _line];
   };

   switch _type do
   {
      case 0:
      {
         if (_loggingEnabled isEqualTo 1 OR _loggingEnabled isEqualTo 3) then
         {
            call _doLog;
         };
      };
      case 1:
      {
         if (_loggingEnabled isEqualTo 2 OR _loggingEnabled isEqualTo 3) then
         {
            call _doLog;
         };
      };
      case 2:
      {
         call _doLog;
      };
   };
};
