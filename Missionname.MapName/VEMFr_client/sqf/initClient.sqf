if hasInterface then
	{
		uiNamespace setVariable ["VEMFrMsgQueue", []];
		uiNamespace setVariable ["RscDisplayVEMFrClient", displayNull];
		// custom addPublicVariableEventHandler. Those bloody BE filters.....
		if isMultiplayer then
			{
				_handleMessage =
					{
						_data = _this;
						_msg = param [0, "", [[],format[""]]];
						_mode = param [1, "", ["", -1]];
						if (_mode isEqualTo "sys") then
							{
								systemChat _msg;
							} else
							{
								(uiNamespace getVariable ["VEMFrMsgQueue", []]) pushBack _msg;
								if isNull(uiNamespace getVariable ["RscDisplayVEMFrClient", displayNull]) then
									{
										(["RscDisplayVEMFrClient"] call BIS_fnc_rscLayer) cutRsc["RscDisplayVEMFrClient", "PLAIN", 0, true]
									};
							};
					};
				while {true} do
					{
						if not isNil"VEMFrMsgToClient" then
							{
								VEMFrMsgToClient spawn _handleMessage;
								VEMFrMsgToClient = nil;
							} else
							{
								uiSleep 0.05;
							};
					};
			} else
			{
				_arr = uiNamespace getVariable ["VEMFrMsgQueue",[]];
				_arr pushBack [0,"NEW TAKEOVER","Raiders have taken over ..."];
				_arr pushBack [1,"NEW POLICE RAID", format["%1 Police forces are raiding ...", worldName]];
				_arr pushBack [2,"NEW S.W.A.T. RAID", format["%1's S.W.A.T. teams are raiding ...", worldName]];
				waitUntil { if not(isNull(findDisplay 46)) then {true} else {uiSleep 0.5; false} };
				player addAction ["Trigger VEMFr Message",{(["RscDisplayVEMFrClient"] call BIS_fnc_rscLayer) cutRsc["RscDisplayVEMFrClient", "PLAIN", 0, true]},"",-1,false,true,"User2","alive player"];
			};
	};
