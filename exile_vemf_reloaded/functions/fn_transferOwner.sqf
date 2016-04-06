/*
    Author: IT07

    Description:
    handles the transfer of ownership to another given unit/client/object.
    Will transfer complete group to the same (new) owner.

    Params:
    _this select 0: GROUP - the group of which the ownership should be transfered

    Returns:
    BOOLEAN - true if transfer was successful
*/

private ["_toTransfer","_hcEnabled","_hcUIDs","_hcClients","_to","_transfer"];
_transfer = false;
_toTransfer = param [0, grpNull, [grpNull]];
if not isNull _toTransfer then
{
    // Check if HC is enabled
    _hcEnabled = "headLessClientSupport" call VEMFr_fnc_getSetting;
    _forceClients = uiNamespace getVariable ["VEMFr_forceAItoClients", nil];
    if not(isNil"_forceClients") then
    {
        if _forceClients then
        {
            _hcEnabled = -1;
        };
    };
    if (_hcEnabled isEqualTo 1) then
    { // Gather the Headless Client(s)
        _hcClients = [];
        {
    		if (typeOf _x isEqualTo "HeadlessClient_F") then // it is an HC
        	{
        		_hcClients pushBack [_x, owner _x];
            };
        } forEach allPlayers;
        if (count _hcClients > 0) then
        {
            _to = call VEMFr_fnc_headLessClient; // Select a random hc
        };
        if (count _hcClients isEqualTo 0) then
        {
            uiNamespace setVariable ["VEMFr_forceAItoClients", true];
        };
    };
    if (_hcEnabled isEqualTo 0) then
    {
        if ([1] call VEMFr_fnc_playerCount) then
        {
            _closest = [0,0,0];
            {
                if (isPlayer _x) then
                {
                    _leaderPos = position (leader _toTransfer);
                    _dist = _leaderPos distance (position _x);
                    if (_dist < (_leaderPos distance _closest)) then
                    { // Find the closest player
                        _closest = position _x;
                        _to = _x;
                    };
                };
            } forEach allPlayers;
        };
    };
    if not isNil"_to" then
    {
        _transfer = _toTransfer setGroupOwner (owner _to);
        _load = uiNamespace getVariable ["VEMFrHcLoad", nil];
        if not isNil"_load" then
        {
            _index = _load find _to;
            if (_index > -1) then
            {
                _load set [_index, ((_load select _index) select 1) + 1];
            };
            if (_index isEqualTo -1) then
            {
                _load pushBack [_to, 1];
            };
        };
    };
};

_transfer // Return the value of this var to the calling script
