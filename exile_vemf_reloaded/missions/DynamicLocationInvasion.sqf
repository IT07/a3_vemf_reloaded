/*
	DynamicLocationInvasion by IT07
*/

VEMFrMissionCount = VEMFrMissionCount + 1;
if isNil "VEMFrInvasionCount" then { VEMFrInvasionCount = 0; };
VEMFrInvasionCount = VEMFrInvasionCount + 1;
_this0 = param [0, "", [""]];
if (VEMFrInvasionCount <= (([[_this0],["maxInvasions"]] call VEMFr_fnc_config) select 0)) then
{
	scopeName "outer";
	// Define the settings
	_ms = [
		[_this0],
		["groupCount","groupUnits","maxDistancePrefered","skipDistance","useMarker","markCrateVisual","markCrateOnMap","announce","streetLights","streetLightsRestore","streetLightsRange","allowCrateLift","allowRepeat","randomModes","spawnCrateFirst","mines","flairTypes","smokeTypes","minesCleanup","skipDistanceReversed"]
	] call VEMFr_fnc_config;
	_ms params [
		"_ms0","_ms1","_ms2","_ms3","_ms4","_ms5","_ms6","_ms7","_ms8","_ms9","_ms10","_ms11","_ms12","_ms13","_ms14","_ms15","_ms16","_ms17","_ms18","_ms19"
	];

	([[_this0,"crateParachute"],["enabled","altitude"]] call VEMFr_fnc_config) params ["_cp0","_cp1"];

	_l = ["loc", false, position (selectRandom allPlayers), if (_ms19 > 0) then {_ms19} else {_ms3}, _ms2, if (_ms19 > 0) then {_ms19} else {_ms3}, _this0] call VEMFr_fnc_findPos;
	if not(isNil "_l") then
	{
		_ln = text _l;
		_lp = position _l;
		if (_ln isEqualTo "") then { _ln = "Area"; };
		[_this0, 1, format["Invading %1...", _ln]] ExecVM "exile_vemf_reloaded\sqf\log.sqf";

		_m = "aiMode" call VEMFr_fnc_config;
		if (_ms13 isEqualTo 1) then { _m = selectRandom [0,1,2] };
		if (_ms7 isEqualTo 1) then
		{
			if (_m isEqualTo 0) then
			{
				[_m, "NEW INVASION", format["Raiders have invaded %1 @ %2", _ln, mapGridPosition _lp]] ExecVM "exile_vemf_reloaded\sqf\notificationToClient.sqf";
			};
			if (_m isEqualTo 1) then
			{
				[_m, "NEW POLICE RAID", format["%1 Police forces are now controlling %2 @ %3", worldName, _ln, mapGridPosition _lp]] ExecVM "exile_vemf_reloaded\sqf\notificationToClient.sqf";
			};
			if (_m isEqualTo 2) then
			{
				[_m, "NEW S.W.A.T. RAID", format["%1 S.W.A.T. teams are now raiding %2 @ %3", worldName, _ln, mapGridPosition _lp]] ExecVM "exile_vemf_reloaded\sqf\notificationToClient.sqf";
			};
		};

		private "_mrkr";
		if (_ms4 isEqualTo 1) then
		{ // Create/place the marker if enabled
			_mrkr = createMarker [format["VEMFr_DynaLocInva_ID%1", random 9000], _lp];
			_mrkr setMarkerShape "ICON";
			_mrkr setMarkerType "o_unknown";
			if (_m < 0 OR _m > 2) then
			{
				["DynamicLocationInvasion", 0, format["Invalid aiMode (%1) detected, failed to setMarkerColor!", _aiMode]] ExecVM "exile_vemf_reloaded\sqf\log.sqf";
				breakOut "outer";
			};
			if (_m isEqualTo 0) then
			{
				_mrkr setMarkerColor "ColorEAST";
			};
			if (_m isEqualTo 1) then
			{
				_mrkr setMarkerColor "ColorWEST";
			};
			if (_m isEqualTo 2) then
			{
				_mrkr setMarkerColor "ColorBlack";
			};
		};

		// If enabled, kill all the lights
		if (_ms8 isEqualTo 0) then
		{
			{
				if (damage _x < 0.95) then
				{
					_x setDamage 0.95;
					uiSleep 0.1;
				};
			} forEach (nearestObjects [_lp, ["Lamps_Base_F","PowerLines_base_F","Land_PowerPoleWooden_L_F"], _ms10]);
		};

		private "_crate";
		_dSpwnCrt = {
			// Choose a box
			_bx = selectRandom (([[_this0],["crateTypes"]] call VEMFr_fnc_config) select 0);
			_ps = [_lp, 0, 200, 0, 0, 300, 0] call bis_fnc_findSafePos;
			if (_cp0 > 0) then
			{
				_cht = createVehicle ["I_Parachute_02_F", _ps, [], 0, "FLY"];
				_cht setPos [getPos _cht select 0, getPos _cht select 1, _cp1];
				_cht enableSimulationGlobal true;

				if not(isNull _cht) then
				{
					_crate = createVehicle [_bx, getPos _cht, [], 0, "NONE"];
					_crate allowDamage false;
					_crate enableSimulationGlobal true;
					_crate attachTo [_cht, [0,0,0]];
					[_this0, 1, format ["Crate parachuted at: %1 / Grid: %2", (getPosATL _crate), mapGridPosition (getPosATL _crate)]] ExecVM "exile_vemf_reloaded\sqf\log.sqf";
					[_crate, _ln, _lp] ExecVM "exile_vemf_reloaded\sqf\loadLoot.sqf";
					waitUntil { if (((getPos _crate) select 2) < 7) then {true} else {uiSleep 1; false} };
					detach _crate;
				} else
				{
					[_this0, 0, "Where is the chute??"] ExecVM "exile_vemf_reloaded\sqf\log.sqf";
				};
			} else
			{
				_crate = createVehicle [_bx, _ps, [], 0, "NONE"];
				_crate allowDamage false;
				[_crate, _ln, _lp] ExecVM "exile_vemf_reloaded\sqf\loadLoot.sqf";
			};

			if (_ms11 > 0) then
				{
					_crate enableRopeAttach false;
				} else
				{
					_crate enableRopeAttach true;
				};
		};

		if ([_lp, 800] call VEMFr_fnc_waitForPlayers) then
		{
			_spwnd = [_lp, ((_ms0 select 0) + round random ((_ms0 select 1) - (_ms0 select 0))), ((_ms1 select 0) + round random ((_ms1 select 1) - (_ms1 select 0))), _m, _this0, 200] call VEMFr_fnc_spawnInvasionAI;
			_nts = [];
			{
				[_x] ExecVM "exile_vemf_reloaded\sqf\signAI.sqf";
				{
					_nts pushBack _x;
				} forEach (units _x);
			} forEach (_spwnd select 0);

			_cl50s = _spwnd select 1;

			([[_this0,"heliPatrol"],["enabled","classes","locked"]] call VEMFr_fnc_config) params ["_hp0","_hp1","_hp2"];
			if (_hp0 > 0) then
				{
					[_this0, 1, format["Adding a heli patrol to the invasion of %1 at %2", _ln, mapGridPosition _lp]] ExecVM "exile_vemf_reloaded\sqf\log.sqf";
					_heli = createVehicle [(selectRandom _hp1), _lp, [], 5, "FLY"];
					_heli setPosATL [(getPos _heli) select 0, (getPos _heli) select 1, 750];
					_heli flyInHeight 80;
					if (_hp2 isEqualTo 1) then
						{
							_heli lock true;
						};

					_trrts = allTurrets [_heli, false];

					_hlGrp = ([_lp, 1, ((count _trrts) + (_heli emptyPositions "commander") + 1), _m, _this0] call VEMFr_fnc_spawnVEMFrAI) select 0;
					{
						if (((_heli emptyPositions "driver") isEqualTo 1) AND (_x isEqualTo (leader(group _x)))) then
							{
								_x moveInDriver _heli;
							} else
							{
								private "_path";
								{
									if (isNull (_heli turretUnit _x)) then
										{
											_path = _x;
										};
								} forEach _trrts;

								if not(isNil "_path") then
									{
										_x moveInTurret [_heli, _path];
									} else
									{
										if ((_heli emptyPositions "commander") > 0) then
											{
												_x moveInCommander _heli;
											};
									};
							};

						if not(backPack _x isEqualTo "") then
							{
								removeBackpack _x;
							};
						_x addBackpack "B_Parachute";
						_nts pushBack _x;
					} forEach (units _hlGrp);

					_wp = _hlGrp addWaypoint [[_lp select 0, _lp select 1, 50], 0, 2, "SAD"];
					_wp setWaypointType "SAD";
					_wp setWaypointSpeed "NORMAL";
					_wp setWaypointBehaviour "AWARE";
					_wp setWaypointCombatMode "RED";
					//_wp setWaypointLoiterType "CIRCLE";
					//_wp setWaypointLoiterRadius 200;
					_hlGrp setCurrentWaypoint _wp;

					[_hlGrp] ExecVM "exile_vemf_reloaded\sqf\signAI.sqf";
				};

			// Place the crate if enabled
			if (_ms14 isEqualTo 1) then
				{
					call _dSpwnCrt;
				};

			// Place mines if enabled
			private ["_mnsPlcd","_mines"];
			if (_ms15 > 0) then
				{
					_mnsPlcd = [_lp, 5, 100, _this0] call VEMFr_fnc_mines;
					if ((count _mnsPlcd) > 0) then
						{
							[_this0, 1, format["%1 mines placed at %2", count _mnsPlcd, _ln]] ExecVM "exile_vemf_reloaded\sqf\log.sqf";
						} else
						{
							[_this0, 0, format["Failed to place %1 mines at %2", count _mnsPlcd, _ln]] ExecVM "exile_vemf_reloaded\sqf\log.sqf";
						};
				};

			// Wait for Mission Completion
			_h = [_nts] ExecVM "exile_vemf_reloaded\sqf\killedMonitor.sqf";
			waitUntil { if (scriptDone _h) then {true} else {uiSleep 1; false} };

			["DynamicLocationInvasion", 1, format["mission in %1 has been completed!", _ln]] ExecVM "exile_vemf_reloaded\sqf\log.sqf";

			if (_ms12 isEqualTo 1) then
				{
					_u = uiNamespace getVariable "VEMFrUsedLocs";
					_u deleteAt (_u find _l);
				};

			// Broadcast
			if (_ms7 isEqualTo 1) then
				{
					if (_m isEqualTo 0) then
					{
						[_m ,"RAIDERS KILLED", format["%1 @ %2 is now clear of %3 raiders", _ln, mapGridPosition (_lp), worldName]] ExecVM "exile_vemf_reloaded\sqf\notificationToClient.sqf";
					};
					if (_m isEqualTo 1) then
					{
						[_m, "RAID ENDED", format["%1 @ %2 is now clear of %3 Police", _ln, mapGridPosition (_lp), worldName]] ExecVM "exile_vemf_reloaded\sqf\notificationToClient.sqf";
					};
					if (_m isEqualTo 2) then
					{
						[_m, "S.W.A.T. RAID ENDED", format["%1 @ %2 is now clear of %3 S.W.A.T. teams", _ln, mapGridPosition (_lp)]] ExecVM "exile_vemf_reloaded\sqf\notificationToClient.sqf";
					};
				};

			// Deal with the 50s
			if not(isNil "_cl50s") then
				{
					_d = ([[_this0],["cal50sDelete"]] call VEMFr_fnc_config) select 0;
					if (_d > 0) then
						{
							{
								if (_d isEqualTo 1) then { deleteVehicle _x };
								if (_d isEqualTo 2) then { _x setDamage 1 };
							} forEach _cl50s;
						};
				};

			if not(isNil "_mrkr") then
				{
					deleteMarker _mrkr
				};

			if ((([["DynamicLocationInvasion"],["spawnCrateFirst"]] call VEMFr_fnc_config) select 0) isEqualTo 0) then
				{
					call _dSpwnCrt;
				};

			// Put a marker on the crate if enabled
			if not(isNil "_crate") then
				{
					if not(isNull _crate) then
						{
							if not ([getPos _crate, 3] call VEMFr_fnc_playerNear) then
								{
									if (_ms5 isEqualTo 1) then
										{
											// If night, attach a chemlight
											if (sunOrMoon <= 0.35) then
												{
													[_this0, 1, "attaching a chemlight to the _crate"] ExecVM "exile_vemf_reloaded\sqf\log.sqf";
													_lightType = selectRandom _ms16;
													(_lightType createVehicle (position _crate)) attachTo [_crate,[0,0,0]];
												} else
												{
													[_this0, 1, "attaching smoke to the _crate"] ExecVM "exile_vemf_reloaded\sqf\log.sqf";
													// Attach smoke
													_rndmColor = selectRandom _ms17;
													(createVehicle [_rndmColor, getPos _crate, [], 0, "CAN_COLLIDE"]) attachTo [_crate,[0,0,0]];
												};
										};

									if (_ms6 isEqualTo 1) then
										{
											private "_mrkr";
											_mrkr = createMarker [format["VEMF_lootCrate_ID%1", random 9000], position _crate];
											_mrkr setMarkerShape "ICON";
											_mrkr setMarkerType "mil_box";
											_mrkr setMarkerColor "colorBlack";
											_mrkr setMarkerText " Loot";
											[_crate, _mrkr] spawn
												{
													_crate = _this select 0;
													_mrkr = _this select 1;
													waitUntil { if ([getPos _crate, 3] call VEMFr_fnc_playerNear) then {true} else {uiSleep 4; false} };
													deleteMarker _mrkr;
												};
										};
								};
						} else
						{
							[_this0, 0, "isNull _crate!"] ExecVM "exile_vemf_reloaded\sqf\log.sqf";
						};
				} else
				{
					[_this0, 0, "isNil _crate!"] ExecVM "exile_vemf_reloaded\sqf\log.sqf";
				};


			// Explode or remove the mines
			if not(isNil "_mnsPlcd") then
				{
					if (_ms18 isEqualTo 2) then
						{
							[_this0, _ln, _mnsPlcd] spawn
								{
									uiSleep (5 + (random 2));
									[(_this select 0), 1, format["Starting to explode all %1 mines at %2", count (_this select 2), (_this select 1)]] ExecVM "exile_vemf_reloaded\sqf\log.sqf";
									{
										if not(isNull _x) then
											{
												_x setDamage 1;
												uiSleep (1.25 + (random 3.5));
											};
									} forEach (_this select 2);
									[(_this select 0), 1, format["Successfully exploded all %1 mines at %2", count (_this select 2), (_this select  1)]] ExecVM "exile_vemf_reloaded\sqf\log.sqf";
								};

							_mnsPlcd = nil;
						};
					if (_ms18 isEqualTo 1) then
						{
							[_mnsPlcd] spawn
								{
									{
										if not(isNull _x) then { deleteVehicle _x };
									} forEach (_this select 0);
								};

							[_this0, 1, format["Successfully deleted all %1 mines at %2", count _mnsPlcd, _ln]] ExecVM "exile_vemf_reloaded\sqf\log.sqf";
						};
				};

			// If enabled, fix all the lights
			if (_ms9 isEqualTo 1) then
				{
					{
						if (damage _x > 0.94) then
						{
							_x setDamage 0;
							uiSleep (1 + (random 2));
						};
					} forEach (nearestObjects [_lp, ["Lamps_Base_F","PowerLines_base_F","Land_PowerPoleWooden_L_F"], _ms10]);
				};
		} else
		{ // If done waiting, and no players were detected
			[_this0, 1, format["Invasion of %1 @ %2 timed out.", _ln, mapGridPosition _lp]] ExecVM "exile_vemf_reloaded\sqf\log.sqf";
			if not(isNil "_mrkr") then { deleteMarker _mrkr };
			_arr = uiNamespace getVariable "VEMFrUsedLocs";
			_arr deleteAt (_arr find _l);
		};
	};
};

VEMFrInvasionCount = VEMFrInvasionCount - 1;
VEMFrMissionCount = VEMFrMissionCount - 1;
