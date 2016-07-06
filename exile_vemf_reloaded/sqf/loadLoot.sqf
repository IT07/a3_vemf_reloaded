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
	["_crate", objNull, [objNull]],
	["_locName", "", [""]],
	["_locPos", [], [[]]]
];

_crate setVariable ["isVEMFrCrate", 1, true];
clearBackpackCargoGlobal  _crate;
clearItemCargoGlobal _crate;
clearMagazineCargoGlobal _crate;
clearWeaponCargoGlobal _crate;

_ms = [
	["crateLoot"],
	[
		"primarySlotsMax","primarySlotsMin","secondarySlotsMax","secondarySlotsMin","magSlotsMax","magSlotsMin","attSlotsMax","attSlotsMin","itemSlotsMax","itemSlotsMin",
		"vestSlotsMax","vestSlotsMin","headGearSlotsMax","headGearSlotsMin","bagSlotsMax","bagSlotsMin","primaryWeaponLoot","secondaryWeaponLoot","magLoot","attLoot",
		"itemLoot","vestLoot","backpackLoot","headGearLoot","blackListLoot"
	]
] call VEMFr_fnc_config;
_ms params [
	"_maxPrim","_minPrim","_maxSec","_minSec","_maxMagSlots","_minMagSlots","_maxAttSlots","_minAttSlots","_maxItemSlots","_minItemSlots","_maxVestSlots","_minVestSlots",
	"_maxHeadGearSlots","_minHeadGearSlots","_maxBagSlots","_minBagSlots","_primaries","_secondaries","_magazines","_attachments","_items","_vests","_backpacks","_headGear","_blackList"
];

// Add primary weapons
for "_j" from 0 to (_maxPrim - _minPrim + floor random _minPrim) do
	{
		_g = _primaries call BIS_fnc_selectRandom;
		if not((_g select 0) in _blackList) then
			{
				_crate addWeaponCargoGlobal [_g select 0, _g select 1];
			};
	};

// Secondary weapons
for "_j" from 0 to (_maxSec - _minSec + floor random _minSec) do
	{
		_g = _secondaries call BIS_fnc_selectRandom;
		if not((_g select 0) in _blackList) then
			{
				_crate addWeaponCargoGlobal [_g select 0, _g select 1];
			};
	};

// Magazines
for "_j" from 0 to (_maxMagSlots - _minMagSlots + floor random _minMagSlots) do
	{
		_g = _magazines call BIS_fnc_selectRandom;
		if not((_g select 0) in _blackList) then
			{
				_crate addMagazineCargoGlobal [_g select 0, _g select 1];
			};
	};

// Weapon attachments
for "_j" from 0 to (_maxAttSlots - _minAttSlots + floor random _minAttSlots) do
	{
		_g = _attachments call BIS_fnc_selectRandom;
		if not((_g select 0) in _blackList) then
			{
				_crate addItemCargoGlobal [_g select 0, _g select 1];
			};
	};

// Items
for "_j" from 0 to (_maxItemSlots - _minItemSlots + floor random _minItemSlots) do
	{
		_g = _items call BIS_fnc_selectRandom;
		if not((_g select 0) in _blacklist) then
			{
				_crate addItemCargoGlobal [_g select 0, _g select 1];
			};
	};

// Vests
for "_j" from 0 to (_maxVestSlots - _minVestSlots + floor random _minVestSlots) do
	{
		_g = _vests call BIS_fnc_selectRandom;
		if not((_g select 0) in _blackList) then
			{
				_crate addItemCargoGlobal [_g select 0, _g select 1];
			};
	};

// Helmets / caps / berets / bandanas
for "_j" from 0 to (_maxHeadGearSlots - _minHeadGearSlots + floor random _minHeadGearSlots) do
	{
		_g = _headGear call BIS_fnc_selectRandom;
		if not((_g select 0) in _blackList) then
			{
				_crate addItemCargoGlobal [_g select 0, _g select 1];
			};
	};

// Backpacks
for "_j" from 0 to (_maxBagSlots - _minBagSlots + floor random _minBagSlots) do
	{
		_g = _backpacks call BIS_fnc_selectRandom;
		if not((_g select 0) in _blackList) then
			{
				_crate addBackpackCargoGlobal [_g select 0, _g select 1];
			};
	};

["loadLoot", 1, format["Loot loaded into crate located in '%1' at %2", _locName, mapGridPosition _crate]] ExecVM "exile_vemf_reloaded\sqf\log.sqf";
