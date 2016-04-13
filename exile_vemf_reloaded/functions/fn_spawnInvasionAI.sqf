/*
	Author: original by Vampire, completely rewritten by IT07

	Description:
	spawns AI using given _pos and unit/group count.

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

private ["_spawned","_pos"];
_spawned = [[],[]];
_pos = param [0, [], [[]]];
if (count _pos isEqualTo 3) then
{
	private ["_grpCount"];
	_grpCount = param [1, 1, [0]];
	if (_grpCount > 0) then
	{
		private ["_unitsPerGrp"];
		_unitsPerGrp = param [2, 1, [0]];
		if (_unitsPerGrp > 0) then
		{
			private ["_mode","_missionName"];
			_mode = param [3, -1, [0]];
			_missionName = param [4, "", [""]];
			if (_missionName in ("missionList" call VEMFr_fnc_getSetting)) then
			{
				private [
					"_maxRange","_sldrClass","_groups","_hc","_aiDifficulty","_skills","_accuracy","_aimShake","_aimSpeed","_stamina","_spotDist","_spotTime",
					"_courage","_reloadSpd","_commanding","_general","_houses","_notTheseHouses","_goodHouses","_noHouses","_cal50s","_units"
				];
				_maxRange = param [5, 175, [0]];
				_sldrClass = "unitClass" call VEMFr_fnc_getSetting;
				_groups = [];
				_hc = "headLessClientSupport" call VEMFr_fnc_getSetting;
				_aiDifficulty = [["aiSkill"],["difficulty"]] call VEMFr_fnc_getSetting param [0, "Veteran", [""]];
				_skills = [["aiSkill", _aiDifficulty],["accuracy","aimingShake","aimingSpeed","endurance","spotDistance","spotTime","courage","reloadSpeed","commanding","general"]] call VEMFr_fnc_getSetting;
				_accuracy = _skills select 0;
				_aimShake = _skills select 1;
				_aimSpeed = _skills select 2;
				_stamina = _skills select 3;
				_spotDist = _skills select 4;
				_spotTime = _skills select 5;
				_courage = _skills select 6;
				_reloadSpd = _skills select 7;
				_commanding = _skills select 8;
				_general = _skills select 9;

				_houses = nearestTerrainObjects [_pos, ["House"], _maxRange]; // Find some houses to spawn in
				_notTheseHouses = "housesBlackList" call VEMFr_fnc_getSetting;
				_goodHouses = [];
				{ // Filter the houses that are too small for one group
					if not(typeOf _x in _notTheseHouses) then
					{
						if ([_x, _unitsPerGrp] call BIS_fnc_isBuildingEnterable) then
						{
							_goodHouses pushBack _x;
						};
					};
				} forEach _houses;
				_goodHouses = _goodHouses call BIS_fnc_arrayShuffle;
				_noHouses = false;
				if (count _goodHouses < _grpCount) then
				{
					_noHouses = true;
				};

				_cal50s = [["DynamicLocationInvasion"],["cal50s"]] call VEMFr_fnc_getSetting param [0, 3, [0]];
				if (_cal50s > 0) then
				{
					_cal50sVehs = [];
				};
				_units = []; // Define units array. the for loops below will fill it with units
				for "_g" from 1 to _grpCount do // Spawn Groups near Position
				{
					if not _noHouses then
					{
						if (count _goodHouses < 1) then
						{
							_noHouses = true
						};
					};
					private ["_groupSide"];
					_groupSide = ("unitClass" call VEMFr_fnc_getSetting) call VEMFr_fnc_checkSide;
					if not isNil"_groupSide" then
					{
						private ["_grp"];
						_grp = createGroup _groupSide;
						(_spawned select 0) pushBack _grp;
						if not _noHouses then
						{
							_grp enableAttack false;
						};
						_grp setBehaviour "AWARE";
						_grp setCombatMode "RED";
						_grp allowFleeing 0;
						private ["_house","_housePositions"];
						if not _noHouses then
						{
							_house = selectRandom _goodHouses;
							_houseID = _goodHouses find _house;
							_goodHouses deleteAt _houseID;
							_housePositions = [_house] call BIS_fnc_buildingPositions;
						};

						private ["_placed50"];
						_placed50 = false;
						for "_u" from 1 to _unitsPerGrp do
						{
							private ["_spawnPos","_hmg"];
							if _noHouses then
							{
								_spawnPos = [_pos,20,_maxRange,1,0,200,0] call BIS_fnc_findSafePos; // Find Nearby Position
							} else
							{
								_spawnPos = selectRandom _housePositions;
								if not _placed50 then
								{
									_placed50 = true;
									if (_cal50s > 0) then
									{
										_hmg = createVehicle ["B_HMG_01_high_F", _spawnPos, [], 0, "CAN_COLLIDE"];
										_hmg setVehicleLock "LOCKEDPLAYER";
										(_spawned select 1) pushBack _hmg;
									};
								};
							};

							private ["_unit"];
							_unit = _grp createUnit [_sldrClass, _spawnPos, [], 0, "CAN_COLLIDE"]; // Create Unit There
							if not _noHouses then
							{
								doStop _unit;
								if (_cal50s > 0) then
								{
									if not isNil"_hmg" then
									{
										if not isNull _hmg then
										{
											_unit moveInGunner _hmg;
											_hmg = nil;
											_cal50s = _cal50s - 1;
										};
									};
								};

								private ["_houseIndex"];
								_houseIndex = _housePositions find _spawnPos;
								_housePositions deleteAt _houseIndex;
							};

							_unit addMPEventHandler ["mpkilled","if (isDedicated) then { [_this select 0, _this select 1] spawn VEMFr_fnc_aiKilled }"];
							// Set skills
							_unit setSkill ["aimingAccuracy", _accuracy];
							_unit setSkill ["aimingShake", _aimShake];
							_unit setSkill ["aimingSpeed", _aimSpeed];
							_unit setSkill ["endurance", _stamina];
							_unit setSkill ["spotDistance", _spotDist];
							_unit setSkill ["spotTime", _spotTime];
							_unit setSkill ["courage", _courage];
							_unit setSkill ["reloadSpeed", _reloadSpd];
							_unit setSkill ["commanding", _commanding];
							_unit setSkill ["general", _general];
							_unit setRank "Private"; // Set rank
							if (_u isEqualTo _unitsPerGrp) then
							{
								_grp selectLeader _unit; // Leader Assignment
							};
						};
						private ["_invLoaded"];
						_invLoaded = [units _grp, _missionName, _mode] call VEMFr_fnc_loadInv; // Load the AI's inventory
						if not _invLoaded then
						{
							["fn_spawnInvasionAI", 0, "failed to load AI's inventory..."] spawn VEMFr_fnc_log;
						};
						_groups pushBack _grp; // Push it into the _groups array
					};
				};

				if (count _groups isEqualTo _grpCount) then
				{
					if _noHouses then
					{
						private ["_waypoints"];
						_waypoints =
						[
							[(_pos select 0), (_pos select 1)+50, 0],
							[(_pos select 0)+50, (_pos select 1), 0],
							[(_pos select 0), (_pos select 1)-50, 0],
							[(_pos select 0)-50, (_pos select 1), 0]
						];
						{ // Make them Patrol
							for "_z" from 1 to (count _waypoints) do
							{
								private ["_wp"];
								_wp = _x addWaypoint [(_waypoints select (_z-1)), 10];
								_wp setWaypointType "SAD";
								_wp setWaypointCompletionRadius 20;
							};
							private ["_cyc"];
							_cyc = _x addWaypoint [_pos,10];
							_cyc setWaypointType "CYCLE";
							_cyc setWaypointCompletionRadius 20;
						} forEach _groups;
					};
				};
			};
		};
	};
};

_spawned
