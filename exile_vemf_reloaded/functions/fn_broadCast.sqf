/*
	Author: IT07

	Description:
	will alert players

	Params:
	for global(!) systemChat message:
	_this select 0: FORMATTED STRING - thing to send
	_this select 1: STRING - must be "sys"
	for mission announcement:
	_this: ARRAY
	_this select 0: ARRAY
	_this select 0 select 0: FORMATTED STRING - Message line
	_this select 0 select 1: STRING - announcement title
	_this select 0 select 2: ARRAY - (optional) only send message to those units
	_this select 1: STRING - (optional) must be empty or nil

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
		_targets = (_this select 0) param [2, [],[[]]];
		_broadCast =
		{
			{
				if (isPlayer _x) then
				{
					VEMFrClientMsg = [_msg, _mode];
					(owner _x) publicVariableClient "VEMFrClientMsg";
				};
			} forEach _this;
		};
		if (count _targets isEqualTo 0) then
		{
			allPlayers call _broadCast;
		} else
		{
			_targets call _broadCast;
		};
	};
};
