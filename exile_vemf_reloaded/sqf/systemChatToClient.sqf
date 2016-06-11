/*
   Author: IT07

   Params:
   _this select 0: FORMATTED STRING - line to broadcast
   _this select 1: ARRAY - specific clients to (ONLY) send line to

   Returns:
   nothing
*/

_line = param [0, "", [""]];
_sendTo = param [1, [], [[]]];
if (_sendTo isEqualTo []) then { _sendTo = allPlayers };
{
   VEMFrMsgToClient = [_line, "sys"];
	(owner _x) publicVariableClient "VEMFrMsgToClient";
} forEach _sendTo;
