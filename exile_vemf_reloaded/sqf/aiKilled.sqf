/*
	Author: IT07

	Description:
	executed upon AI unit death

	Params:
	_this: ARRAY
	_this select 0: OBJECT - the killed AI
	_this select 1: OBJECT - killer

	Returns:
	nothing
*/

(_this select 0) params [
	["_t", objNull, [objNull]],
	["_nt", "", [""]]
];
(_this select 1) params [
	["_k", objNull, [objNull]],
	["_nk", "", [""]]
];

if (isPlayer _k) then
	{
		scopeName "isPlayer";
		_rspct =
		{
			_arr = [[]];
			(_arr select 0) pushBack [(selectRandom ["AI WACKED","AI CLIPPED","AI WIPED","AI ERASED","AI LYNCHED","AI WRECKED","AI SNUFFED","AI WASTED","AI ZAPPED"]), _rw];
			_dist = _t distance _k;
			private "_ok";
			if (_dist < 2500) then
			{
				scopeName "below2500";
				if (_dist <= 5) then
				{
					(_arr select 0) pushBack ["CQB Master", 25];
					_ok = true;
					_ok breakOut "below2500";
				};
				if (_dist <= 10) then
				{
					(_arr select 0) pushBack ["Close one", 15];
					_ok = true;
					_ok breakOut "below2500";
				};
				if (_dist <= 50) then
				{
					(_arr select 0) pushBack ["Danger close", 15];
					_ok = true;
					_ok breakOut "below2500";
				};
				if (_dist <= 100) then
				{
					(_arr select 0) pushBack ["Lethal aim", 20];
					_ok = true;
					_ok breakOut "below2500";
				};
				if (_dist <= 200) then
				{
					(_arr select 0) pushBack ["Deadly.", 25];
					_ok = true;
					_ok breakOut "below2500";
				};
				if (_dist <= 500) then
				{
					(_arr select 0) pushBack ["Niiiiice.", 30];
					_ok = true;
					_ok breakOut "below2500";
				};
				if (_dist <= 1000) then
				{
					(_arr select 0) pushBack ["Dat distance...", 45];
					_ok = true;
					_ok breakOut "below2500";
				};
				if (_dist <= 2000) then
				{
					(_arr select 0) pushBack ["Danger far.", 50];
					_ok = true;
					_ok breakOut "below2500";
				};
				if (_dist > 2000) then
				{
					(_arr select 0) pushBack [format["hax? %1m!!!", round _dist], 65];
					_ok = true;
					_ok breakOut "below2500";
				};
			};

			if _ok then
			{
				[_k, "showFragRequest", _arr] call ExileServer_system_network_send_to;
				_rspct = (_k getVariable ["ExileScore", 0]) + (((_arr select 0) select 1) select 1) + _rw;
				_k setVariable ["ExileScore", _rspct];
				ExileClientPlayerScore = _rspct;
				(owner _k) publicVariableClient "ExileClientPlayerScore";
				ExileClientPlayerScore = nil;

				_kllCnt = (_k getVariable ["ExileKills",0]) + 1;
				_k setVariable ["ExileKills", _kllCnt];
				ExileClientPlayerKills = _kllCnt;
				(owner _k) publicVariableClient "ExileClientPlayerKills";
				ExileClientPlayerKills = nil;

				format["addAccountKill:%1", getPlayerUID _k] call ExileServer_system_database_query_fireAndForget;
				format['setAccountScore:%1:%2', _rspct, getPlayerUID _k] call ExileServer_system_database_query_fireAndForget;
			} else
			{
				["handleKillMessage", 0, format["There is something wrong with the kill distance (%1)", _dist]] ExecVM "exile_vemf_reloaded\sqf\log.sqf";
				breakOut "isPlayer";
			};
		};

		_rw = "respectReward" call VEMFr_fnc_config;

		if (_k isKindOf "Man") then // Roadkill or regular kill
			{
				if (vehicle _k isEqualTo _k) then // If on foot
					{
						if (vehicle _t isEqualTo _t) then
							{
								if (_rw > 0) then { call _rspct };
								[[_t, _nt],[_k, _nk]] ExecVM "exile_vemf_reloaded\sqf\sayKilledWeapon.sqf";
							} else
							{
								if (typeOf (vehicle _t) isEqualTo "Steerable_Parachute_F") then
									{
										if ("logCowardKills" call VEMFr_fnc_config isEqualTo 1) then
											{
												["fn_aiKilled", 1, format["A coward (%1 @ %2) killed a parachuting AI", _nk, mapGridPosition _k]] ExecVM "exile_vemf_reloaded\sqf\log.sqf";
											};
									} else
									{
										if (_rw > 0) then { call _rspct };
										[[_t, _nt],[_k, _nk]] ExecVM "exile_vemf_reloaded\sqf\sayKilledWeapon.sqf";
									};
							};
					} else // If in vehicle (a.k.a. roadkill)
					{
						if (("punishRoadKills" call VEMFr_fnc_config) isEqualTo 1) then
							{
								_pnsh = "respectRoadKillDeduct" call VEMFr_fnc_config;
								_crRspct = _k getVariable ["ExileScore", 0];
								//diag_log text format["_crRspct of _k (%1) is %2", _k, _crRspct];
								_nwRspct = _crRspct - _pnsh;
								_k setVariable ["ExileScore", _nwRspct];
								ExileClientPlayerScore = _nwRspct;
								(owner _k) publicVariableClient "ExileClientPlayerScore";
								ExileClientPlayerScore = nil;
								[_k, "showFragRequest", [[["ROADKILL..."],["Respect Penalty:", -_pnsh]]]] call ExileServer_system_network_send_to;
								format["setAccountMoneyAndRespect:%1:%2:%3", _k getVariable ["ExileMoney", 0], _nwRspct, (getPlayerUID _k)] call ExileServer_system_database_query_fireAndForget;

								if (("sayKilled" call VEMFr_fnc_config) isEqualTo 1) then
									{
										[format["(VEMFr) %1 [Roadkill] %2", _nk, if (("sayKilledName" call VEMFr_fnc_config) > 0) then {_nt} else {"AI"}]] ExecVM "exile_vemf_reloaded\sqf\systemChatToClient.sqf";
									};
							};
					};
			} else // If kill from vehicle (NOT a roadkill)
			{
				if (typeOf (vehicle _t) isEqualTo "Steerable_Parachute_F") then
					{
						if ("logCowardKills" call VEMFr_fnc_config isEqualTo 1) then
							{
								["fn_aiKilled", 1, format["A coward (%1 @ %2) killed a parachuting AI", _nk, mapGridPosition _k]] ExecVM "exile_vemf_reloaded\sqf\log.sqf";
							};
					} else
					{
						_k = effectiveCommander _k;
						if (_rw > 0) then { call _rspct };
						[[_t, _nt],[_k, _nk]] ExecVM "exile_vemf_reloaded\sqf\sayKilledWeapon.sqf";
					};
			};
	};

	([["aiCleanup"],["removeLaunchers","aiDeathRemovalEffect","removeHeadGear"]] call VEMFr_fnc_config) params ["_ms0","_ms1","_ms2"];
	if (_ms0 isEqualTo 1) then
		{
			_sw = secondaryWeapon _t;
			if not(_sw isEqualTo "") then
				{
					_t removeWeaponGlobal _sw;
					_mssls = getArray (configFile >> "cfgWeapons" >> _sw >> "magazines");
					{
						if (_x in _mssls) then
							{
								_t removeMagazineGlobal _x;
							};
					} forEach (magazines _t);
				};
		};
	if (_ms2 isEqualTo 1) then // If removeHeadGear setting is enabled
		{
			removeHeadGear _t;
		};

	if (_ms1 isEqualTo 1) then // If killEffect enabled
		{
			playSound3D ["A3\Missions_F_Bootcamp\data\sounds\vr_shutdown.wss", _t, false, getPosASL _t, 2, 1, 60];
			for "_u" from 1 to 12 do
			{
				if not(isObjectHidden _t) then
				{
					_t hideObjectGlobal true;
				} else
				{
					_t hideObjectGlobal false;
				};
				uiSleep 0.12;
			};
			_t hideObjectGlobal true;
			removeAllWeapons _t;
			// Automatic cleanup yaaay
			deleteVehicle _t;
		};

		_t removeAllEventHandlers "MPKilled";
