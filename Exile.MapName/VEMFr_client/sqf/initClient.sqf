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
					_mode = _data param [1, "", [""]];
					_msg = _data param [0, "", [[],format[""]]];
					switch _mode do
					{
						case "sys":
						{
							systemChat _msg;
						};
						default
						{
							[_msg select 0, _msg select 1] ExecVM "VEMFr_client\sqf\handleMessage.sqf";
						};
					};
				};
			};
		};
	};
};
