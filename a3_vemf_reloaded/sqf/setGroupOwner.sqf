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

_grp = _this select 0;
if not ( isNull _grp ) then
   {
      // Check if HC is enabled
      _hcNbld = "headLessClientSupport" call VEMFr_fnc_config;
      _force = uiNamespace getVariable [ "VEMFr_forceAItoClients", nil ];
      if not ( isNil "_force" ) then { if ( _force isEqualType true ) then { if _force then { _hcNbld = -1 } } };

      private "_to";
      if ( _hcNbld isEqualTo "yes" ) then
         {
            _to = call VEMFr_fnc_hc;
            if ( isNil "_to" ) then { uiNamespace setVariable [ "VEMFr_forceAItoClients", true ] };
         };
      if ( ( _hcNbld isEqualTo "no" ) OR ( uiNamespace getVariable [ "VEMFr_forceAItoClients", false ] ) ) then
         {
            if ( ( count allPlayers ) > 0 ) then
               {
                  _distToX = worldSize;
                  {
                     _dist = _x distance ( leader _grp );
                     if ( _dist <= _distToX ) then
                        {
                           _distToX = _dist;
                           _to = _x;
                        };
                  } forEach allPlayers;
               };
         };

         if not ( isNil "_to" ) then
            {
               _grp setGroupOwner ( owner _to );
               _grp setVariable [ "isVEMFrGroupLocal", false, true ];
            };
   };
