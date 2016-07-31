/*
   Author: IT07

   Params:
   _this select 0: FORMATTED STRING - line to broadcast
   _this select 1: ARRAY - specific clients to (ONLY) send line to

   Returns:
   nothing
*/

params [
   [("_line"),(""),([""])],
   [("_to"),([]),([[]])]
];

if (_to isEqualTo []) then { _to = allPlayers };
{
   VEMFrMsgToClient = [(_line),("sys")];
	(owner _x) publicVariableClient "VEMFrMsgToClient";
} forEach _to;
