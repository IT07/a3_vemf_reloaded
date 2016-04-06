if (hasInterface) then
{
	uiNamespace setVariable ["RscDisplayVEMFrClientMsgQueue", []];
	uiNamespace setVariable ["RscDisplayVEMFrClient", displayNull];
	// custom addPublicVariableEventHandler. Those bloody BE filters.....
	[] spawn
	{
		while {true} do
		{
			waitUntil { uiSleep 0.05; not isNil"VEMFrClientMsg" };
			if (typeName VEMFrClientMsg isEqualTo "ARRAY") then
			{
				_data = +[VEMFrClientMsg];
				VEMFrClientMsg = nil;
				_data = _data select 0;
				[_data] spawn
				{
					_data = _this select 0;
					_mode = [_data, 1, "", [""]] call BIS_fnc_param;
					_msg = [_data, 0, "", [[],format[""]]] call BIS_fnc_param;
					switch _mode do
					{
						case "sys":
						{
							systemChat _msg;
						};
						default
						{
							[_msg select 0, _msg select 1] spawn VEMFr_fnc_handleMessage;
						};
					};
				};
			};
		};
	};
};
