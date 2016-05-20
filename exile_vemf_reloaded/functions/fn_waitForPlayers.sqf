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

private ["_playerNear","_pos"];
_playerNear = false;
_pos = param [0, [], [[]]];
if (count _pos isEqualTo 3) then
	{
		private ["_rad"];
		_rad = param [1, -1, [0]];
		if (_rad > -1) then
			{
				private ["_time","_timeOutTime","_pp"];
				_time = round time;
				// Define _settings
				_timeOutTime = ("timeOutTime" call VEMFr_fnc_getSetting)*60;
				// _pp = playerPresence
				_pp = [_pos, _rad] call VEMFr_fnc_checkPlayerPresence;
				if _pp then
					{
						_playerNear = true;
					} else
					{
						waitUntil { if (([_pos, _rad] call VEMFr_fnc_checkPlayerPresence) OR (round time - _time > _timeOutTime)) then {true} else {uiSleep 2; false} };
						if ([_pos, _rad] call VEMFr_fnc_checkPlayerPresence) then
							{
								_playerNear = true;
							};
					};
			};
	};

_playerNear
