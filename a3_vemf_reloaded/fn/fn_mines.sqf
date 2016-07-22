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
private ["_r","_this0","_this1","_this2","_this3","_s","_ms","_a","_mt"];
params [
   ["_this0",[],[[]]],
   ["_this1",-1,[0]],
   ["_this2",-1,[0]],
   ["_this3", "", [""]]
];

([["missionSettings",(_this3)],["mines","minesAmount"]] call VEMFr_fnc_config) params ["_ms","_a"];
if ((_this3 in ("missionList" call VEMFr_fnc_config)) AND (_ms > 0) AND ((count _this0) isEqualTo 3) AND (_this1 > -1) AND (_this2 > _this1) AND (_a > -1)) then
   {
      if (_ms isEqualTo 1) then { _mt = ["ATMine"] };
      if (_ms isEqualTo 2) then { _mt = ["APERSMine"] };
      if (_ms isEqualTo 3) then { _mt = ["ATMine","APERSMine"] };
      if (_ms < 1 OR _ms > 3) then
         {
            ["fn_mines", 0, "Invalid mines mode!"] ExecVM ("log" call VEMFr_fnc_scriptPath);
            breakOut "mines"
         };
      _r = [];

      for "_m" from 1 to _a do
         {
            _r pushBack (createMine [selectRandom _mt, ([_this0, _this1, _this2, 2, 0, 20, 0] call BIS_fnc_findSafePos), [], 0]);
            uiSleep 0.1;
         };
   };

_r
