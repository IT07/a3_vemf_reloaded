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
		if (_k isKindOf "Man") then // Roadkill or regular kill
			{
				if (vehicle _k isEqualTo _k) then // If on foot
					{
						if (vehicle _t isEqualTo _t) then
							{
								if (("respectReward" call VEMFr_fnc_config) > 0) then
								   {
										[_t, _k] ExecVM "exile_vemf_reloaded\sqf\respect.sqf";
									};
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
										if (("respectReward" call VEMFr_fnc_config) > 0) then
										   {
												[_t, _k] ExecVM "exile_vemf_reloaded\sqf\respect.sqf";
											};
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
						if (("respectReward" call VEMFr_fnc_config) > 0) then
							{
								[_t, _k] ExecVM "exile_vemf_reloaded\sqf\respect.sqf";
							};
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
