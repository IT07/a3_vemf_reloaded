/*
    Author: IT07

    Description:
    places mines around given position within given radius

    Params:
    _this select 0: POSITION - center of area to place mines around
    _this select 1: SCALAR - the minimum distance
    _this select 2: SCALAR - the maximum distance (must be higher than minimum of course)

    Returns:
    BOOL - true if all OK
*/

private ["_ok","_enabled","_pos","_min","_max","_amount","_minePos","_mine","_mines","_mines","_mineTypes"];
_ok = false;
_enabled = ([["DynamicLocationInvasion"],["mines"]] call VEMFr_fnc_getSetting) select 0;
if (_enabled > 0) then
{
    _pos = param [0, [], [[]]];
    if (count _pos isEqualTo 3) then
    {
        _min = param [1, -1, [0]];
        if (_min > -1) then
        {
            _max = param [2, -1, [0]];
            if (_max > _min) then
            {
                _amount = ([["DynamicLocationInvasion"],["minesAmount"]] call VEMFr_fnc_getSetting) select 0;
                if (_amount > -1) then
                {
                    _mines = [["DynamicLocationInvasion"],["mines"]] call VEMFr_fnc_getSetting param [0, 1, [0]];
                    if (_mines isEqualTo 1) then { _mineTypes = ["ATMine"] };
                    if (_mines isEqualTo 2) then { _mineTypes = ["APERSMine"] };
                    if (_mines isEqualTo 3) then { _mineTypes = ["ATMine","APERSMine"] };
                    _mines = [];
                    ["fn_placeMines", 1, format["Placing %1 mines at %2", _amount, _pos]] spawn VEMFr_fnc_log;
                    for "_m" from 1 to _amount do
                    {
                        _mine = createMine [selectRandom _mineTypes, ([_pos, _min, _max, 2, 0, 20, 0] call BIS_fnc_findSafePos), [], 0];
                        uiSleep 0.5;
                        _mines pushBack _mine;
                    };
                    _ok = [_mines];
                };
            };
        };
    };
};

_ok
