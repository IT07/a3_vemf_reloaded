/*
	Author: IT07

	Description:
	loads loot crate inventory

	Params:
	_this: ARRAY
	_this select 0: OBJECT - the crate
	_this select 1: STRING - (optional) name of the location where crate is
	_this select 2: ARRAY - (optional) position of location where crate is

	Returns:
	nothing
*/

params [
	[("_obj"),(objNull),([objNull])],
	[("_locName"),(""),([""])],
	[("_locPos"),([]),([[]])]
];

_obj setVariable ["isVEMFrCrate", 1, true];
clearBackpackCargoGlobal  _obj;
clearItemCargoGlobal _obj;
clearMagazineCargoGlobal _obj;
clearWeaponCargoGlobal _obj;

([
	[("missionSettings"),("DynamicLocationInvasion"),("crateSettings")],
	[("rifleSlotsMax"),("rifleSlotsMin"),("pistolSlotsMax"),("pistolSlotsMin"),("magSlotsMax"),("magSlotsMin"),("attSlotsMax"),("attSlotsMin"),("itemSlotsMax"),("itemSlotsMin"),
	("vestSlotsMax"),("vestSlotsMin"),("headGearSlotsMax"),("headGearSlotsMin"),("bagSlotsMax"),("bagSlotsMin")]
] call VEMFr_fnc_config) params [("_cs0"),("_cs1"),("_cs2"),("_cs3"),("_cs4"),("_cs5"),("_cs6"),("_cs7"),("_cs8"),("_cs9"),("_cs10"),("_cs11"),("_cs12"),("_cs13"),("_cs14"),("_cs15")];

([
	[("missionSettings"),("DynamicLocationInvasion"),("crateLootVanilla")],
	[("attachments"),("backpacks"),("headGear"),(format["items%1", call VEMFr_fnc_whichMod]),("magazines"),("pistols"),("rifles"),("vests")]
] call VEMFr_fnc_config) params [("_vl0"),("_vl1"),("_vl2"),("_vl3"),("_vl4"),("_vl5"),("_vl6"),("_vl7")];

if ((call VEMFr_fnc_whichMod) isEqualTo "Exile") then
	{
		private "_c";
		_c = ([["Exile"],["crateMoney"]] call VEMFr_fnc_config) select 0;
		if (_c > 0) then { _obj setVariable [("ExileMoney"),((_c / 2) + (round random (_c / 2))),(true)] };
	};

if (("Apex" call VEMFr_fnc_modAppID) in (getDLCs 1)) then
	{
		private [("_el0"),("_el1"),("_el2"),("_el3"),("_el4"),("_el5"),("_el6"),("_el7")];
		([
			[("missionSettings"),("DynamicLocationInvasion"),("crateLootApex")],
			[("attachments"),("backpacks"),("headGear"),("headGearSpecial"),("magazines"),("pistols"),("rifles"),("vests")]
		] call VEMFr_fnc_config) params [("_el0"),("_el1"),("_el2"),("_el3"),("_el4"),("_el5"),("_el6"),("_el7")];
		_vl0 append _el0;
		_vl1 append _el1;
		_vl2 append _el2;
		if ((([[("missionSettings"),("DynamicLocationInvasion"),("crateSettings")],["allowThermalHelmets"]] call VEMFr_fnc_config) select 0) isEqualTo "yes") then { _vl2 append _el3 };
		_vl4 append _el4;
		_vl5 append _el5;
		_vl6 append _el6;
		_vl7 append _el7;
	};

_bad = ([[("blacklists"),("loot")],["classes"]] call VEMFr_fnc_config) select 0;

if ((round random 1) isEqualTo 1) then
	{
		// Rifles
		for "_l" from 0 to (_cs0 - _cs1 + floor random _cs1) do
			{
				_g = selectRandom _vl6;
				if not((_g select 0) in _bad) then { _obj addWeaponCargoGlobal [_g select 0, (1 + (floor random (_g select 1)))] };
			};
	};

if ((round random 3) isEqualTo 1) then
	{
		// Pistols
		for "_l" from 0 to (_cs2 - _cs3 + floor random _cs3) do
			{
				_g = selectRandom _vl5;
				if not((_g select 0) in _bad) then { _obj addWeaponCargoGlobal [_g select 0, (1 + (floor random (_g select 1)))] };
			};
	};

if ((round random 2) isEqualTo 1) then
	{
		// Magazines
		for "_l" from 0 to (_cs4 - _cs5 + floor random _cs5) do
			{
				_g = selectRandom _vl4;
				if not((_g select 0) in _bad) then { _obj addMagazineCargoGlobal [_g select 0, (1 + (floor random (_g select 1)))] };
			};
	};

if ((round random 4) isEqualTo 1) then
	{
		// Weapon attachments
		for "_l" from 0 to (_cs6 - _cs7 + floor random _cs7) do
			{
				_g = selectRandom _vl0;
				if not((_g select 0) in _bad) then { _obj addItemCargoGlobal [_g select 0, (1 + (floor random (_g select 1)))] };
			};
	};

// Items
for "_l" from 0 to (_cs8 - _cs9 + floor random _cs9) do
	{
		_g = selectRandom _vl3;
		if not((_g select 0) in _bad) then { _obj addItemCargoGlobal [_g select 0, (1 + (floor random (_g select 1)))] };
	};

if ((round random 4) isEqualTo 1) then
	{
		// Vests
		for "_l" from 0 to (_cs10 - _cs11 + floor random _cs11) do
			{
				_g = selectRandom _vl7;
				if not((_g select 0) in _bad) then { _obj addItemCargoGlobal [_g select 0, (1 + (floor random (_g select 1)))] };
			};
	};

if ((round random 2) isEqualTo 1) then
	{
		// Helmets / caps / berets / bandanas
		for "_l" from 0 to (_cs12 - _cs13 + floor random _cs13) do
			{
				_g = selectRandom _vl2;
				if not((_g select 0) in _bad) then { _obj addItemCargoGlobal [_g select 0, (1 + (floor random (_g select 1)))] };
			};
	};

if ((round random 3) isEqualTo 1) then
	{
		// Backpacks
		for "_l" from 0 to (_cs14 - _cs15 + floor random _cs15) do
			{
				_g = selectRandom _vl1;
				if not((_g select 0) in _bad) then { _obj addBackpackCargoGlobal [_g select 0, (1 + (floor random (_g select 1)))] };
			};
	};

["loadLoot", 1, format["Loot loaded into crate located in '%1' at %2", _locName, mapGridPosition _obj]] ExecVM ("log" call VEMFr_fnc_scriptPath);
