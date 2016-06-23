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

_toTransfer = param [0, grpNull, [grpNull]];
if not(isNull _toTransfer) then
   {
      // Check if HC is enabled
      _hcEnabled = "headLessClientSupport" call VEMFr_fnc_getSetting;
      _forceClients = uiNamespace getVariable ["VEMFr_forceAItoClients", nil];
      if not(isNil "_forceClients") then
         {
            if (_forceClients isEqualType true) then
               {
                  if _forceClients then
                     {
                        _hcEnabled = -1;
                     };
               };
         };

      private ["_to"];
      if (_hcEnabled isEqualTo 1) then
         { // Gather the Headless Client(s)
            _hcClients = [];
            {
               if (typeOf _x isEqualTo "HeadlessClient_F") then // it is an HC
        	         {
                     _hcClients pushBack [_x, owner _x];
                  };
            } forEach allPlayers;
            if (count _hcClients > 0) then
               {
                  _to = call VEMFr_fnc_headlessClient; // Select a random hc
               } else
               {
                  uiNamespace setVariable ["VEMFr_forceAItoClients", true];
               };
         } else // If Headlessclient setting is not enabled
         {
            if ((count allPlayers) > 0) then
               {
                  _distanceToX = worldSize;
                  {
                     _dist = _x distance (leader _toTransfer);
                     if (_dist <= _distanceToX) then
                        {
                           _distanceToX = _dist;
                           _to = _x;
                        };
                  } forEach allPlayers;
               };
         };

         if not(isNil "_to") then
            {
               (uiNamespace getVariable ["VEMFrHcLoad", nil]) pushBack _to;
               _transfer = _toTransfer setGroupOwner (owner _to);
               waitUntil { if not(local _toTransfer) then {true} else {uiSleep 0.1; false} };
               /*_load = uiNamespace getVariable ["VEMFrHcLoad", nil];
               if not(isNil "_load") then
                  {
                     _index = _load find _to;
                     if (_index > -1) then
                        {
                           _load set [_index, ((_load select _index) select 1) + 1];
                        } else
                        {
                           _load pushBack [_to, 1];
                        };
                  };*/
            } else
            {
               ["setGroupOwner",0,format["Unable to find a %1 to transfer to!", if (_hcEnabled isEqualTo 1) then {"HC"} else {"client"}]] ExecVM "exile_vemf_reloaded\sqf\log.sqf";
            };
   } else
   {
      ["setGroupOwner",0,"Can not transfer a non-existent group!"] ExecVM "exile_vemf_reloaded\sqf\log.sqf";
   };
