/*
   Author: IT07

   Description:
   will log all used overrides to the server's RPT

   Returns:
   nothing
*/

{
   if ( isClass _x ) then
      {
         _c1 = configName _x;
         {
            if ( isClass _x ) then
               {
                  _c2 = configName _x;
                  {
                     if ( isClass _x ) then
                        {
                           _c3 = configName _x;
                           {
                              if ( not ( isClass _x ) ) then
                                 {
                                    if not ( isNull ( configFile >> "CfgVemfReloaded" >> _c1 >> _c2 >> _c3 >> ( configName _x ) ) ) then
                                       {
                                          [ "Overrides", 1, format [ "Overriding 'CfgVemfReloaded >> %1 >> %2 >> %3 >> %4'", _c1, _c2, _c3, configName _x ] ] ExecVM ( "log" call VEMFr_fnc_scriptPath );
                                       } else { [ "Overrides", 0, format [ "setting 'CfgVemfReloaded >> %1 >> %2 >> %3 >> %4' does not exist!", _c1, _c2, _c3, configName _x ] ] ExecVM ( "log" call VEMFr_fnc_scriptPath ) };
                                 };
                           } forEach ( configProperties [ configFile >> "CfgVemfReloadedOverrides" >> _c1 >> _c2 >> _c3, "true", false ] );
                        } else
                           {
                              if not ( isNull ( configFile >> "CfgVemfReloaded" >> _c1 >> _c2 >> ( configName _x ) ) ) then
                                 {
                                    [ "Overrides", 1, format [ "Overriding 'CfgVemfReloaded >> %1 >> %2 >> %3'", _c1, _c2, configName _x ] ] ExecVM ( "log" call VEMFr_fnc_scriptPath );
                                 } else { [ "Overrides", 0, format [ "setting 'CfgVemfReloaded >> %1 >> %2 >> %3' does not exist!", _c1, _c2, configName _x ] ] ExecVM ( "log" call VEMFr_fnc_scriptPath ) };
                           };
                  } forEach ( configProperties [ configFile >> "CfgVemfReloadedOverrides" >> _c1 >> _c2, "true", false ] );
               } else
                  {
                     if not ( isNull ( configFile >> "CfgVemfReloaded" >> _c1 >> ( configName _x ) ) ) then
                        {
                           [ "Overrides", 1, format [ "Overriding 'CfgVemfReloaded >> %1 >> %2", _c1, configName _x ] ] ExecVM ( "log" call VEMFr_fnc_scriptPath );
                        } else { [ "Overrides", 0, format [ "setting 'CfgVemfReloaded >> %1 >> %2' does not exist!", _c1, configName _x ] ] ExecVM ( "log" call VEMFr_fnc_scriptPath ) };
                  };
         } forEach ( configProperties [ configFile >> "CfgVemfReloadedOverrides" >> _c1, "true", false] );
      } else
         {
            if not ( isNull ( configFile >> "CfgVemfReloaded" >> ( configName _x ) ) ) then { [ "Overrides", 1, format [ "Overriding 'CfgVemfReloaded >> %1'", configName _x ] ] ExecVM ( "log" call VEMFr_fnc_scriptPath ) }
            else { [ "Overrides", 0, format [ "setting 'CfgVemfReloaded >> %1' does not exist!", configName _x ] ] ExecVM ( "log" call VEMFr_fnc_scriptPath ) };
         };
} forEach ( configProperties [ configFile >> "CfgVemfReloadedOverrides", "true", false ] );
