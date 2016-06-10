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

if (_this isEqualType []) then
	{
		_broadCast =
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
		_targets = param [1, [], [[]]];
		if (_this select 0 isEqualType []) then // mission notification
			{
				_mode = (_this select 0) param [0, -1, [0]];
				_title = (_this select 0) param [1, "DEFAULT TITLE", [""]];
				_msgLine = (_this select 0) param [2, "Default message", [""]];
				_msg = [_mode, _title, _msgLine];
				_targets call _broadCast;
			};
		if (_this select 0 isEqualType "") then // systemchat broadcast
			{
				_mode = param [2, "", [""]];
				_msg = param [0, "", [""]];
				_targets call _broadCast;
			};
	} else
	{
		["broadcast.sqf", 0, format["_this is not an ARRAY: %1", _this]] ExecVM "exile_vemf_reloaded\sqf\log.sqf";
	};
