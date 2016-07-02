/*
    Author: IT07

    Description:
    checks the VEMF loot table for invalid classnames. Reports to RPT if invalid classes found.

    Params:
    none

    Returns:
    nothing
*/

if ("validateLoot" call VEMFr_fnc_config isEqualTo 1) then
{ // _validateLoot is enabled, go ahead...
    if ("debugMode" call VEMFr_fnc_config < 1) then
    {
      ["CheckLoot", 0, "Failed to validate loot: no output allowed in RPT"] ExecVM "exile_vemf_reloaded\sqf\log.sqf";
    } else
    {
      ["CheckLoot", 1, "Validating loot tables..."] ExecVM "exile_vemf_reloaded\sqf\log.sqf";
      _bin = [];

      _mags = [];
      _cfgMags = "_mags pushBack (configName _x); true" configClasses (configFile >> "cfgMagazines");

      _weapons = [];
      _cfgWeapons = "_weapons pushBack (configName _x); true" configClasses (configFile >> "cfgWeapons");

      _bags = [];
      _cfgBags = "getText (_x >> 'vehicleClass') isEqualTo 'Backpacks'" configClasses (configFile >> "cfgVehicles");
      {
          _bags pushBack (configName _x);
      } forEach _cfgBags;

      _aiGear = [["aiGear"],["aiUniforms","aiVests","aiRifles","aiBackpacks","aiLaunchers","aiPistols"]] call VEMFr_fnc_config;
      {
          {
              if not((_x in _mags) OR (_x in _weapons) OR (_x in _bags)) then
              {
                  _bin pushBack _x;
              };
          } forEach _x;
      } forEach _aiGear;

      _loot = [["crateLoot"],["primaryWeaponLoot","secondaryWeaponLoot","magazinesLoot","attachmentsLoot","itemsLoot","vestsLoot","headGearLoot","backpacksLoot"]] call VEMFr_fnc_config;
      {
          {
              _class = _x select 0;
              if not((_class in _mags) OR (_class in _weapons) OR (_class in _bags)) then
              {
                  _bin pushBack _x;
              };
          } forEach _x;
      } forEach _loot;

      if (count _bin isEqualTo 0) then
      {
         ["CheckLoot", 1, "Loot tables are all valid :)"] ExecVM "exile_vemf_reloaded\sqf\log.sqf";
      } else
      {
         ["CheckLoot", 0, format["Invalid classes found in loot! | %1", _bin]] ExecVM "exile_vemf_reloaded\sqf\log.sqf";
      };
    };
};
