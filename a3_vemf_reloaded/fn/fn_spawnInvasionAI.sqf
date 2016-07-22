/*
	Author: IT07

	Description:
	spawns AI using given _this0 and unit/group count.

	Params:
	_this select 0: POSITION - where to spawn the units around
	_this select 1: SCALAR - how many groups to spawn
	_this select 2: SCALAR - how many units to put in each group
	_this select 3: SCALAR - AI mode
	_this select 4: STRING - exact config name of mission
	_this select 5: SCALAR (optional) - maximum spawn distance from center

	Returns:
	ARRAY format [[groups],[50cals]]
*/

private ["_r","_this0","_this1","_this2","_this3","_this4","_this5"];
params [
	["_this0", [], [[]]],
	["_this1", 1, [0]],
	["_this2", 1, [0]],
	["_this3", -1, [0]],
	["_this4", "", [""]],
	["_this5", 175, [0]]
];

if (_this4 in ("missionList" call VEMFr_fnc_config)) then
	{
		private [
			"_grps","_s","_ccrcy","_mShk","_mSpd","_stmna","_sptDst","_sptTme",
			"_crge","_rldSpd","_cmmndng","_gnrl","_gdHss","_nHss","_cl50s","_nts"
		];
		_r = [[],[]];
		_grps = [];
		_s = [["aiSkill",(([["aiSkill"],["difficulty"]] call VEMFr_fnc_config) select 0)],["accuracy","aimingShake","aimingSpeed","endurance","spotDistance","spotTime","courage","reloadSpeed","commanding","general"]] call VEMFr_fnc_config;
		_s params ["_ccrcy","_mShk","_mSpd","_stmna","_sptDst","_sptTme","_crge","_rldSpd","_cmmndng","_gnrl"];
		_bad = ([["blacklists","buildings"],["classes"]] call VEMFr_fnc_config) select 0;
		_gdHss = [];
		{ // Filter the houses that are too small for one group
			if not(typeOf _x in _bad) then
				{
					if ([_x, _this2] call BIS_fnc_isBuildingEnterable) then
						{
							_gdHss pushBack _x;
						};
				};
		} forEach (nearestTerrainObjects [_this0,["House"],_this5]);

		_gdHss = _gdHss call BIS_fnc_arrayShuffle;
		_nHss = false;
		if (count _gdHss < _this1) then
			{
				_nHss = true;
			};

		_cl50s = ([["missionSettings",(_this4)],["cal50s"]] call VEMFr_fnc_config) select 0;

		_nts = []; // Define units array. the for loops below will fill it with units
		for "_g" from 1 to _this1 do // Spawn Groups near Position
			{
				if not _nHss then
					{
						if (count _gdHss < 1) then
							{
								_nHss = true
							};
					};

				private ["_grp","_hs","_hsPstns","_plcd50","_i"];
				_grp = createGroup ((([[call VEMFr_fnc_whichMod],["unitClass"]] call VEMFr_fnc_config) select 0) call VEMFr_fnc_checkSide);
				(_r select 0) pushBack _grp;
				_grp allowFleeing 0;
				if not _nHss then
					{
						_hs = selectRandom _gdHss;
						_hsID = _gdHss find _hs;
						_gdHss deleteAt _hsID;
						_hsPstns = [_hs] call BIS_fnc_buildingPositions;
					};

				_plcd50 = false;
				for "_u" from 1 to _this2 do
					{
						private ["_spwnPs","_hmg","_nt"];
						if _nHss then
							{
								_spwnPs = [_this0,20,_this5,1,0,200,0] call BIS_fnc_findSafePos; // Find Nearby Position
							} else
							{
								_spwnPs = selectRandom _hsPstns;
								if not _plcd50 then
									{
										_plcd50 = true;
										if (_cl50s > 0) then
											{
												_hmg = createVehicle ["O_HMG_01_high_F", _spwnPs, [], 0, "CAN_COLLIDE"];
												_hmg setVehicleLock "LOCKEDPLAYER";
												(_r select 1) pushBack _hmg;
											};
									};
							};

						_nt = _grp createUnit [([[call VEMFr_fnc_whichMod],["unitClass"]] call VEMFr_fnc_config) select 0, _spwnPs, [], 0, "CAN_COLLIDE"]; // Create Unit There
						if ((not _nHss) AND (_cl50s > 0)) then
							{
								if not(isNil "_hmg") then
									{
										if not(isNull _hmg) then
											{
												_nt moveInGunner _hmg;
												_hmg = nil;
												_cl50s = _cl50s - 1;
											};
									};
								_hsPstns deleteAt (_hsPstns find _spwnPs);
							};

						_nt addMPEventHandler ["mpkilled","if (isDedicated) then { [[(_this select 0),(name(_this select 0))],[(_this select 1),(name(_this select 1))]] ExecVM ('aiKilled' call VEMFr_fnc_scriptPath) }"];

						// Set skills
						_nt setSkill ["aimingAccuracy", _ccrcy];
						_nt setSkill ["aimingShake", _mShk];
						_nt setSkill ["aimingSpeed", _mSpd];
						_nt setSkill ["endurance", _stmna];
						_nt setSkill ["spotDistance", _sptDst];
						_nt setSkill ["spotTime", _sptTme];
						_nt setSkill ["courage", _crge];
						_nt setSkill ["reloadSpeed", _rldSpd];
						_nt setSkill ["commanding", _cmmndng];
						_nt setSkill ["general", _gnrl];

						_nt enableAI "TARGET";
						_nt enableAI "AUTOTARGET";
						_nt enableAI "MOVE";
						_nt enableAI "ANIM";
						_nt enableAI "TEAMSWITCH";
						_nt enableAI "FSM";
						_nt enableAI "AIMINGERROR";
						_nt enableAI "SUPPRESSION";
						_nt enableAI "CHECKVISIBLE";
						_nt enableAI "COVER";
						_nt enableAI "AUTOCOMBAT";
						_nt enableAI "PATH";
					};

				_i = [units _grp, _this4, _this3] call VEMFr_fnc_loadInv; // Load the AI's inventory
				if isNil "_i" then
					{
						["fn_spawnInvasionAI", 0, "failed to load AI's inventory..."] ExecVM ("log" call VEMFr_fnc_scriptPath);
					};
				_grps pushBack _grp; // Push it into the _grps array
			};

		if (((count _grps) isEqualTo _this1) AND _nHss) then
			{
				private ["_wypnts","_wp","_cyc"];
				_wypnts =
					[
						[(_this0 select 0), (_this0 select 1)+50, 0],
						[(_this0 select 0)+50, (_this0 select 1), 0],
						[(_this0 select 0), (_this0 select 1)-50, 0],
						[(_this0 select 0)-50, (_this0 select 1), 0]
					];
				{ // Make them Patrol
					for "_z" from 1 to (count _wypnts) do
						{
							_wp = _x addWaypoint [(_wypnts select (_z-1)), 10];
							_wp setWaypointType "SAD";
							_wp setWaypointCompletionRadius 20;
						};
					_cyc = _x addWaypoint [_this0,10];
					_cyc setWaypointType "CYCLE";
					_cyc setWaypointCompletionRadius 20;
				} forEach _grps;
			};
	} else
	{
		["fn_spawnInvasionAI",0,format["'%1' is not in missionList", _this4]] ExecVM ("log" call VEMFr_fnc_scriptPath);
	};

_r
