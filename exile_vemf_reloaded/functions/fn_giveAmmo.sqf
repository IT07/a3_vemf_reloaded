/*
    Author: IT07

    Description:
    Adds magazines to given unit's vest/backpack if it flairTypes

    Params:
    _this: ARRAY
    _this select 0: OBJECT - unit to give ammo to

    Returns:
    BOOLEAN - true if successful
*/

private ["_done"];
_done = false;
if (_this isEqualType []) then
{
    private ["_unit"];
    _unit = param [0, objNull, [objNull]];
    if not isNull _unit then
    {
        if local _unit then
        {
            if not(primaryWeapon _unit isEqualTo "") then
            {
                if not(vest _unit isEqualTo "") then
                {
                    private ["_itemMass","_weapon","_mag","_magMass","_vestMass","_itemMass"];
                    _weapon = primaryWeapon _unit;
                    _mag = selectRandom (getArray (configFile >> "CfgWeapons" >> _weapon >> "magazines"));
                    _magMass = getNumber (configFile >> "CfgMagazines" >> _mag >> "mass");
                    _vestMass = getNumber (configFile >> "CfgWeapons" >> (vest _unit) >> "ItemInfo" >> "mass");
                    {
                        _itemMass = getNumber (configFile >> "CfgMagazines" >> _x >> "ItemInfo" >> "mass");
                        if (_itemMass isEqualTo 0) then
                        {
                            _itemMass = getNumber (configFile >> "CfgWeapons" >> _x >> "WeaponSlotsInfo" >> "mass");
                        };
                        _vestMass = _vestMass - _itemMass;
                    } forEach (vestItems _unit);
                    if (_vestMass >= _magMass) then
                    {
                        for "_m" from 1 to (round(_vestMass / _magMass)) do
                        {
                            _unit addItemToVest _mag;
                        };
                    };
                };
            };
            if not (secondaryWeapon _unit isEqualTo "") then
            {
                if not(backPack _unit isEqualTo "") then
                {
                    private ["_weapon","_mag","_magMass"];
                    _weapon = secondaryWeapon _unit;
                    _mag = selectRandom (getArray (configFile >> "CfgWeapons" >> _weapon >> "magazines"));
                    _magMass = getNumber (configFile >> "CfgMagazines" >> _mag >> "mass");
                    if not(backpack _unit isEqualTo "") then
                    {
                        private ["_packMass"];
                        _packMass = getNumber (configFile >> "CfgVehicles" >> (backpack _unit) >> "mass");
                        {
                            private ["_itemMass"];
                            _itemMass = getNumber (configFile >> "CfgMagazines" >> _x >> "mass");
                            if (_itemMass isEqualTo 0) then
                            {
                                _itemMass = getNumber (configFile >> "CfgWeapons" >> _x >> "WeaponSlotsInfo" >> "mass");
                            };
                            _packMass = _packMass - _itemMass;
                        } forEach (backpackItems _unit);
                        if (_packMass >= _magMass) then
                        {
                            for "_m" from 1 to (round(_packMass / _magMass)) do
                            {
                                _unit addItemToBackpack _mag;
                            };
                        };
                    };
                };
            };
            if not (handGunWeapon _unit isEqualTo "") then
            {
                if not(uniform _unit isEqualTo "") then
                {
                    private ["_weapon","_mag","_uniformMass"];
                    _weapon = handGunWeapon _unit;
                    _mag = selectRandom (getArray (configFile >> "CfgWeapons" >> _weapon >> "magazines"));
                    _magMass = getNumber (configFile >> "CfgMagazines" >> _mag >> "mass");
                    _uniformMass = getNumber (configFile >> "CfgWeapons" >> (uniform _unit) >> "ItemInfo" >> "mass");
                    {
                        private ["_itemMass"];
                        _itemMass = getNumber (configFile >> "CfgMagazines" >> _x >> "mass");
                        if (_itemMass isEqualTo 0) then
                        {
                            _itemMass = getNumber (configFile >> "CfgWeapons" >> _x >> "WeaponSlotsInfo" >> "mass");
                        };
                        _uniformMass = _uniformMass - _itemMass;
                    } forEach (uniformItems _unit);
                    for "_m" from 1 to (round(_uniformMass / _magMass)) do
                    {
                        _unit addItemToUniform _mag;
                    };
                };
            };
            _done = true;
        };
        if not local _unit then
        {
            ["fn_giveAmmo", 0, format["%1 is not local. Can not execute!", _unit]] spawn VEMfr_fnc_log;
        };
    };
    if isNull _unit then
    {
        ["fn_giveAmmo", 0, "_unit isNull. Can not execute!"] spawn VEMFr_fnc_log;
    };
};

_done
