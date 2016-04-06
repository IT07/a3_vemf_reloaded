/*
	Author: VAMPIRE, rebooted by IT07

	Description:
	fn_waitForMissionDone - waits for mission to be done

	Params:
	_this select 0: STRING - name of mission location
	_this select 1: POSITION - center of area to be waiting for
	_this select 2: ARRAY - array of units to check for
	_this select 3: SCALAR - radius around center to check for players

	Returns:
	BOOL - true when mission is done
*/

private ["_pos","_unitArr","_unitCount","_killed","_killToComplete","_rad","_playerNear","_complete"];
_complete = false;
_pos = param [1, [], [[]]];
if (count _pos isEqualTo 3) then
{
	_unitArr = param [2, [], [[]]];
	if (count _unitArr > 0) then
	{
		_unitCount = count _unitArr;
		_killed = [];
		_killToComplete = round(("killPercentage" call VEMFr_fnc_getSetting)/100*_unitCount);
		_rad = param [3, 0, [0]];
		if (_rad > 0) then
		{
			while {not _complete} do
			{
				// First check for a player
				if not _complete then { uiSleep 1; };
				_playerNear = [_pos, _rad] call VEMFr_fnc_checkPlayerPresence;
				if (_playerNear) then
				{
					{
						if not(alive _x) then
						{
							_killed pushBack _x;
						};
				 	} forEach _unitArr;
					{ // Delete the not(alive) units
						_index = _unitArr find _x;
						if not(_index isEqualTo -1) then
						{
							_unitArr deleteAt _index;
						};
					} forEach _killed;
				};
				if not _complete then { uiSleep 1 };
				if (((count _killed) isEqualTo _killToComplete) OR ((count _killed) > _killToComplete)) then { _complete = true };
				if not _complete then { uiSleep 1 };
			};
			["fn_waitForMissionDone", 1, format["mission in %1 completed!", _this select 0]] spawn VEMFr_fnc_log;
		};
	};
};
_complete
