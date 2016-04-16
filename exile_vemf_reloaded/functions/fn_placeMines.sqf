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
    BOOL - true if all OK
*/

private ["_ok","_mineSetting","_missionName"];
_ok = false;
_missionName = param [3, "", [""]];
if (_missionName in ("missionList" call VEMFr_fnc_getSetting)) then
{
   scopeName "main";
   private ["_mineSetting"];
   _mineSetting = ([[_missionName],["mines"]] call VEMFr_fnc_getSetting) select 0;
   if (_mineSetting > 0) then
   {
      private ["_pos"];
      _pos = param [0, [], [[]]];
      if (count _pos isEqualTo 3) then
      {
         private ["_min"];
         _min = param [1, -1, [0]];
         if (_min > -1) then
         {
            private ["_max"];
            _max = param [2, -1, [0]];
            if (_max > _min) then
            {
               private ["_amount"];
               _amount = ([[_missionName],["minesAmount"]] call VEMFr_fnc_getSetting) select 0;
               if (_amount > -1) then
               {
                  private ["_mineTypes"];
                  if (_mineSetting isEqualTo 1) then { _mineTypes = ["ATMine"] };
                  if (_mineSetting isEqualTo 2) then { _mineTypes = ["APERSMine"] };
                  if (_mineSetting isEqualTo 3) then { _mineTypes = ["ATMine","APERSMine"] };
                  if (_mineSetting < 1 OR _mineSetting > 3) then
                  {
                     ["fn_placeMines", 0, "Invalid mines mode!"] spawn VEMFr_fnc_log;
                     breakOut "main"
                  };

                  _mines = [];
                  ["fn_placeMines", 1, format["Placing %1 mines at %2", _amount, _pos]] spawn VEMFr_fnc_log;
                  for "_m" from 1 to _amount do
                  {
                     private ["_mine"];
                     _mine = createMine [selectRandom _mineTypes, ([_pos, _min, _max, 2, 0, 20, 0] call BIS_fnc_findSafePos), [], 0];
                     uiSleep 0.1;
                     _mines pushBack _mine;
                  };
                  _ok = [_mines];
               };
            };
         };
      };
   };
};

_ok
