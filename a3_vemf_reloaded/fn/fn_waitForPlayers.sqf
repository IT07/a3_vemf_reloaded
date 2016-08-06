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

private [("_r"),("_this0"),("_this1")];
params [
	[("_this0"),([]),([[]])],
	[("_this1"),(-1),([0])]
];

_r = false;
if ([(_this0),(_this1)] call VEMFr_fnc_playerNear) then { _r = true }
 	else
		{
			private [("_t"),("_tot")];
			_t = round time;
			_tot = ("timeOutTime" call VEMFr_fnc_config)*60;
			waitUntil { if (([(_this0),(_this1)] call VEMFr_fnc_playerNear) OR (round time - _t > _tot)) then {true} else {uiSleep 4; false} };
			if ([(_this0),(_this1)] call VEMFr_fnc_playerNear) then { _r = true };
		};
_r
