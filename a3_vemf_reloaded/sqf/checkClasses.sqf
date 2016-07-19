/*
    Author: IT07

    Description:
    checks the VEMF loot table for invalid classnames. Reports to RPT if invalid classes found.

    Params:
    none

    Returns:
    nothing
*/

if (("validateLoot" call VEMFr_fnc_config) isEqualTo 1) then
{ // _validateLoot is enabled, go ahead...
   if (("debugMode" call VEMFr_fnc_config) < 1) then { ["checkLoot", 0, "Can not validate classnames: no output allowed in RPT"] ExecVM ("log" call VEMFr_fnc_scriptPath) }
      else
         {
            ["checkLoot",1,"Validating VEMFr config classes..."] ExecVM ("log" call VEMFr_fnc_scriptPath);
            uiSleep 0.5;
            _bin = [];
            _cfgMags = [];
            "_cfgMags pushBack (toLower (configName _x)); true" configClasses (configFile >> "cfgMagazines");

            _cfgWpns = [];
            "_cfgWpns pushBack (toLower (configName _x)); true" configClasses (configFile >> "cfgWeapons");

            _cfgBags = "(toLower (getText (_x >> 'vehicleClass'))) isEqualTo 'backpacks'" configClasses (configFile >> "cfgVehicles");
            { _cfgBags set [_forEachIndex, toLower (configName _x)] } forEach _cfgBags;

            _cfgGlasses = [];
            "_cfgGlasses pushBack (toLower (configName _x)); true" configClasses (configFile >> "CfgGlasses");

            if (("Apex" call VEMFr_fnc_modAppID) in (getDLCs 1)) then
               {
                  { { if not(((toLower _x) in _cfgMags) OR ((toLower _x) in _cfgWpns) OR ((toLower _x) in _cfgBags) OR ((toLower _x) in _cfgGlasses)) then { _bin pushBack (toLower _x) } } forEach _x } forEach ([["aiInventory","ApexBandits"],["backpacks","faceWear","headGear","launchers","rifles","uniforms","vests"]] call VEMFr_fnc_config);
                  { { if not(((toLower _x) in _cfgMags) OR ((toLower _x) in _cfgWpns) OR ((toLower _x) in _cfgBags) OR ((toLower _x) in _cfgGlasses)) then { _bin pushBack (toLower _x) } } forEach _x } forEach ([["aiInventory","Gendarmerie"],["headGear","faceWear","pistols","rifles","uniforms","vests"]] call VEMFr_fnc_config);
                  { { _x0 = toLower (_x select 0); if not((_x0 in _cfgMags) OR (_x0 in _cfgWpns) OR (_x0 in _cfgBags) OR (_x in _cfgGlasses)) then { _bin pushBack (toLower _x) } } forEach _x } forEach ([["missionSettings","DynamicLocationInvasion","crateLootApex"],["attachments","backpacks","headGear","headGearSpecial","magazines","pistols","rifles","vests"]] call VEMFr_fnc_config);
               };
            { { if not(((toLower _x) in _cfgMags) OR ((toLower _x) in _cfgWpns) OR ((toLower _x) in _cfgBags) OR ((toLower _x) in _cfgGlasses)) then { _bin pushBack (toLower _x) } } forEach _x } forEach ([["aiInventory","Guerilla"],["backpacks","headGear","launchers","pistols","rifles","uniforms","vests"]] call VEMFr_fnc_config);
            { { if not(((toLower _x) in _cfgMags) OR ((toLower _x) in _cfgWpns) OR ((toLower _x) in _cfgBags) OR ((toLower _x) in _cfgGlasses)) then { _bin pushBack (toLower _x) } } forEach _x } forEach ([["aiInventory","PoliceRegular"],["headGear","pistols","rifles","uniforms","vests"]] call VEMFr_fnc_config);
            { { if not(((toLower _x) in _cfgMags) OR ((toLower _x) in _cfgWpns) OR ((toLower _x) in _cfgBags) OR ((toLower _x) in _cfgGlasses)) then { _bin pushBack (toLower _x) } } forEach _x } forEach ([["aiInventory","PoliceSpecialForces"],["faceWear","headGear","pistols","rifles","uniforms","vests"]] call VEMFr_fnc_config);

            { { _x0 = toLower (_x select 0); if not((_x0 in _cfgMags) OR (_x0 in _cfgWpns) OR (_x0 in _cfgBags) OR (_x in _cfgGlasses)) then { _bin pushBack _x } } forEach _x } forEach ([["missionSettings","DynamicLocationInvasion","crateLootVanilla"],["attachments","backpacks","headGear",format["itemsLoot%1", call VEMFr_fnc_whichMod],"magazines","pistols","rifles","vests"]] call VEMFr_fnc_config);

            if ((count _bin) isEqualTo 0) then { ["checkLoot", 1, "All classnames are valid! :)"] ExecVM ("log" call VEMFr_fnc_scriptPath) }
               else { ["checkLoot",0,format["Invalid classes found in config! | %1", _bin]] ExecVM ("log" call VEMFr_fnc_scriptPath) };
         };
   };
