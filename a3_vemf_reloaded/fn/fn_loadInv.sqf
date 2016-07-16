/*
	Author: IT07

	Description:
	gives inventory to given units

	Param:
	_this: ARRAY
	_this select 0: ARRAY - units to load inventory for
	_this select 1: STRING - must be in missionList
	_this select 2: SCALAR - inventory mode

	Returns:
	BOOLEAN - true if nothing failed
*/

private ["_r","_this0","_this1","_this2"];
params [
	["_this0", [], [[]]],
	["_this1", "", [""]],
	["_this2", 0, [0]]
];

if ((_this1 in ("missionList" call VEMFr_fnc_config)) OR (_this1 isEqualTo "Static")) then
	{
		scopeName "this";
		if (_this2 isEqualTo 0) then // "Militia"
			{
				private ["_s","_unifs","_headG","_vests","_packs","_lnchers","_rfles","_pstls","_ls","_lc","_a"];
				// Define settings
				_s = [["aiGear"],["aiUniforms","aiHeadGear","aiVests","aiBackpacks","aiLaunchers","aiRifles","aiPistols"]] call VEMFr_fnc_config;
				_s params ["_unifs","_headG","_vests","_packs","_lnchers","_rfles","_pstls"];
				{
					private ["_xx","_g","_a","_pw","_hw"];
					_xx = _x;
					// Strip it
					removeAllWeapons _xx;
					removeAllItems _xx;
					if ("removeAllAssignedItems" call VEMFr_fnc_config isEqualTo 1) then
						{
							removeAllAssignedItems _xx;
						};
					removeVest _xx;
					removeBackpack _xx;
					removeGoggles _xx;
					removeHeadGear _xx;
					if (count _unifs > 0) then
						{
							removeUniform _xx;
							_g = selectRandom _unifs;
							_xx forceAddUniform _g; // Give the poor naked guy some clothing :)
						};
					if (_this1 isEqualTo "BaseAttack") then
						{
							_xx addBackpack "B_Parachute";
						};
					_g = selectRandom _headG;
					_xx addHeadGear _g;
					_g = selectRandom _vests;
					_xx addVest _g;
					_ls = [[_this1],["allowLaunchers","hasLauncherChance"]] call VEMFr_fnc_config;
					if ((_ls select 0) isEqualTo 1) then
						{
							_lc = _ls select 1;
							if ((_lc isEqualTo 100) OR ((ceil random (100 / _lc) isEqualTo (ceil random (100 / _lc))))) then
								{
									if not(_this1 isEqualTo "BaseAttack") then
										{
											_g = selectRandom _packs;
											_xx addBackpack _g;
										};
									_g = selectRandom _lnchers;
									_a = getArray (configFile >> "cfgWeapons" >> _g >> "magazines");
									if (count _a > 2) then
										{
											_a resize 2;
										};
										for "_i" from 0 to (2 + (round random 1)) do
											{
												_xx addMagazine (selectRandom _a);
											};
									_xx addWeapon _g;
								};
						};

					// Select a random weapon
					_pw = selectRandom _rfles;
					_hw = selectRandom _pstls;
					// Give this guy some ammo
					_g = [_xx, _pw, "", _hw] call VEMFr_fnc_giveAmmo;
					if (isNil "_g") then
						{
							["fn_loadInv", 0, format["FAILED to give ammo to AI: %1", _xx]] ExecVM ("log" call VEMFr_fnc_scriptPath);
						};
					_xx addWeapon _pw;
					_xx selectWeapon _pw;
					_xx addWeapon _hw;
					// Give this guy some weaponItems
					_g = [_xx] call VEMFr_fnc_giveWeaponItems;
					if not _g then
						{
							["fn_loadInv", 0, format["FAILED to giveWeaponItems to %1", _xx]] ExecVM ("log" call VEMFr_fnc_scriptPath);
						};
				} forEach _this0;
				_r = true;
				breakOut "this";
			};

		if (_this2 isEqualTo 1) then // Regular police
			{
				private ["_s","_headG","_vests","_unifs","_rfles","_pstls","_packs"];
				_s = [["policeConfig"],["headGear","vests","uniforms","rifles","pistols","backpacks"]] call VEMFr_fnc_config;
				_s params ["_headG","_vests","_unifs","_rfles","_pstls","_packs"];
				{
					private ["_xx","_g","_pw","_hw"];
					_xx = _x;
					// Strip it
					removeAllWeapons _xx;
					removeAllItems _xx;
					if ("removeAllAssignedItems" call VEMFr_fnc_config isEqualTo 1) then
						{
							removeAllAssignedItems _xx;
						};
					removeUniform _xx;
					removeVest _xx;
					removeBackpack _xx;
					removeGoggles _xx;
					removeHeadGear _xx;
					_g = selectRandom _headG;
					_xx addHeadGear _g;
					_g = selectRandom _vests;
					_xx addVest _g;
					_g = selectRandom _unifs;
					_xx forceAddUniform _g;

					_pw = selectRandom _rfles;
					_hw = selectRandom _pstls;
					// Give this guy some ammo
					_g = [_xx, _pw, "", _hw] call VEMFr_fnc_giveAmmo;
					if (isNil "_g") then
						{
							["fn_loadInv", 0, format["FAILED to give ammo to AI: %1", _xx]] ExecVM ("log" call VEMFr_fnc_scriptPath);
						};
					_xx addWeapon _pw;
					_xx selectWeapon _pw;
					_xx addWeapon _hw;
					if not(_this1 isEqualTo "BaseAttack") then
						{
							_xx addBackPack (selectRandom _packs);
						} else
						{
							_xx addBackpack "B_Parachute";
						};
					// Give this guy some weaponItems
					_g = [_xx] call VEMFr_fnc_giveWeaponItems;
					if (isNil "_g") then
						{
							["fn_loadInv", 0, format["FAILED to giveWeaponItems to %1", _xx]] ExecVM ("log" call VEMFr_fnc_scriptPath);
						};
				} forEach _this0;
				_r = true;
				breakOut "this";
			};

		if (_this2 isEqualTo 2) then // S.W.A.T.
			{
				private ["_s","_rfles","_pstls"];
				_s = [["policeConfig"],["rifles","pistols"]] call VEMFr_fnc_config;
				_s params ["_rfles","_pstls"];
				{
					private ["_xx","_g","_pw","_hw"];
					_xx = _x;
					// Strip it
					if ("removeAllAssignedItems" call VEMFr_fnc_config isEqualTo 1) then { removeAllAssignedItems _xx };
					removeAllItems _xx;
					removeAllWeapons _xx;
					removeBackpack _xx;
					removeGoggles _xx;
					removeHeadGear _xx;
					removeUniform _xx;
					removeVest _xx;
					_xx addHeadGear "H_HelmetB_light_black";
					_xx addGoggles "G_Balaclava_blk";
					_xx addVest "V_PlateCarrier2_blk";
					_xx forceAddUniform "Exile_Uniform_ExileCustoms";

					_pw = selectRandom _rfles;
					_hw = selectRandom _pstls;
					// Give this guy some ammo
					_g = [_xx, _pw, "", _hw] call VEMFr_fnc_giveAmmo;
					if (isNil "_g") then
						{
							["fn_loadInv", 0, format["FAILED to give ammo to AI: %1", _xx]] ExecVM ("log" call VEMFr_fnc_scriptPath);
						};
					_xx addWeapon _pw;
					_xx selectWeapon _pw;
					_xx addWeapon _hw;

					if (_this1 isEqualTo "BaseAttack") then { _xx addBackpack "B_Parachute" };

					// Give this guy some weaponItems
					_g = [_xx] call VEMFr_fnc_giveWeaponItems;
					if (isNil "_g") then
						{
							["fn_loadInv", 0, format["FAILED to giveWeaponItems to %1", _xx]] ExecVM ("log" call VEMFr_fnc_scriptPath);
						};
				} forEach _this0;
				_r = true;
			};
	};
_r
