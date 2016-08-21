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

while { true } do
   {
      if ( ( count playableUnits ) > 0 ) then
         {
            {
               if ( ( local _x ) AND ( _x getVariable [ "isVEMFrGroup", false ] ) AND ( _x getVariable [ "isVEMFrGroupLocal", false ] ) ) then
                  {
                     if ( ( count ( units _x ) ) > 0 ) then
                        {
                           // Group still has units, check if there is anyone that can be the owner
                           [ _x ] ExecVM ( "setGroupOwner" call VEMFr_fnc_scriptPath );
                        } else { deleteGroup _x };
                  };
               if ( not ( local _x ) AND ( _x getVariable [ "isVEMFrGroupLocal", false ] ) ) then { _x setVariable [ "isVEMFrGroupLocal", false, true ] };
            } forEach allGroups;
            uiSleep 0.5;
         } else { uiSleep 5 };
   };
