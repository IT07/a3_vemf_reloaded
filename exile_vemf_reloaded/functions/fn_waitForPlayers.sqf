/*
	Author: IT07

	Description:
	fn_waitForPlayers - waits for player to be nearby given pos

	Params:
	_this select 0: POSITION - center of area to check for players
	_this select 1: SCALAR - radius to check around POSITION

	Returns:
	BOOL - true if there is a player present
*/

private ["_playerNear","_pos","_rad","_time","_timeOutTime","_pp"];
_playerNear = false;
_pos = param [0, [], [[]]];
if (count _pos isEqualTo 3) then
{
	_rad = param [1, -1, [0]];
	if (_rad > -1) then
	{
		_time = round time;
		// Define _settings
		_timeOutTime = ("timeOutTime" call VEMFr_fnc_getSetting)*60;
		// _pp = playerPresence
		_pp = [_pos, _rad] call VEMFr_fnc_checkPlayerPresence;
		if _pp then
		{
			_playerNear = true;
		};
		if not _pp then
		{
			waitUntil { uiSleep 2; (([_pos, _rad] call VEMFr_fnc_checkPlayerPresence) OR (round time - _time > _timeOutTime)) };
			if ([_pos, _rad] call VEMFr_fnc_checkPlayerPresence) then
			{
				_playerNear = true;
			};
		};
	};
};

_playerNear
