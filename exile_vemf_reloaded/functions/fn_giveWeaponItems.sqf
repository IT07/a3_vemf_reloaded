/*
    Author: IT07

    Description:
    Gives random weapon attachments to given unit

    Params:
    _this: ARRAY
    _this select 0: OBJECT - unit

    Returns: BOOLEAN - if not isNull _unit, returns true
*/

private ["_done","_unit","_randomPattern","_primaryWeapon","_unit","_handgunWeapon"];
_done = false;
if (_this isEqualType []) then
{
    _unit = param [0, objNull, [objNull]];
    if not (isNull _unit) then
    {
        // primaryWeapon items
        private ["_randomPattern"];
        _randomPattern = [1,0,1,0,1,1,1,1,0,0,1,1,1];
        _primaryWeapon = primaryWeapon _unit;
        if (selectRandom _randomPattern isEqualTo 1) then
        { // Select random scope
            _scopes = getArray (configFile >> "CfgWeapons" >> _primaryWeapon >> "WeaponSlotsInfo" >> "CowsSlot" >> "compatibleItems");
            if ([["DynamicLocationInvasion"],["allowTWS"]] call VEMFr_fnc_getSetting isEqualTo 0) then
            {
                private["_indexes"];
                _indexes = [];
                {
                    if not(_x find "tws" isEqualTo -1) then
                    {
                        _indexes pushBack _forEachIndex;
                    };
                    if not(_x find "TWS" isEqualTo -1) then
                    {
                        _indexes pushBack _forEachIndex;
                    };
                } forEach _scopes;
                if (count _indexes > 0) then
                {
                    {
                        _scopes deleteAt _x;
                    } forEach _indexes;
                };
            };
            _unit addPrimaryWeaponItem (selectRandom _scopes);
        };
        if (selectRandom _randomPattern isEqualTo 1) then
        { // Select random muzzle
            _unit addPrimaryWeaponItem (selectRandom (getArray (configFile >> "CfgWeapons" >> _primaryWeapon >> "WeaponSlotsInfo" >> "MuzzleSlot" >> "compatibleItems")));
        };
        if (selectRandom _randomPattern isEqualTo 1) then
        { // Select random pointer
            _unit addPrimaryWeaponItem (selectRandom (getArray (configFile >> "CfgWeapons" >> _primaryWeapon >> "WeaponSlotsInfo" >> "PointerSlot" >> "compatibleItems")));
        };
        if (selectRandom _randomPattern isEqualTo 1) then
        { // Select random bipod
            _unit addPrimaryWeaponItem (selectRandom (getArray (configFile >> "CfgWeapons" >> _primaryWeapon >> "WeaponSlotsInfo" >> "UnderbarrelSlot" >> "compatibleItems")));
        };

        // handgunWeapon items
        _handgunWeapon = handgunWeapon _unit;
        _randomPattern = [1,0,1,0,0,1,0,0,0,0,1,1,1];
        if (selectRandom _randomPattern isEqualTo 1) then
        { // Select random scope
            _unit addSecondaryWeaponItem (selectRandom (getArray (configFile >> "CfgWeapons" >> _handgunWeapon >> "WeaponSlotsInfo" >> "CowsSlot" >> "compatibleItems")));
        };
        if (selectRandom _randomPattern isEqualTo 1) then
        { // Select random muzzle
            _unit addSecondaryWeaponItem (selectRandom (getArray (configFile >> "CfgWeapons" >> _handgunWeapon >> "WeaponSlotsInfo" >> "MuzzleSlot" >> "compatibleItems")));
        };
        _done = true;
    };
};
_done
