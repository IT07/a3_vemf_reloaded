/*
    Author: IT07

    Description:
    this function makes sure that AI spawned by VEMF does NOT become local to the server.
    On detection of a local group, it will reassign it to a client or Headless Client if enabled.

    Params:
    none, this is a Standalone function

    Returns:
    nothing
*/

while {true} do
   {
      if ((count playableUnits) > 0) then
         {
            waitUntil {if ((count allGroups) > 0) then {uiSleep 0.25; true} else {uiSleep 0.5; false} };
            {
               if ((local _x) AND (_x getVariable ["isVEMFrGroup",false])) then
                  {
                     if ((count (units _x)) > 0) then
                        {
                           //["REMOTEguard",1,format["Attempting to transfer group: %1", _x]] ExecVM ("log" call VEMFr_fnc_scriptPath);
                           // Group still has units, check if there is anyone that can be the owner
                           _h = [_x] ExecVM ("setGroupOwner" call VEMFr_fnc_scriptPath);
                           waitUntil { if (scriptDone _h) then {true} else {uiSleep 0.1; false} };
                           //["REMOTEguard",1,format["Transfer attempted. Group (%1) is %2", _x, if (local _x) then {"still local!"} else {"now REMOTE"}]] ExecVM ("log" call VEMFr_fnc_scriptPath);
                        } else
                        {
                           deleteGroup _x;
                        };
                  };
            } forEach allGroups;
         } else { uiSleep 5 };
   };
