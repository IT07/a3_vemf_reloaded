/*
	Author: IT07

	Description:
	will alert players

	Params:
	_this select 0: FORMATTED STRING - thing to send
	_this select 1: STRING - mode to send to client

	Returns:
	nothing
*/

private ["_msg"];
_msg = param [0, "", [[],format[""]]];
if not(_msg isEqualTo "") then
{
	private ["_mode"];
	_mode = param [1, "", [""]];
	if (count allPlayers > 0) then
	{
		{
			if (isPlayer _x) then
			{
				VEMFrClientMsg = [_msg, _mode];
				(owner _x) publicVariableClient "VEMFrClientMsg";
			};
		} forEach allPlayers;
	};
};
