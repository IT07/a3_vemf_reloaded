/*
	Author: VAMPIRE, rebooted by IT07

	Description:
	loads AI inventory

	Param:
	_this: ARRAY
	_this select 0: ARRAY - units to load inventory for
	_this select 1: STRING - must be in missionList
	_this select 2: SCALAR - inventory mode

	Returns:
	BOOLEAN - true if nothing failed
*/

private ["_ok","_params"];
_ok = false;
_params = _this;
if (_this isEqualType []) then
	{
		private ["_units"];
		_units = param [0, [], [[]]];
		if (count _units > 0) then
			{
				private ["_missionName"];
				_missionName = param [1, "", [""]];
				if (_missionName in ("missionList" call VEMFr_fnc_getSetting) OR _missionName isEqualTo "Static") then
					{
						scopeName "this";
						private ["_aiMode"];
						_aiMode = param [2, 0, [0]];
						if (_aiMode isEqualTo 0) then // "Militia"
							{
								private ["_aiGear","_uniforms","_headGear","_vests","_backpacks","_rifles","_pistols","_aiLaunchers","_launchers","_launcherChance"];
								// Define settings
								_aiGear = [["aiGear"],["aiUniforms","aiHeadGear","aiVests","aiBackpacks","aiLaunchers","aiRifles","aiPistols"]] call VEMFr_fnc_getSetting;
								_uniforms = _aiGear select 0;
								_headGear = _aiGear select 1;
								_vests = _aiGear select 2;
								_backpacks = _aiGear select 3;
								_rifles = _aiGear select 5;
								_pistols = _aiGear select 6;
								_aiLaunchers = ([[_missionName],["aiLaunchers"]] call VEMFr_fnc_getSetting) select 0;
								if (_aiLaunchers isEqualTo 1) then
									{
										_launchers = _aiGear select 4;
										_launcherChance = ([[_missionName],["hasLauncherChance"]] call VEMFr_fnc_getSetting) select 0;
									};
								{
									private ["_unit","_gear","_ammo"];
									_unit = _x;
									// Strip it
									removeAllWeapons _unit;
									removeAllItems _unit;
									if ("removeAllAssignedItems" call VEMFr_fnc_getSetting isEqualTo 1) then
										{
											removeAllAssignedItems _unit;
										};
									removeVest _unit;
									removeBackpack _unit;
									removeGoggles _unit;
									removeHeadGear _unit;
									if (count _uniforms > 0) then
										{
											removeUniform _unit;
											_gear = selectRandom _uniforms;
											_unit forceAddUniform _gear; // Give the poor naked guy some clothing :)
										};
									if (_missionName isEqualTo "BaseAttack") then
										{
											_unit addBackpack "B_Parachute";
										};
									_gear = selectRandom _headGear;
									_unit addHeadGear _gear;
									_gear = selectRandom _vests;
									_unit addVest _gear;
									if (_aiLaunchers isEqualTo 1) then
										{
											if (_launcherChance isEqualTo 100 OR (ceil random (100 / _launcherChance) isEqualTo (ceil random (100 / _launcherChance)))) then
												{
													if not(_missionName isEqualTo "BaseAttack") then
														{
															_gear = selectRandom _backpacks;
															_unit addBackpack _gear;
														};
													_gear = selectRandom _launchers;
													_unit addWeapon _gear;
													private ["_ammo"];
													_ammo = getArray (configFile >> "cfgWeapons" >> _gear >> "magazines");
													if (count _ammo > 2) then
														{
															_ammo resize 2;
														};
													for "_i" from 0 to (2 + (round random 1)) do
														{
															_unit addMagazine (selectRandom _ammo);
														};
												};
										};

									// Add Weapons & Ammo
									_gear = selectRandom _rifles;
									_unit addWeapon _gear;
									_unit selectWeapon _gear;
									_gear = selectRandom _pistols;
									_unit addWeapon _gear;
									// Give this guy some ammo
									_givenAmmo = [_unit] call VEMFr_fnc_giveAmmo;
									if not _givenAmmo then
										{
											["fn_loadInv", 0, format["FAILED to give ammo to AI: %1", _unit]] ExecVM "exile_vemf_reloaded\sqf\log.sqf";
										};
									// Give this guy some weaponItems
									_giveAttachments = [_unit] call VEMFr_fnc_giveWeaponItems;
									if not _giveAttachments then
										{
											["fn_loadInv", 0, format["FAILED to giveWeaponItems to %1", _unit]] ExecVM "exile_vemf_reloaded\sqf\log.sqf";
										};
								} forEach _units;
								_ok = true;
								breakOut "this";
							};
						if (_aiMode isEqualTo 1) then // Regular police
							{
								private ["_policeGear","_headGear","_vests","_uniforms","_rifles","_pistols","_backpacks"];
								_policeGear = [["policeConfig"],["headGear","vests","uniforms","rifles","pistols","backpacks"]] call VEMFr_fnc_getSetting;
								_headGear = _policeGear select 0;
								_vests = _policeGear select 1;
								_uniforms = _policeGear select 2;
								_rifles = _policeGear select 3;
								_pistols = _policeGear select 4;
								_backpacks = _policeGear select 5;
								{
									private ["_unit","_hat","_vest","_uniform","_rifle","_pistol","_backpack","_givenAmmo","_giveAttachments"];
									_unit = _x;
									// Strip it
									removeAllWeapons _unit;
									removeAllItems _unit;
									if ("removeAllAssignedItems" call VEMFr_fnc_getSetting isEqualTo 1) then
										{
											removeAllAssignedItems _unit;
										};
									removeUniform _unit;
									removeVest _unit;
									removeBackpack _unit;
									removeGoggles _unit;
									removeHeadGear _unit;

									_hat = selectRandom _headGear;
									_unit addHeadGear _hat;
									_vest = selectRandom _vests;
									_unit addVest _vest;
									_uniform = selectRandom _uniforms;
									_unit forceAddUniform _uniform;
									_rifle = selectRandom _rifles;
									_unit addWeapon _rifle;
									_unit selectWeapon _rifle;
									_pistol = selectRandom _pistols;
									_unit addWeapon _pistol;
									if not(_missionName isEqualTo "BaseAttack") then
										{
											_backpack = selectRandom _backpacks;
											_unit addBackPack _backpack;
										} else
										{
											_unit addBackpack "B_Parachute";
										};
									// Give this guy some ammo
									_givenAmmo = [_unit] call VEMFr_fnc_giveAmmo;
									if not _givenAmmo then
										{
											["fn_loadInv", 0, format["FAILED to give ammo to AI: %1", _unit]] ExecVM "exile_vemf_reloaded\sqf\log.sqf";
										};
									// Give this guy some weaponItems
									_giveAttachments = [_unit] call VEMFr_fnc_giveWeaponItems;
									if not _giveAttachments then
										{
											["fn_loadInv", 0, format["FAILED to giveWeaponItems to %1", _unit]] ExecVM "exile_vemf_reloaded\sqf\log.sqf";
										};
								} forEach _units;
								_ok = true;
								breakOut "this";
							};
						if (_aiMode isEqualTo 2) then // S.W.A.T.
							{
								private ["_policeGear","_rifles","_pistols"];
								_policeGear = [["policeConfig"],["rifles","pistols"]] call VEMFr_fnc_getSetting;
								_rifles = _policeGear select 0;
								_pistols = _policeGear select 1;
								{
									private ["_unit","_rifle","_pistol","_givenAmmo","_giveAttachments"];
									_unit = _x;
									// Strip it
									if ("removeAllAssignedItems" call VEMFr_fnc_getSetting isEqualTo 1) then
										{
											removeAllAssignedItems _unit;
										};
									removeAllItems _unit;
									removeAllWeapons _unit;
									removeBackpack _unit;
									removeGoggles _unit;
									removeHeadGear _unit;
									removeUniform _unit;
									removeVest _unit;
									_unit addHeadGear "H_HelmetB_light_black";
									_unit addGoggles "G_Balaclava_blk";
									_unit addVest "V_PlateCarrier2_blk";
									_unit forceAddUniform "Exile_Uniform_ExileCustoms";
									_rifle = selectRandom _rifles;
									_unit addWeapon _rifle;
									_unit selectWeapon _rifle;
									_pistol = selectRandom _pistols;
									_unit addWeapon _pistol;

									if (_missionName isEqualTo "BaseAttack") then
										{
											_unit addBackpack "B_Parachute";
										};
									// Give this guy some ammo
									_givenAmmo = [_unit] call VEMFr_fnc_giveAmmo;
									if not _givenAmmo then
										{
											["fn_loadInv", 0, format["FAILED to give ammo to AI: %1", _unit]] ExecVM "exile_vemf_reloaded\sqf\log.sqf";
										};
									// Give this guy some weaponItems
									_giveAttachments = [_unit] call VEMFr_fnc_giveWeaponItems;
									if not _giveAttachments then
										{
											["fn_loadInv", 0, format["FAILED to giveWeaponItems to %1", _unit]] ExecVM "exile_vemf_reloaded\sqf\log.sqf";
										};
								} forEach _units;
								_ok = true;
							};
					};
			};
	};

_ok
