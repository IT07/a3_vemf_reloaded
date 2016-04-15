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
    ["spawnStaticAI", 2, "launching..."] spawn VEMFr_fnc_log;
    _settings = [["aiStatic"],["positions","amount"]] call VEMFr_fnc_getSetting;
    _positions = _settings select 0;
    if (count _positions > 0) then
    {
        ["spawnStaticAI", 2, "spawning AI on positions..."] spawn VEMFr_fnc_log;
        _amounts = _settings select 1;
        {
            _amount = _amounts select _foreachindex;
            [_x, 2, _amount / 2, "aiMode" call VEMFr_fnc_getSetting] spawn VEMFr_fnc_spawnVEMFrAI;
        } forEach _positions;
    };
};
