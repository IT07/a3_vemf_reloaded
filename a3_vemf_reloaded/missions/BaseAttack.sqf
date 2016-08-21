/*
   Author: IT07

   Description:
   a mission for VEMFr that will paradrop units above a randomly selected base
*/

VEMFrMissionCount = VEMFrMissionCount + 1;
_mn = _this select 0;
if ( isNil "VEMFrAttackCount" ) then { VEMFrAttackCount = 0 };
VEMFrAttackCount = VEMFrAttackCount + 1;
( [ [ "missionSettings", _mn ], [ "maxAttacks", "aiSetup", "minimumLevel", "randomModes", "minimumWait" ] ] call VEMFr_fnc_config ) params [ "_s0", "_s1", "_s2", "_s3", "_s4" ];
if ( VEMFrAttackCount <= _s0 ) then
   {
      scopeName "outer";
      _mod = call VEMFr_fnc_whichMod;
      _hist = uiNamespace getVariable [ "VEMFrAttackedBases", [] ];
      _objs = [];
      {
         if ( ( ( speed _x ) < 25 ) AND ( ( vehicle _x ) isEqualTo _x ) ) then
            {
               if ( _mod isEqualTo "Exile" ) then
                  {
                     {
                        if ( not ( _x in _hist ) AND ( ( _x getVariable "ExileTerritoryLevel" ) >= _s2 ) ) then { _objs pushBack _x };
                     } forEach ( nearestObjects [ position _x, [ "Exile_Construction_Flag_Static" ], 150 ] );
                  };
               if (_mod isEqualTo "Epoch") then
                  {
                     {
                        if not ( _x in _hist ) then { _objs pushBack _x };
                     } forEach ( nearestObjects [ position _x, [ "PlotPole_EPOCH" ], 150 ] );
                  };
            };
      } forEach allPlayers;

      if ( ( count _objs ) > 0 ) then
         {
            _base = selectRandom _objs;
            _hist pushBack _base;
            uiNamespace setVariable [ "VEMFrAttackedBases", _hist ];
            _pos = position _base;
            private "_c";
            if ( _mod isEqualTo "Epoch" ) then { _c = [ "Epoch_Male_F", "Epoch_Female_F", "Epoch_Female_Camo_F", "Epoch_Female_CamoBlue_F", "Epoch_Female_CamoBrn_F", "Epoch_Female_CamoRed_F", "Epoch_Female_Ghillie3_F", "Epoch_Female_Ghillie2_F", "Epoch_Female_Ghillie1_F", "Epoch_Female_Wetsuit_F", "Epoch_Female_WetsuitB_F", "Epoch_Female_WetsuitC_F", "Epoch_Female_WetsuitP_F", "Epoch_Female_WetsuitW_F" ] };
            if ( _mod isEqualTo "Exile" ) then { _c = [ "Exile_Unit_Player" ] };
            _a = nearestObjects [ _pos, _c, _base getVariable [ "ExileTerritorySize", 200 ] ];
            if ( ( count _a ) > 0 ) then
               {
                  for "_i" from 0 to _s4 do
                     {
                        if ( ( count ( nearestObjects [ _pos, _c, _base getVariable [ "ExileTerritorySize", 120 ] ] ) ) > 0 ) then { uiSleep ( 60 + ( round random 30 ) ) } else { breakOut "outer" };
                     };
               };
            _nrPlyr = selectRandom _a;
            if not ( isNil "_nrPlyr" ) then
               {
                  _baseNm = "a base";
                  if ( _mod isEqualTo "Exile" ) then { _baseNm = _base getVariable [ "exileterritoryname", "ERROR: UNKNOWN NAME" ] };
                  _m = ( [ ( [ _mod ] ), ( [ "aiMode" ] ) ] call VEMFr_fnc_config ) select 0;
                  if ( _s3 isEqualTo "yes" ) then { _m = [ 0, 1, 2 ]; if ( ( "Apex" call VEMFr_fnc_modAppID ) in ( getDLCs 1 ) ) then { _m pushBack 3; _m pushBack 4 }; _m = selectRandom _m };
                  _prGrps = [ _pos, _s1 select 0, _s1 select 1, _m, _mn, 1000 + ( random 1000 ), 150 ] call VEMFr_fnc_spawnVEMFrAI;
                  if not ( isNil "_prGrps" ) then
                     {
                        _ntCnt = 0;
                        {
                           if ( count ( units _x ) isEqualTo ( _s1 select 1 ) ) then { _ntCnt = _ntCnt + ( count ( units _x ) ) };
                        } forEach _prGrps;

                        if ( _ntCnt isEqualTo ( ( _s1 select 0 ) * ( _s1 select 1 ) ) ) then
                           {
                              _wyPnts = [];
                              _nts = [];
                              {
                                 _wp = _x addWaypoint [ _pos, 50, 1 ];
                                 _wp setWaypointBehaviour "COMBAT";
                                 _wp setWaypointCombatMode "RED";
                                 _wp setWaypointCompletionRadius 10;
                                 _wp setWaypointFormation "DIAMOND";
                                 _wp setWaypointSpeed "FULL";
                                 _wp setWaypointType "SAD";
                                 _x setCurrentWaypoint _wp;
                                 _wyPnts pushback _wp;
                                 { _nts pushback _x } forEach ( units _x );
                                 [ _x ] ExecVM ( "signAI" call VEMFr_fnc_scriptPath );
                              } forEach _prGrps;
                              _plyrs = nearestObjects [ _pos, _c, 275 ];

                              [ "a", _plyrs ] ExecVM ( "warningToClient" call VEMFr_fnc_scriptPath );
                              [ "BaseAttack", 1, format [ "a para team is on the way to %1 @ %2's location!", _baseNm, name _nrPlyr ] ] ExecVM ( "log" call VEMFr_fnc_scriptPath );

                              _h = [ _nts, _mn ] ExecVM ( "killedMonitor" call VEMFr_fnc_scriptPath );
                              _loop = [ _pos, _c ] spawn {
                                 params [ "_pos", "_c" ];
                                 while { true } do
                                    {
                                       [ "a", nearestObjects [ _pos, _c, 275 ] ] ExecVM ( "warningToClient" call VEMFr_fnc_scriptPath );
                                       uiSleep 15;
                                    };
                              };
                     			waitUntil { if ( scriptDone _h ) then { terminate _loop; true } else { uiSleep 1; false } };

                              _plyrs = nearestObjects [ _pos, _c, 275 ];
                              [ "d", _plyrs ] ExecVM ( "warningToClient" call VEMFr_fnc_scriptPath );
                              breakOut "outer";
                           } else
                              {
                                 {
                                    {
                                       deleteVehicle _x;
                                    } forEach (units _x);
                                 } forEach _prGrps;
                                 [ "BaseAttack", 0, format [ "incorrect amount of total units (%1). Should be %2", _ntCnt, (_s1 select 0) * (_s1 select 1) ] ] ExecVM ( "log" call VEMFr_fnc_scriptPath );
                                 breakOut "outer";
                              };
                     } else
                        {
                           [ "BaseAttack", 0, format [ "incorrect spawned group count (%1). Should be %2", count _prGrps, _s1 select 0 ] ] ExecVM ( "log" call VEMFr_fnc_scriptPath );
                           breakOut "outer";
                        };
               } else
                  {
                     _hist deleteAt ( _hist find _base );
                     [ "BaseAttack", 0, "can not find player near base!" ] ExecVM ( "log" call VEMFr_fnc_scriptPath );
                     breakOut "outer";
                  };
         } else { breakOut "outer" };
   };
VEMFrAttackCount = VEMFrAttackCount - 1;
VEMFrMissionCount = VEMFrMissionCount - 1;
