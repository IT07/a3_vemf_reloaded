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

private ["_param","_prefix","_mode","_logThis","_logModesAllowed","_loggingEnabled"];
_loggingEnabled = "debugMode" call VEMFr_fnc_getSetting;
if (_loggingEnabled > 0) then
{
    if (_loggingEnabled < 4) then
    {
        _type = param [1, 3, [0]];
        _line = param [2, "", [""]];
        if (_type < _loggingEnabled) then
        {
            if not(_line isEqualTo "") then
            {
                diag_log text format["IT07: [exile_vemf_reloaded] %1", _line];
            };
        };
        if (_type isEqualTo 2) then // Always allow log type 2 no matter which debugMode is set
        {
            diag_log text format["IT07: [exile_vemf_reloaded] %1", _line];
        };
    };
};
