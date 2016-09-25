if hasInterface then
	{
		uiNamespace setVariable [ "VEMFrMsgQueue", [] ];
		uiNamespace setVariable [ "RscDisplayVEMFrClient", displayNull ];
		uiNamespace setVariable [ "RscDisplayBaseAttack", displayNull ];

		if isMultiplayer then
			{
				_handleMessage =
					{
						_data = _this;
						params [ "_msg", "_mode" ];
						if ( _mode isEqualTo "sys" ) then { systemChat _msg };
						if ( _mode isEqualTo "" ) then
							{
								( uiNamespace getVariable [ "VEMFrMsgQueue", [] ] ) pushBack _msg;
								if ( isNull ( uiNamespace getVariable [ "RscDisplayVEMFrClient", displayNull ] ) ) then
									{
										( [ "RscDisplayVEMFrClient" ] call BIS_fnc_rscLayer ) cutRsc [ "RscDisplayVEMFrClient", "PLAIN", 0, true ]
									};
							};
						if ( _mode isEqualTo "ba" ) then
							{
								disableSerialization;
								_dsp = uiNamespace getVariable [ "RscDisplayBaseAttack", displayNull ];
								if ( ( _msg isEqualTo "a" ) AND ( isNull _dsp ) ) then
									{
										( [ "RscDisplayBaseAttack" ] call BIS_fnc_rscLayer ) cutRsc [ "RscDisplayBaseAttack", "PLAIN", 0, true ];
									};
								if ( ( _msg isEqualTo "d" ) AND not ( isNull _dsp ) ) then
									{
										_dsp setVariable [ "doFlash", false ];
										waitUntil { if ( _dsp getVariable [ "doingFlash", false ] ) then { uiSleep 0.5; false } else { true } };
										_ctrl = _dsp displayCtrl 1;
										_oldTxt = ctrlText _ctrl;
										for "_i" from ( count ( ctrlText _ctrl ) ) to 0 step -1 do
											{
												_ctrl ctrlSetText ( _oldTxt select [ 0, _i ] );
												uiSleep 0.035;
											};
										_ctrl ctrlSetTextColor [ 0.333, 1, 0.557, 1 ];
										_nwTxt = "// [ Attack on Base ended ] \\";
										for "_i" from 0 to ( count _nwTxt ) do
											{
												_ctrl ctrlSetText ( _nwTxt select [ 0, _i ] );
												uiSleep 0.035;
											};
										_dsp setVariable [ "doFlash", true ];
										uiSleep 12.5;
										( [ "RscDisplayBaseAttack" ] call BIS_fnc_rscLayer ) cutFadeOut 0.5;
									};
							};
					};

				while { true } do
					{
						if not ( isNil "VEMFrMsgToClient" ) then
							{
								VEMFrMsgToClient spawn _handleMessage;
								VEMFrMsgToClient = nil;
							} else { uiSleep 0.05 };
					};
			} else
			{
				_arr = uiNamespace getVariable [ "VEMFrMsgQueue", [] ];
				_arr pushBack [ 0, "NEW TAKEOVER", "Raiders have taken over ..." ];
				_arr pushBack [ 1, "NEW POLICE RAID", format [ "%1 Police forces are raiding ...", worldName ] ];
				_arr pushBack [ 2, "NEW S.W.A.T. RAID", format [ "%1's S.W.A.T. teams are raiding ...", worldName ] ];
				waitUntil { if not ( isNull ( findDisplay 46 ) ) then { true } else { uiSleep 0.5; false } };
				player addAction [ "Trigger VEMFr Message", { ( [ "RscDisplayVEMFrClient" ] call BIS_fnc_rscLayer ) cutRsc [ "RscDisplayVEMFrClient", "PLAIN", 0, true ] }, "", -1, false, true, "User2", "alive player" ];
				player addAction [ "Trigger BaseAttack", { ( [ "RscDisplayBaseAttack" ] call BIS_fnc_rscLayer ) cutRsc [ "RscDisplayBaseAttack", "PLAIN", 0, true ] }, "", -1, false, true, "", "alive player" ];
			};
	};
