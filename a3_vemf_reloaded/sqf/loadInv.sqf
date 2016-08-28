/*
	Author: IT07

	Description:
	gives inventory to given units

	Param:
	_this: ARRAY
	_this select 0: ARRAY - units to load inventory for
	_this select 1: STRING - must be in missionList or addons
	_this select 2: SCALAR - inventory mode

	Returns:
	BOOLEAN - true if nothing failed
*/

params [ "_this0", "_this1", "_this2" ];

if ( _this2 isEqualTo -1 ) then // Whatever
	{
		if ( _this1 isEqualTo "SimplePatrol" ) then
			{
				// Define settings
				( [ [ "addonSettings", "SimplePatrol", "AIequipment" ], [ "backpacks", "faceWear", "headGear", "pistols", "rifles", "uniforms", "vests" ] ] call VEMFr_fnc_config ) params [ "_packs", "_faceWr", "_headGr", "_pstls", "_rfles", "_unifs", "_vests" ];
				{
					private _xx = _x;
					// Strip it
					removeVest _xx;
					_xx addVest ( selectRandom _vests );
					removeBackpack _xx;
					removeGoggles _xx;
					_xx addGoggles ( selectRandom _faceWr );
					removeHeadGear _xx;
					_xx addHeadGear ( selectRandom _headGr );
					if ( ( count _unifs ) > 0 ) then
						{
							removeUniform _xx;
							_xx forceAddUniform ( selectRandom _unifs ); // Give the poor naked guy some clothing :)
						};
					removeAllWeapons _xx;
					removeAllItems _xx;
					if ( ( ( [ [ "addonSettings", "SimplePatrol" ], [ "removeAllAssignedItems" ] ] call VEMFr_fnc_config ) select 0 ) isEqualTo "yes" ) then { removeAllAssignedItems _xx };
					[ _xx, ( selectRandom _rfles ), "", ( selectRandom _pstls ) ] ExecVM ( "giveFire" call VEMFr_fnc_scriptPath );
				} forEach _this0;
			};
	};

if ( _this2 isEqualTo 0 ) then // Guerilla
	{
		// Define settings
		( [ [ "aiInventory", "Guerilla" ], [ "backpacks", "faceWear", "headGear", "launchers", "rifles", "uniforms", "vests" ] ] call VEMFr_fnc_config) params [ "_packs", "_faceWr", "_headGr", "_lnchers", "_rfles", "_unifs", "_vests" ];
		{
			private _xx = _x;
			// Strip it
			removeBackpack _xx;
			if ( _this1 isEqualTo "BaseAttack" ) then { _xx addBackpack "B_Parachute" };
			removeVest _xx;
			_xx addVest ( selectRandom _vests );
			removeGoggles _xx;
			_xx addGoggles ( selectRandom _faceWr );
			removeHeadGear _xx;
			_xx addHeadGear ( selectRandom _headGr );
			if ( ( count _unifs ) > 0 ) then
				{
					removeUniform _xx;
					_xx forceAddUniform ( selectRandom _unifs ); // Give the poor naked guy some clothing :)
				};
			if ( _this1 in ( "missionList" call VEMFr_fnc_config ) ) then
				{
					_ls = [ [ "missionSettings", _this1 ], [ "allowLaunchers", "hasLauncherChance" ] ] call VEMFr_fnc_config;
					if ( ( _ls select 0 ) isEqualTo "yes" ) then
						{
							_lc = _ls select 1;
							if ( ( _lc isEqualTo 100 ) OR ( ( ceil random ( 100 / _lc ) isEqualTo ( ceil random ( 100 / _lc ) ) ) ) ) then
								{
									if not ( _this1 isEqualTo "BaseAttack" ) then { _xx addBackpack ( selectRandom _packs ) };
									private _g = selectRandom _lnchers;
									_a = getArray ( configFile >> "cfgWeapons" >> _g >> "magazines" );
									if ( ( count _a ) > 2 ) then { _a resize 2 };
									for "_i" from 0 to ( 2 + ( round random 1 ) ) do { _xx addMagazine ( selectRandom _a ) };
									_xx addWeapon _g;
								};
						};
				};

			removeAllWeapons _xx;
			removeAllItems _xx;
			if ( ( "removeAllAssignedItems" call VEMFr_fnc_config ) isEqualTo "yes" ) then { removeAllAssignedItems _xx };
			[ _xx, ( selectRandom _rfles ), "", "" ] ExecVM ( "giveFire" call VEMFr_fnc_scriptPath );
		} forEach _this0;
	};

if ( _this2 isEqualTo 1 ) then // Regular police
	{
		( [ [ "aiInventory", "PoliceRegular" ], [ "headGear", "pistols", "rifles" , "uniforms", "vests" ] ] call VEMFr_fnc_config ) params [ "_headGr", "_pstls", "_rfles", "_unifs", "_vests" ];
		{
			private _xx = _x;
			// Strip it
			if ( ( "removeAllAssignedItems" call VEMFr_fnc_config ) isEqualTo "yes" ) then { removeAllAssignedItems _xx };
			removeUniform _xx;
			_xx forceAddUniform ( selectRandom _unifs );
			removeVest _xx;
			_xx addVest ( selectRandom _vests );
			removeBackpack _xx;
			if ( _this1 isEqualTo "BaseAttack" ) then { _xx addBackpack "B_Parachute" };
			removeHeadGear _xx;
			_xx addHeadGear ( selectRandom _headGr );
			removeGoggles _xx;
			removeAllWeapons _xx;
			removeAllItems _xx;

			// Give this guy some ammo
			[ _xx, ( selectRandom _rfles ), "", ( selectRandom _pstls ) ] ExecVM ( "giveFire" call VEMFr_fnc_scriptPath );
		} forEach _this0;
	};

if ( _this2 isEqualTo 2 ) then // Police Special Forces
	{
		( [ [ "aiInventory", "PoliceSpecialForces" ], [ "faceWear", "headGear", "pistols", "rifles", "uniforms", "vests" ] ] call VEMFr_fnc_config ) params [ "_faceWr", "_headGrr", "_pstls", "_rfles", "_unifs", "_vests" ];
		{
			private _xx = _x;
			// Strip it
			if ( ( "removeAllAssignedItems" call VEMFr_fnc_config ) isEqualTo "yes" ) then { removeAllAssignedItems _xx };
			removeBackpack _xx;
			if ( _this1 isEqualTo "BaseAttack" ) then { _xx addBackpack "B_Parachute" };
			removeGoggles _xx;
			_xx addGoggles ( selectRandom _faceWr );
			removeHeadGear _xx;
			_xx addHeadGear ( selectRandom _headGrr );
			removeUniform _xx;
			_xx forceAddUniform ( selectRandom _unifs );
			removeVest _xx;
			_xx addVest ( selectRandom _vests );
			removeAllItems _xx;
			removeAllWeapons _xx;

			[ _xx, ( selectRandom _rfles ), "", ( selectRandom _pstls ) ] ExecVM ( "giveFire" call VEMFr_fnc_scriptPath ); // Give this guy some fire power
		} forEach _this0;
	};

if ( _this2 isEqualTo 3 ) then // Gendarmerie
	{
		private [ "_rfles", "_pstls" ];
		( [ [ "aiInventory", "Gendarmerie" ], [ "headGear", "faceWear", "pistols", "rifles", "uniforms", "vests" ] ] call VEMFr_fnc_config ) params [ "_headGrr" , "_facewr", "_pstls", "_rfles", "_unifs", "_vests" ];
		{
			private [ "_xx", "_g", "_pw", "_hw" ];
			_xx = _x;
			// Strip it
			if ( ( "removeAllAssignedItems" call VEMFr_fnc_config ) isEqualTo "yes" ) then { removeAllAssignedItems _xx };
			removeBackpack _xx;
			if ( _this1 isEqualTo "BaseAttack" ) then { _xx addBackpack "B_Parachute" };
			removeGoggles _xx;
			_xx addGoggles ( selectRandom _facewr );
			removeHeadGear _xx;
			_xx addHeadGear ( selectRandom _headGrr );
			removeUniform _xx;
			_xx forceAddUniform ( selectRandom _unifs );
			removeVest _xx;
			_xx addVest ( selectRandom _vests );
			removeAllItems _xx;
			removeAllWeapons _xx;

			// Give this guy some fire power
			[ _xx, ( selectRandom _rfles ), "", ( selectRandom _pstls ) ] ExecVM ( "giveFire" call VEMFr_fnc_scriptPath );
		} forEach _this0;
	};

if ( _this2 isEqualTo 4 ) then // Raiders
	{
		private [ "_s", "_unifs", "_headGr", "_vests", "_packs", "_lnchers", "_rfles", "_pstls", "_ls", "_lc", "_a" ];
		// Define settings
		( [ [ "aiInventory", "ApexBandits" ], [ "backpacks", "headGear", "launchers", "rifles", "uniforms", "vests" ] ] call VEMFr_fnc_config) params [ "_packs", "_headGrr", "_lnchers", "_rfles", "_unifs", "_vests" ];
		{
			private [ "_xx", "_g", "_a", "_pw" ];
			_xx = _x;
			// Strip it
			removeBackpack _xx;
			if ( _this1 isEqualTo "BaseAttack" ) then { _xx addBackpack "B_Parachute" };
			removeGoggles _xx;
			removeHeadGear _xx;
			_xx addHeadGear ( selectRandom _headGrr );
			removeVest _xx;
			_xx addVest ( selectRandom _vests );
			if ( ( count _unifs ) > 0 ) then
				{
					removeUniform _xx;
					_xx forceAddUniform ( selectRandom _unifs ); // Give the poor naked guy some clothing :)
				};
			if ( _this1 in ( "missionList" call VEMFr_fnc_config ) ) then
				{
					_ls = [ [ "missionSettings", _this1 ], [ "allowLaunchers", "hasLauncherChance" ] ] call VEMFr_fnc_config;
					if ( ( _ls select 0 ) isEqualTo "yes" ) then
						{
							_lc = _ls select 1;
							if ( ( _lc isEqualTo 100 ) OR ( ( ceil random ( 100 / _lc ) isEqualTo ( ceil random ( 100 / _lc ) ) ) ) ) then
								{
									if not ( _this1 isEqualTo "BaseAttack" ) then
										{
											_g = selectRandom _packs;
											_xx addBackpack _g;
										};
									_g = selectRandom _lnchers;
									_a = getArray (configFile >> "cfgWeapons" >> _g >> "magazines");
									if ( ( count _a ) > 2 ) then { _a resize 2 };
									for "_i" from 0 to ( 2 + ( round random 1 ) ) do { _xx addMagazine (selectRandom _a) };
									_xx addWeapon _g;
								};
						};
				};

			removeAllWeapons _xx;
			removeAllItems _xx;
			if ( ( "removeAllAssignedItems" call VEMFr_fnc_config ) isEqualTo "yes" ) then { removeAllAssignedItems _xx };
			[ _xx, ( selectRandom _rfles ), "", "" ] ExecVM ( "giveFire" call VEMFr_fnc_scriptPath ); // Give this guy some fire power
		} forEach _this0;
	};
