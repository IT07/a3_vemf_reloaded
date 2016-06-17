/*
	Author: original by Vampire, completely rewritten by IT07

	Description:
	spawns VEMFr AI using given _pos and unit/group count. Handles their inventory and transfers them to a client

	Params:
	_this select 0: POSITION - where to spawn the units around
	_this select 1: SCALAR - how many groups to spawn
	_this select 2: SCALAR - how many units to put in each group
	_this select 3: SCALAR - AI mode
	_this select 4: STRING - exact config name of mission
	_this select 5: SCALAR - (optional) altitude to create units at
	_this select 6: SCALAR - (optional) spawn radius

	Returns:
	ARRAY with group(s)
*/

private ["_spawned","_allUnits","_pos","_grpCount","_unitsPerGrp","_mode","_missionName"];
_spawned = [];
_allUnits = [];
params [["_pos",[],[[]]], ["_grpCount",1,[0]], ["_unitsPerGrp",1,[0]], ["_mode",-1,[0]], ["_missionName","",[""]], ["_altitude",0,[0]], ["_spawnRadius",20,[0]]];
if ((_pos isEqualTypeArray [0,0,0]) AND (_grpCount > 0) AND (_unitsPerGrp > 0) AND ((_missionName in ("missionList" call VEMFr_fnc_getSetting)) OR (_missionName isEqualTo "Static"))) then
	{
		scopeName "outer";
		_pos = [_pos select 0, _pos select 1, _altitude];
		private [
			"_sldrClass","_hc","_aiDifficulty","_skills","_accuracy","_aimShake","_aimSpeed","_stamina","_spotDist","_spotTime","_courage","_reloadSpd","_commanding","_general","_units"
		];
		_sldrClass = "unitClass" call VEMFr_fnc_getSetting;
		_hc = "headLessClientSupport" call VEMFr_fnc_getSetting;
		_aiDifficulty = [["aiSkill"],["difficulty"]] call VEMFr_fnc_getSetting param [0, "Veteran", [""]];
		_skills = [["aiSkill", _aiDifficulty],["accuracy","aimingShake","aimingSpeed","endurance","spotDistance","spotTime","courage","reloadSpeed","commanding","general"]] call VEMFr_fnc_getSetting;
		_skills params ["_accuracy","_aimShake","_aimSpeed","_stamina","_spotDist","_spotTime","_courage","_reloadSpd","_commanding","_general"];
		_units = []; // Define units array. the for loops below will fill it with units
		for "_g" from 1 to _grpCount do // Spawn Groups near Position
			{
				private ["_groupSide"];
				_groupSide = ("unitClass" call VEMFr_fnc_getSetting) call VEMFr_fnc_checkSide;
				if not isNil "_groupSide" then
					{
						private["_grp"];
						_grp = createGroup _groupSide;
						_grp allowFleeing 0;
						for "_u" from 1 to _unitsPerGrp do
							{
								private ["_unit"];
								_unit = _grp createUnit [_sldrClass, _pos, [], _spawnRadius, "FORM"]; // Create Unit There
								_allUnits pushBack _unit;
								_unit addMPEventHandler ["mpkilled","if (isDedicated) then { [_this select 0, _this select 1] ExecVM 'exile_vemf_reloaded\sqf\aiKilled.sqf' }"];
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

								_unit enableAI "TARGET";
								_unit enableAI "AUTOTARGET";
								_unit enableAI "MOVE";
								_unit enableAI "ANIM";
								_unit enableAI "TEAMSWITCH";
								_unit enableAI "FSM";
								_unit enableAI "AIMINGERROR";
								_unit enableAI "SUPPRESSION";
								_unit enableAI "CHECKVISIBLE";
								_unit enableAI "COVER";
								_unit enableAI "AUTOCOMBAT";
								_unit enableAI "PATH";
							};
							_spawned pushBack _grp;
					} else
					{
						["fn_spawnVEMFrAI", 0, "failed to retrieve _groupSide"] ExecVM "exile_vemf_reloaded\sqf\log.sqf";
						breakOut "outer";
					};
			};

			private ["_invLoaded"];
			_invLoaded = [_allUnits, _missionName, _mode] call VEMFr_fnc_loadInv; // Load the AI's inventory
			if not _invLoaded then
				{
					_spawned = false;
					["fn_spawnVEMFrAI", 0, "failed to load AI's inventory..."] ExecVM "exile_vemf_reloaded\sqf\log.sqf";
					breakOut "outer";
				};
	} else
	{
		["spawnVEMFrAI", 0, format["params are not valid! [%1,%2,%3,%4]", (_pos isEqualTypeArray [0,0,0]), (_grpCount > 0), (_unitsPerGrp > 0), (_missionName in ("missionList" call VEMFr_fnc_getSetting) OR _missionName isEqualTo "Static")]] ExecVM "exile_vemf_reloaded\sqf\log.sqf";
	};

_spawned
