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

scopeName "main";
private ["_ok","_pos","_min","_max","_mineSetting","_missionName","_settings","_mineSetting","_amount"];
_ok = false;
params [["_pos",[],[[]]], ["_min",-1,[0]], ["_max",-1,[0]], ["_missionName", "", [""]]];
_settings = [[_missionName],["mines","minesAmount"]] call VEMFr_fnc_getSetting;
_settings params ["_mineSetting","_amount"];
if ((_missionName in ("missionList" call VEMFr_fnc_getSetting)) AND (_mineSetting > 0) AND ((count _pos) isEqualTo 3) AND (_min > -1) AND (_max > _min) AND (_amount > -1)) then
   {
      private ["_mineTypes"];
      if (_mineSetting isEqualTo 1) then { _mineTypes = ["ATMine"] };
      if (_mineSetting isEqualTo 2) then { _mineTypes = ["APERSMine"] };
      if (_mineSetting isEqualTo 3) then { _mineTypes = ["ATMine","APERSMine"] };
      if (_mineSetting < 1 OR _mineSetting > 3) then
         {
            ["fn_placeMines", 0, "Invalid mines mode!"] ExecVM "exile_vemf_reloaded\sqf\log.sqf";
            breakOut "main"
         };
      _mines = [];
      ["fn_placeMines", 1, format["Placing %1 mines at %2", _amount, _pos]] ExecVM "exile_vemf_reloaded\sqf\log.sqf";
      for "_m" from 1 to _amount do
         {
            private ["_mine"];
            _mine = createMine [selectRandom _mineTypes, ([_pos, _min, _max, 2, 0, 20, 0] call BIS_fnc_findSafePos), [], 0];
            uiSleep 0.1;
            _mines pushBack _mine;
         };
      _ok = [_mines];
   };

_ok
