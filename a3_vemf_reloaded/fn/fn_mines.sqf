/*
    Author: IT07

    Description:
    places mines around given position within given radius

    Params:
    _this select 0: POSITION - center of area to place mines around
    _this select 1: SCALAR - the minimum distance
    _this select 2: SCALAR - the maximum distance (must be higher than minimum of course)
    _this select 3: STRING - exact config name of mission

    Returns:
    ARRAY - array containing all mine objects
*/

scopeName "mines";
private [ "_r", "_this0", "_this1", "_this2", "_this3", "_t", "_c", "_mt" ];
params [ "_this0", "_this1", "_this2", "_this3" ];
if (_this3 in ( "missionList" call VEMFr_fnc_config ) ) then
   {
      ( [ [ "missionSettings", _this3, "mines" ], [ "count", "type" ] ] call VEMFr_fnc_config ) params [ "_c", "_t" ];
      if ( _t isEqualTo "at" ) then { _mt = [ "ATMine" ] };
      if ( _t isEqualTo "ap" ) then { _mt = [ "APERSMine" ] };
      if ( _t isEqualTo "atap" ) then { _mt = [ "ATMine", "APERSMine" ] };
      if ( isNil "_mt" ) exitWith { [ "fn_mines", 0, format [ "invalid mines type: %1", _t ] ] ExecVM ( "log" call VEMFr_fnc_scriptPath ) };
      _r = [ ];

      for "_m" from 1 to _c do
         {
            _r pushBack ( createMine [ selectRandom _mt, ( [ _this0, _this1, _this2, 2, 0, 20, 0 ] call BIS_fnc_findSafePos ), [], 0 ] );
            uiSleep 0.1;
         };
   };

if not ( isNil "_r" ) then { _r };
