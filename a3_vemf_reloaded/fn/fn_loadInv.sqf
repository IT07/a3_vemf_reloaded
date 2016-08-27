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

private "_r";
params [ "_this0", "_this1", "_this2" ];
if ( ( _this1 in ( "missionList" call VEMFr_fnc_config ) ) OR ( _this1 isEqualTo "Static" ) OR ( _this1 in ( "addons" call VEMFr_fnc_config ) ) ) then
	{
		scopeName "this";

		if ( _this2 isEqualTo -1 ) then // Whatever
			{
				if ( _this1 isEqualTo "SimplePatrol" ) then
					{
						private [ "_s", "_unifs", "_headGr", "_vests", "_packs", "_lnchers", "_rfles", "_pstls", "_ls", "_lc", "_a" ];
						// Define settings
						( [ [ "addonSettings", "SimplePatrol", "AIequipment" ], [ "backpacks", "faceWear", "headGear", "pistols", "rifles", "uniforms", "vests" ] ] call VEMFr_fnc_config) params [ "_packs", "_faceWr", "_headGr", "_pstls", "_rfles", "_unifs", "_vests" ];
						{
							private [ "_xx", "_g", "_a", "_pw", "_hw" ];
							_xx = _x;
							// Strip it
							removeAllWeapons _xx;
							removeAllItems _xx;
							if ( ( ( [ [ "addonSettings", "SimplePatrol" ], [ "removeAllAssignedItems" ] ] call VEMFr_fnc_config ) select 0 ) isEqualTo "yes" ) then { removeAllAssignedItems _xx };
							removeVest _xx;
							removeBackpack _xx;
							removeGoggles _xx;
							removeHeadGear _xx;
							if ( ( count _unifs ) > 0 ) then
								{
									removeUniform _xx;
									_g = selectRandom _unifs;
									_xx forceAddUniform _g; // Give the poor naked guy some clothing :)
								};
							_g = selectRandom _headGr;
							_xx addHeadGear _g;
							_g = selectRandom _faceWr;
							_xx addGoggles _g;
							_g = selectRandom _vests;
							_xx addVest _g;
							// Select a random weapon
							_pw = selectRandom _rfles;
							_hw = selectRandom _pstls;
							// Give this guy some ammo
							_g = [ _xx, _pw, "", _hw ] call VEMFr_fnc_giveAmmo;
							if ( isNil "_g" ) then { [ "fn_loadInv", 0, format [ "FAILED to give ammo to AI: %1", _xx ] ] ExecVM ( "log" call VEMFr_fnc_scriptPath ) };
							_xx addWeapon _pw;
							_xx selectWeapon _pw;
							_xx addWeapon _hw;
							// Give this guy some weaponItems
							_g = [ _xx ] call VEMFr_fnc_giveWeaponItems;
							if not _g then { [ "fn_loadInv", 0, format["FAILED to giveWeaponItems to %1", _xx] ] ExecVM ("log" call VEMFr_fnc_scriptPath) };
						} forEach _this0;
						_r = true;
						breakOut "this";
					};
			};

		if ( _this2 isEqualTo 0 ) then // Guerilla
			{
				private [ "_s", "_unifs", "_headGr", "_vests", "_packs", "_lnchers", "_rfles", "_pstls", "_ls", "_lc", "_a" ];
				// Define settings
				( [ [ "aiInventory", "Guerilla" ], [ "backpacks", "faceWear", "headGear", "launchers", "rifles", "uniforms", "vests" ] ] call VEMFr_fnc_config) params [ "_packs", "_faceWr", "_headGr", "_lnchers", "_rfles", "_unifs", "_vests" ];
				{
					private [ "_xx", "_g", "_a", "_pw" ];
					_xx = _x;
					// Strip it
					removeAllWeapons _xx;
					removeAllItems _xx;
					if ( ( "removeAllAssignedItems" call VEMFr_fnc_config ) isEqualTo "yes" ) then { removeAllAssignedItems _xx };
					removeVest _xx;
					removeBackpack _xx;
					removeGoggles _xx;
					removeHeadGear _xx;
					if ( ( count _unifs ) > 0 ) then
						{
							removeUniform _xx;
							_g = selectRandom _unifs;
							_xx forceAddUniform _g; // Give the poor naked guy some clothing :)
						};
					if ( _this1 isEqualTo "BaseAttack" ) then { _xx addBackpack "B_Parachute" };
					_g = selectRandom _headGr;
					_xx addHeadGear _g;
					_g = selectRandom _faceWr;
					_xx addGoggles _g;
					_g = selectRandom _vests;
					_xx addVest _g;
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
											_a = getArray ( configFile >> "cfgWeapons" >> _g >> "magazines" );
											if ( ( count _a ) > 2 ) then { _a resize 2 };
											for "_i" from 0 to ( 2 + ( round random 1 ) ) do { _xx addMagazine ( selectRandom _a ) };
											_xx addWeapon _g;
										};
								};
						};
					// Select a random weapon
					_pw = selectRandom _rfles;
					// Give this guy some ammo
					_g = [ _xx, _pw, "", "" ] call VEMFr_fnc_giveAmmo;
					if ( isNil "_g" ) then { [ "fn_loadInv", 0, format [ "FAILED to give ammo to AI: %1", _xx ] ] ExecVM ( "log" call VEMFr_fnc_scriptPath ) };
					_xx addWeapon _pw;
					_xx selectWeapon _pw;
					// Give this guy some weaponItems
					_g = [ _xx ] call VEMFr_fnc_giveWeaponItems;
					if not _g then { [ "fn_loadInv", 0, format["FAILED to giveWeaponItems to %1", _xx] ] ExecVM ("log" call VEMFr_fnc_scriptPath) };
				} forEach _this0;
				_r = true;
				breakOut "this";
			};

		if ( _this2 isEqualTo 1 ) then // Regular police
			{
				private [ "_s", "_headGr", "_vests", "_unifs", "_rfles", "_pstls", "_packs" ];
				_s = [ [ "aiInventory", "PoliceRegular" ], [ "headGear", "pistols", "rifles" , "uniforms", "vests" ] ] call VEMFr_fnc_config;
				_s params [ "_headGr", "_pstls", "_rfles", "_unifs", "_vests" ];
				{
					private [ "_xx", "_g", "_pw", "_hw" ];
					_xx = _x;
					// Strip it
					removeAllWeapons _xx;
					removeAllItems _xx;
					if ( ( "removeAllAssignedItems" call VEMFr_fnc_config ) isEqualTo "yes" ) then { removeAllAssignedItems _xx };
					removeUniform _xx;
					removeVest _xx;
					removeBackpack _xx;
					removeGoggles _xx;
					removeHeadGear _xx;
					_g = selectRandom _headGr;
					_xx addHeadGear _g;
					_g = selectRandom _vests;
					_xx addVest _g;
					_g = selectRandom _unifs;
					_xx forceAddUniform _g;

					_pw = selectRandom _rfles;
					_hw = selectRandom _pstls;
					// Give this guy some ammo
					_g = [ _xx, _pw, "", _hw ] call VEMFr_fnc_giveAmmo;
					if ( isNil "_g" ) then { [ "fn_loadInv", 0, format [ "FAILED to give ammo to AI: %1", _xx ] ] ExecVM ( "log" call VEMFr_fnc_scriptPath ) };
					_xx addWeapon _pw;
					_xx selectWeapon _pw;
					_xx addWeapon _hw;
					if ( _this1 isEqualTo "BaseAttack" ) then { _xx addBackpack "B_Parachute" };
					// Give this guy some weaponItems
					_g = [ _xx ] call VEMFr_fnc_giveWeaponItems;
					if ( isNil "_g" ) then { [ "fn_loadInv", 0, format [ "FAILED to giveWeaponItems to %1", _xx ] ] ExecVM ( "log" call VEMFr_fnc_scriptPath ) };
				} forEach _this0;
				_r = true;
				breakOut "this";
			};

		if ( _this2 isEqualTo 2 ) then // Police Special Forces
			{
				private [ "_s", "_rfles", "_pstls" ];
				( [ [ "aiInventory", "PoliceSpecialForces" ], [ "faceWear", "headGear", "pistols", "rifles", "uniforms", "vests" ] ] call VEMFr_fnc_config ) params [ "_faceWr", "_headGrr", "_pstls", "_rfles", "_unifs", "_vests" ];
				{
					private [ "_xx", "_g", "_pw", "_hw" ];
					_xx = _x;
					// Strip it
					if ( ( "removeAllAssignedItems" call VEMFr_fnc_config ) isEqualTo "yes" ) then { removeAllAssignedItems _xx };
					removeAllItems _xx;
					removeAllWeapons _xx;
					removeBackpack _xx;
					removeGoggles _xx;
					removeHeadGear _xx;
					removeUniform _xx;
					removeVest _xx;
					_xx addHeadGear ( selectRandom _headGrr );
					_xx addGoggles ( selectRandom _faceWr );
					_xx addVest ( selectRandom _vests );
					_xx forceAddUniform ( selectRandom _unifs );

					_pw = selectRandom _rfles;
					_hw = selectRandom _pstls;
					// Give this guy some ammo
					_g = [ _xx, _pw, "", _hw ] call VEMFr_fnc_giveAmmo;
					if ( isNil "_g" ) then { [ "fn_loadInv", 0, format [ "FAILED to give ammo to AI: %1", _xx ] ] ExecVM ( "log" call VEMFr_fnc_scriptPath ) };
					_xx addWeapon _pw;
					_xx selectWeapon _pw;
					_xx addWeapon _hw;

					if ( _this1 isEqualTo "BaseAttack" ) then { _xx addBackpack "B_Parachute" };

					// Give this guy some weaponItems
					_g = [ _xx ] call VEMFr_fnc_giveWeaponItems;
					if ( isNil "_g" ) then { [ "fn_loadInv", 0, format [ "FAILED to giveWeaponItems to %1", _xx ] ] ExecVM ( "log" call VEMFr_fnc_scriptPath ) };
				} forEach _this0;
				_r = true;
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
					removeAllItems _xx;
					removeAllWeapons _xx;
					removeBackpack _xx;
					removeGoggles _xx;
					removeHeadGear _xx;
					removeUniform _xx;
					removeVest _xx;
					_xx addHeadGear ( selectRandom _headGrr );
					_xx addGoggles ( selectRandom _facewr );
					_xx addVest ( selectRandom _vests );
					_xx forceAddUniform ( selectRandom _unifs );

					_pw = selectRandom _rfles;
					_hw = selectRandom _pstls;
					// Give this guy some ammo
					_g = [ _xx, _pw, "", _hw ] call VEMFr_fnc_giveAmmo;
					if ( isNil "_g" ) then { [ "fn_loadInv", 0, format [ "FAILED to give ammo to AI: %1", _xx ] ] ExecVM ( "log" call VEMFr_fnc_scriptPath ) };
					_xx addWeapon _pw;
					_xx selectWeapon _pw;
					_xx addWeapon _hw;

					if ( _this1 isEqualTo "BaseAttack" ) then { _xx addBackpack "B_Parachute" };

					// Give this guy some weaponItems
					_g = [ _xx ] call VEMFr_fnc_giveWeaponItems;
					if ( isNil "_g" ) then { [ "fn_loadInv", 0, format [ "FAILED to giveWeaponItems to %1", _xx ] ] ExecVM ( "log" call VEMFr_fnc_scriptPath ) };
				} forEach _this0;
				_r = true;
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
					removeAllWeapons _xx;
					removeAllItems _xx;
					if ( ( "removeAllAssignedItems" call VEMFr_fnc_config ) isEqualTo "yes" ) then { removeAllAssignedItems _xx };
					removeVest _xx;
					removeBackpack _xx;
					removeGoggles _xx;
					removeHeadGear _xx;
					if ( ( count _unifs ) > 0 ) then
						{
							removeUniform _xx;
							_g = selectRandom _unifs;
							_xx forceAddUniform _g; // Give the poor naked guy some clothing :)
						};
					if ( _this1 isEqualTo "BaseAttack" ) then { _xx addBackpack "B_Parachute" };
					_g = selectRandom _headGrr;
					_xx addHeadGear _g;
					_g = selectRandom _vests;
					_xx addVest _g;
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

					// Select a random weapon
					_pw = selectRandom _rfles;
					// Give this guy some ammo
					_g = [ _xx, _pw, "", "" ] call VEMFr_fnc_giveAmmo;
					if ( isNil "_g" ) then { [ "fn_loadInv", 0, format [ "FAILED to give ammo to AI: %1", _xx] ] ExecVM ( "log" call VEMFr_fnc_scriptPath ) };
					_xx addWeapon _pw;
					_xx selectWeapon _pw;
					// Give this guy some weaponItems
					_g = [ _xx ] call VEMFr_fnc_giveWeaponItems;
					if not _g then { [ "fn_loadInv", 0, format [ "FAILED to giveWeaponItems to %1", _xx ] ] ExecVM ( "log" call VEMFr_fnc_scriptPath ) };
				} forEach _this0;
				_r = true;
				breakOut "this";
			};
	};

if not ( isNil "_r" ) then { _r };
