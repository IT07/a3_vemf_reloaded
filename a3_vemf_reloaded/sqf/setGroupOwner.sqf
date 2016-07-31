/*
    Author: IT07

    Description:
    handles the transfer of ownership to another given unit/client/object.
    Will transfer complete group to the same (new) owner.

    Params:
    _this select 0: GROUP - the group of which the ownership should be transfered

    Returns:
    nothing
*/

_grp = param [0, grpNull, [grpNull]];
if not(isNull _grp) then
   {
      // Check if HC is enabled
      _hcNbld = "headLessClientSupport" call VEMFr_fnc_config;
      _force = uiNamespace getVariable ["VEMFr_forceAItoClients", nil];
      if not(isNil "_force") then { if (_force isEqualType true) then { if _force then { _hcNbld = -1 } } };

      private "_to";
      if (_hcNbld isEqualTo "yes") then
         {
            _arr = [];
            {
               if (typeOf _x isEqualTo "HeadlessClient_F") then { _arr pushBack [_x, owner _x] };
            } forEach allPlayers;

            if (count _arr > 0) then { _to = call VEMFr_fnc_hc } else { uiNamespace setVariable ["VEMFr_forceAItoClients", true] };
         } else // If Headlessclient setting is not enabled
         {
            if ((count allPlayers) > 0) then
               {
                  _distToX = worldSize;
                  {
                     _dist = _x distance (leader _grp);
                     if (_dist <= _distToX) then
                        {
                           _distToX = _dist;
                           _to = _x;
                        };
                  } forEach allPlayers;
               };
         };

         if not(isNil "_to") then
            {
               _grp setGroupOwner (owner _to);
               waitUntil { if not(local _grp) then {true} else {uiSleep 0.1; false} };
            };
   };
