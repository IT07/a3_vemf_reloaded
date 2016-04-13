/*
    Author: IT07

    Description:
    checks the VEMF loot table for invalid classnames. Reports to RPT if invalid classes found.

    Params:
    none

    Returns:
    nothing
*/

if ("validateLoot" call VEMFr_fnc_getSetting isEqualTo 1) then
{ // _validateLoot is enabled, go ahead...
    if ("debugMode" call VEMFr_fnc_getSetting < 1) then
    {
      ["CheckLoot", 0, "Failed to validate loot: no output allowed in RPT"] spawn VEMFr_fnc_log;
    } else
    {
      ["CheckLoot", 1, "Validating loot tables..."] spawn VEMFr_fnc_log;
      _invalidClasses = [];

      _mags = [];
      _cfgMags = "_mags pushBack (configName _x); true" configClasses (configFile >> "cfgMagazines");

      _weapons = [];
      _cfgWeapons = "_weapons pushBack (configName _x); true" configClasses (configFile >> "cfgWeapons");

      _bags = [];
      _cfgBags = "getText (_x >> 'vehicleClass') isEqualTo 'Backpacks'" configClasses (configFile >> "cfgVehicles");
      {
          _bags pushBack (configName _x);
      } forEach _cfgBags;

      _aiGear = [["aiGear"],["aiUniforms","aiVests","aiRifles","aiBackpacks","aiLaunchers","aiPistols"]] call VEMFr_fnc_getSetting;
      {
          {
              if not((_x in _mags) OR (_x in _weapons) OR (_x in _bags)) then
              {
                  _invalidClasses pushBack _x;
              };
          } forEach _x;
      } forEach _aiGear;

      _loot = [["crateLoot"],["primaryWeaponLoot","secondaryWeaponLoot","magazinesLoot","attachmentsLoot","itemsLoot","vestsLoot","headGearLoot","backpacksLoot"]] call VEMFr_fnc_getSetting;
      {
          {
              _class = _x select 0;
              if not((_class in _mags) OR (_class in _weapons) OR (_class in _bags)) then
              {
                  _invalidClasses pushBack _x;
              };
          } forEach _x;
      } forEach _loot;

      _invalid = if (count _invalidClasses isEqualTo 0) then { false } else { true };
      switch true do
      {
          case _invalid:
          {
              ["CheckLoot", 0, format["Invalid classes found in loot! | %1", _invalidClasses]] spawn VEMFr_fnc_log;
          };
          case (not _invalid):
          {
              ["CheckLoot", 1, "Loot tables are all valid :)"] spawn VEMFr_fnc_log;
          };
      };
    };
};
