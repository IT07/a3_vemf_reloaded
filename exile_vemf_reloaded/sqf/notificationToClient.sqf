/*
	Author: IT07

	Description:
	will put mission notification on either all screens or just on given

	Params:
	_this select 0: SCALAR - mission type (AI mode)
	_this select 1: STRING - notification title
	_this select 2: STRING - notification message
	_this select 3: ARRAY (optional) - specific clients to (ONLY) send notification to

	Returns:
	nothing
*/

_missionType = param [0, -1, [-1]];
_title = param [1, "", [""]];
_msgLine = param [2, "", [""]];
_sendTo = param [3, [], [[]]];
if (count _sendTo isEqualTo 0) then { _sendTo = allPlayers };
{
	VEMFrMsgToClient = [[_missionType, _title, _msgLine], ""];
	(owner _x) publicVariableClient "VEMFrMsgToClient";
} forEach _sendTo;
