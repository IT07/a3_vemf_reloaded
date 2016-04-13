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

[] spawn
{
    uiNamespace setVariable ["VEMFrHcLoad", []];
    uiNamespace setVariable ["vemfGroups", []];
    while {true} do
    {
        _groups = uiNamespace getVariable "vemfGroups";
        waitUntil { uiSleep 1; count _groups > 0 };
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
                    [_x] call VEMFr_fnc_transferOwner;
                };
            };
        } forEach _groups;
    };
};
