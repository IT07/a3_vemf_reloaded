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

private ["_complete","_missionName","_pos","_unitArr","_rad"];
_complete = false;
params [["_missionName","",[""]], ["_pos",[],[[]]], ["_unitArr",[],[[]]], ["_rad",0,[0]]];
if (count _pos isEqualTo 3) then
	{
		if (count _unitArr > 0) then
			{
				private ["_unitCount","_killed","_killToComplete"];
				_unitCount = count _unitArr;
				_killed = [];
				_killToComplete = round(("killPercentage" call VEMFr_fnc_getSetting)/100*_unitCount);
				if (_rad > 0) then
					{
						while {not _complete} do
							{
								_kiaCount = 0;
								{
									if (damage _x isEqualTo 1 OR isNull _x) then
										{
											_kiaCount = _kiaCount + 1;
										};
				 				} forEach _unitArr;
								if (_kiaCount >= _killToComplete) exitWith { _complete = true };
								uiSleep 4;
							};
						["waitForMissionDone", 1, format["mission in %1 has been completed!", _missionName]] ExecVM "exile_vemf_reloaded\sqf\log.sqf";
					};
			};
	};

_complete
