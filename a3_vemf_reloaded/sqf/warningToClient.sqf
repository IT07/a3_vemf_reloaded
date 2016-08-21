/*
   Author: IT07

   Params:
   _this select 0: ARRAY - list of objects to send a warning to

   Returns:
   nothing
*/

params [ "_m", "_to" ];
{
   VEMFrMsgToClient = [ _m, "ba" ];
	( owner _x ) publicVariableClient "VEMFrMsgToClient";
} forEach _to;
