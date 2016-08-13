/*
	Author: original by Vampire, completely rewritten by IT07

	Description:
	spawns VEMFr AI using given _this0 and unit/group count. Handles their inventory and transfers them to a client

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

private [("_r"),("_allUnits"),("_this0"),("_this1"),("_this2"),("_this3"),("_this4")];
_allUnits = [];
params [
	[("_this0"),([]),([[]])],
	[("_this1"),(1),([0])],
	[("_this2"),(1),([0])],
	[("_this3"),(-1),([0])],
	[("_this4"),(""),([""])],
	[("_this5"),(0),([0])],
	[("_this6"),(20),([0])]
];

if ((_this4 in ("missionList" call VEMFr_fnc_config)) OR (_this4 isEqualTo "Static")) then
	{
		scopeName "outer";
		_r = [];
		_this0 = [_this0 select 0, _this0 select 1, _this5];
		private [("_s"),("_ccrcy"),("_mshk"),("_mspd"),("_stmn"),("_sptDst"),("_sptTm"),("_crg"),("_rldSpd"),("_cmmndng"),("_gnrl"),("_i"),("_grp"),("_unit")];

		_s = [[("aiSkill"),(([["aiSkill"],["difficulty"]] call VEMFr_fnc_config) select 0)],[("accuracy"),("aimingShake"),("aimingSpeed"),("endurance"),("spotDistance"),("spotTime"),("courage"),("reloadSpeed"),("commanding"),("general")]] call VEMFr_fnc_config;
		_s params [("_ccrcy"),("_mshk"),("_mspd"),("_stmn"),("_sptDst"),("_sptTm"),("_crg"),("_rldSpd"),("_cmmndng"),("_gnrl")];
		for "_g" from 1 to _this1 do
			{
				_grp = createGroup ((([[call VEMFr_fnc_whichMod],["unitClass"]] call VEMFr_fnc_config) select 0) call VEMFr_fnc_checkSide);
				_grp allowFleeing 0;
				for "_u" from 1 to _this2 do
					{
						_unit = _grp createUnit [(([[call VEMFr_fnc_whichMod],["unitClass"]] call VEMFr_fnc_config) select 0), _this0, [], _this6, "FORM"]; // Create Unit There
						_allUnits pushBack _unit;
						_unit addMPEventHandler [("mpkilled"),("if (isDedicated) then { [[(_this select 0),(name(_this select 0))],[(_this select 1),(name(_this select 1))]] ExecVM ('aiKilled' call VEMFr_fnc_scriptPath) }")];
						// Set skills
						_unit setSkill [("aimingAccuracy"),(_ccrcy)];
						_unit setSkill [("aimingShake"),(_mshk)];
						_unit setSkill [("aimingSpeed"),(_mspd)];
						_unit setSkill [("endurance"),(_stmn)];
						_unit setSkill [("spotDistance"),(_sptDst)];
						_unit setSkill [("spotTime"),(_sptTm)];
						_unit setSkill [("courage"),(_crg)];
						_unit setSkill [("reloadSpeed"),(_rldSpd)];
						_unit setSkill [("commanding"),(_cmmndng)];
						_unit setSkill [("general"),(_gnrl)];

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
				_r pushBack _grp;
			};

		_i = [(_allUnits),(_this4),(_this3)] call VEMFr_fnc_loadInv; // Load the AI's inventory
		if (isNil "_i") then
			{
				_r = nil;
				[("fn_spawnVEMFrAI"),(0),("unable to load AI's inventory")] ExecVM ("log" call VEMFr_fnc_scriptPath);
				breakOut "outer";
			};
	} else
	{
		[("fn_spawnVEMFrAI"),(0),(format["'%1' is not in missionList or is not equal to 'Static'", _this4])] ExecVM ("log" call VEMFr_fnc_scriptPath);
	};

_r
