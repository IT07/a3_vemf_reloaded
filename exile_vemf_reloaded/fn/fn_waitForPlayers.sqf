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

private ["_playerNear","_pos","_rad"];
_playerNear = false;
params [["_pos",[],[[]]], ["_rad",-1,[0]]];
if (((count _pos) isEqualTo 3) AND (_rad > -1)) then
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
				waitUntil { if (([_pos, _rad] call VEMFr_fnc_checkPlayerPresence) OR (round time - _time > _timeOutTime)) then {true} else {uiSleep 4; false} };
				if ([_pos, _rad] call VEMFr_fnc_checkPlayerPresence) then
					{
						_playerNear = true;
					};
			};
	} else
	{
		["waitForPlayers",0,format["params are invalid! [%1,%2]", ((count _pos) isEqualTo 3), (_rad > -1)]] ExecVM "exile_vemf_reloaded\sqf\log.sqf";
	};

_playerNear
