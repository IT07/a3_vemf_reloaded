if (hasInterface) then
{
	uiNamespace setVariable ["RscDisplayVEMFrClientMsgQueue", []];
	uiNamespace setVariable ["RscDisplayVEMFrClient", displayNull];
	// custom addPublicVariableEventHandler. Those bloody BE filters.....
	[] spawn
	{
		_handleMessage =
		{
			_data = _this;
			_msg = param [0, "", [[],format[""]]];
			_mode = param [1, "", [""]];
			if (_mode isEqualTo "sys") then
			{
				systemChat _msg;
			} else
			{
				[_msg select 0, _msg select 1] ExecVM "VEMFr_client\sqf\handleMessage.sqf";
			};
		};
		while {true} do
		{
			waitUntil { if isNil"VEMFrClientMsg" then { uiSleep 0.05; false } else { true }};
			_data = VEMFrClientMsg;
			VEMFrClientMsg = nil;
			_data spawn _handleMessage;
		};
	};
};
