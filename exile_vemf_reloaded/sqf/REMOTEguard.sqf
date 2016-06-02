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

uiNamespace setVariable ["VEMFrHcLoad", []];
uiNamespace setVariable ["VEMFrAIgroups", []];
while {true} do
   {
      _groups = uiNamespace getVariable "VEMFrAIgroups";
      waitUntil {if (count _groups > 0) then {true} else {uiSleep 1; false} };
      {
         if (local _x) then
            {
               if ((count units _x) < 1) then
                  {
                     deleteGroup _x;
                  };
               if (count (units _x) > 0) then
                  {
                     // Group still has units, check if there is anyone that can be the owner
                     [_x] ExecVM "exile_vemf_reloaded\sqf\transferOwner.sqf";
                  };
            };
      } forEach _groups;
   };
