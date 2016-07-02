/*
	Author: IT07

	Description:
	will alert players

	Params:
	for global(!) systemChat message:
	_this select 0: FORMATTED STRING - thing to send
	_this select 1: ARRAY - objects to send message to. If empty, broadcast will go to all players
	_this select 2: STRING - must be "sys"
	for mission announcement:
	_this: ARRAY
	_this select 0: ARRAY
	_this select 0 select 0: SCALAR - broadcast type (determines the color of the message icon)
	_this select 0 select 1: STRING - announcement title
	_this select 0 select 2: FORMATTED STRING - Message line
	_this select 1: ARRAY - objects to send message to. If empty, broadcast will go to all players
	_this select 2: STRING - (optional) must be empty or nil | for systemChat broadcast, use "sys"

	Returns:
	nothing
*/

_send =
	{
		private ["_arr"];
		if (count _this isEqualTo 0) then
			{
				_arr = allPlayers;
			} else
			{
				_arr = _this;
			};
			{
				if (isPlayer _x AND alive _x) then
					{
						VEMFrMsgToClient = [_msg, _mode];
						(owner _x) publicVariableClient "VEMFrMsgToClient";
					};
			} forEach _arr;
	};

_to = param [1, [], [[]]];

if (_this select 0 isEqualType []) then // mission notification
	{
		_mode = (_this select 0) param [0, -1, [0]];
		_title = (_this select 0) param [1, "DEFAULT TITLE", [""]];
		_line = (_this select 0) param [2, "Default message", [""]];
		_msg = [_mode, _title, _line];
		_to call _send;
	};

if (_this select 0 isEqualType "") then // systemchat broadcast
	{
		_mode = param [2, "", [""]];
		_msg = param [0, "", [""]];
		_to call _send;
	};
