/*
	Author: IT07

	Description:
	loads loot crate inventory

	Params:
	_this: ARRAY
	_this select 0: OBJECT - the crate

	Returns:
	BOOL - true if everything went ok
*/
private ["_ok","_crate"];
_ok = false;
_crate = param [0, objNull, [objNull]];
if not isNull _crate then
	{
		_crate setVariable ["VEMFrCrate", 1, true];
		clearBackpackCargoGlobal  _crate;
		clearItemCargoGlobal _crate;
		clearMagazineCargoGlobal _crate;
		clearWeaponCargoGlobal _crate;
		private ["_settings"];
		_settings = [
			["crateLoot"],
			[
				"primarySlotsMax","primarySlotsMin","secondarySlotsMax","secondarySlotsMin","magSlotsMax","magSlotsMin","attSlotsMax","attSlotsMin","itemSlotsMax","itemSlotsMin",
				"vestSlotsMax","vestSlotsMin","headGearSlotsMax","headGearSlotsMin","bagSlotsMax","bagSlotsMin","primaryWeaponLoot","secondaryWeaponLoot","magLoot","attLoot",
				"itemLoot","vestLoot","backpackLoot","headGearLoot","blackListLoot"
			]
		] call VEMFr_fnc_getSetting;
		private [
			"_maxPrim","_minPrim","_maxSec","_minSec","_maxMagSlots","_minMagSlots","_maxAttSlots","_minAttSlots","_maxItemSlots","_minItemSlots","_maxVestSlots","_minVestSlots",
			"_maxHeadGearSlots","_minHeadGearSlots","_maxBagSlots","_minBagSlots","_primaries","_secondaries","_magazines","_attachments","_items","_vests","_backpacks","_headGear","_blackList"
		];

		_maxPrim = _settings select 0;
		_minPrim = _settings select 1;
		_maxSec = _settings select 2;
		_minSec = _settings select 3;
		_maxMagSlots = _settings select 4;
		_minMagSlots = _settings select 5;
		_maxAttSlots = _settings select 6;
		_minAttSlots = _settings select 7;
		_maxItemSlots = _settings select 8;
		_minItemSlots = _settings select 9;
		_maxVestSlots = _settings select 10;
		_minVestSlots = _settings select 11;
		_maxHeadGearSlots = _settings select 12;
		_minHeadGearSlots = _settings select 13;
		_maxBagSlots = _settings select 14;
		_minBagSlots = _settings select 15;
		_primaries = _settings select 16;
		_secondaries = _settings select 17;
		_magazines = _settings select 18;
		_attachments = _settings select 19;
		_items = _settings select 20;
		_vests = _settings select 21;
		_backpacks = _settings select 22;
		_headGear = _settings select 23;
		_blackList = _settings select 24;

		// Add primary weapons
		for "_j" from 0 to (_maxPrim - _minPrim + floor random _minPrim) do
			{
				private ["_prim"];
				_prim = _primaries call BIS_fnc_selectRandom;
				if not((_prim select 0) in _blackList) then
					{
						_crate addWeaponCargoGlobal [_prim select 0, _prim select 1];
					};
			};
		// Secondary weapons
		for "_j" from 0 to (_maxSec - _minSec + floor random _minSec) do
			{
				private ["_sec"];
				_sec = _secondaries call BIS_fnc_selectRandom;
				if not((_sec select 0) in _blackList) then
					{
						_crate addWeaponCargoGlobal [_sec select 0, _sec select 1];
					};
			};
		// Magazines
		for "_j" from 0 to (_maxMagSlots - _minMagSlots + floor random _minMagSlots) do
			{
				private ["_mag"];
				_mag = _magazines call BIS_fnc_selectRandom;
				if not((_mag select 0) in _blackList) then
					{
						_crate addMagazineCargoGlobal [_mag select 0, _mag select 1];
					};
			};
		// Weapon attachments
		for "_j" from 0 to (_maxAttSlots - _minAttSlots + floor random _minAttSlots) do
			{
				private ["_att"];
				_att = _attachments call BIS_fnc_selectRandom;
				if not((_att select 0) in _blackList) then
					{
						_crate addItemCargoGlobal [_att select 0, _att select 1];
					};
			};
		// Items
		for "_j" from 0 to (_maxItemSlots - _minItemSlots + floor random _minItemSlots) do
			{
				private ["_item"];
				_item = _items call BIS_fnc_selectRandom;
				if not((_item select 0) in _blacklist) then
					{
						_crate addItemCargoGlobal [_item select 0, _item select 1];
					};
			};
		// Vests
		for "_j" from 0 to (_maxVestSlots - _minVestSlots + floor random _minVestSlots) do
			{
				private ["_vest"];
				_vest = _vests call BIS_fnc_selectRandom;
				if not((_vest select 0) in _blackList) then
					{
						_crate addItemCargoGlobal [_vest select 0, _vest select 1];
					};
			};
		// Helmets / caps / berets / bandanas
		for "_j" from 0 to (_maxHeadGearSlots - _minHeadGearSlots + floor random _minHeadGearSlots) do
			{
				private ["_headGearItem"];
				_headGearItem = _headGear call BIS_fnc_selectRandom;
				if not((_headGearItem select 0) in _blackList) then
					{
						_crate addItemCargoGlobal [_headGearItem select 0, _headGearItem select 1];
					};
			};
		// Backpacks
		for "_j" from 0 to (_maxBagSlots - _minBagSlots + floor random _minBagSlots) do
			{
				private ["_pack"];
				_pack = _backpacks call BIS_fnc_selectRandom;
				if not((_pack select 0) in _blackList) then
					{
						_crate addBackpackCargoGlobal [_pack select 0, _pack select 1];
					};
			};
		_ok = true;
	};
_ok
