/*
   Author: IT07

   Description:
   a mission for VEMFr that will paradrop units above a randomly selected base
*/

VEMFrMissionCount = VEMFrMissionCount + 1;
_mn = param [0, "", [""]];
if (isNil "VEMFrAttackCount") then { VEMFrAttackCount = 0 };
VEMFrAttackCount = VEMFrAttackCount + 1;
([["missionSettings",_mn],["maxAttacks","aiSetup","minimumLevel","randomModes"]] call VEMFr_fnc_config) params ["_s0","_s1","_s2","_s3"];
if (VEMFrAttackCount <= _s0) then
   {
      scopeName "outer";
      if (_mn in ("missionList" call VEMFr_fnc_config)) then
         {
            _mod = call VEMFr_fnc_whichMod;
            if (((_s1 select 0) > 0) AND ((_s1 select 1) > 0)) then
               {
                  _hist = uiNamespace getVariable ["VEMFrAttackedBases",[]];
                  _objs = [];
                  {
                     if (((speed _x) < 25) AND ((vehicle _x) isEqualTo _x)) then
                        {
                           if (_mod isEqualTo "Exile") then
                              {
                                 {
                                    if (not(_x in _hist) AND ((_x getVariable ["ExileTerritoryLevel",0]) > _s2)) then { _objs pushBack _x };
                                 } forEach (nearestObjects [position _x, ["Exile_Construction_Flag_Static"], 150]);
                              };
                           if (_mod isEqualTo "Epoch") then
                              {
                                 {
                                    if not(_x in _hist) then { _objs pushBack _x };
                                 } forEach (nearestObjects [position _x, ["PlotPole_EPOCH"], 150]);
                              };
                        };
                  } forEach allPlayers;

                  if ((count _objs) > 0) then
                     {
                        _base = selectRandom _objs;
                        _hist pushBack _base;
                        _pos = position _base;
                        private "_c";
                        if (_mod isEqualTo "Epoch") then { _c = ["Epoch_Male_F","Epoch_Female_F","Epoch_Female_Camo_F","Epoch_Female_CamoBlue_F","Epoch_Female_CamoBrn_F","Epoch_Female_CamoRed_F","Epoch_Female_Ghillie3_F","Epoch_Female_Ghillie2_F","Epoch_Female_Ghillie1_F","Epoch_Female_Wetsuit_F","Epoch_Female_WetsuitB_F","Epoch_Female_WetsuitC_F","Epoch_Female_WetsuitP_F","Epoch_Female_WetsuitW_F"] };
                        if (_mod isEqualTo "Exile") then { _c = ["Exile_Unit_Player"] };
                        _nrPlyr = selectRandom (nearestObjects [_pos, _c, 150]);
                        if not(isNil "_nrPlyr") then
                           {
                              _baseNm = "a base";
                              if (_mod isEqualTo "Exile") then { _baseNm = _base getVariable ["exileterritoryname","ERROR: UNKNOWN NAME"] };
                              _m = ([[_mod],["aiMode"]] call VEMFr_fnc_config) select 0;
                              if (_s3 isEqualTo 1) then { _m = [0,1,2]; if (("Apex" call VEMFr_fnc_modAppID) in (getDLCs 1)) then { _m pushBack 3; _m pushBack 4 }; _m = selectRandom _m };
                              _prGrps = [_pos, _s1 select 0, _s1 select 1, _m, _mn, 1000 + (random 1000), 150] call VEMFr_fnc_spawnVEMFrAI;
                              if not(isNil "_prGrps") then
                                 {
                                    _ntCnt = 0;
                                    {
                                       if (count (units _x) isEqualTo (_s1 select 1)) then { _ntCnt = _ntCnt + (count(units _x)) };
                                    } forEach _prGrps;

                                    if (_ntCnt isEqualTo ((_s1 select 0) * (_s1 select 1))) then
                                       {
                                          _wyPnts = [];
                                          _nts = [];
                                          {
                                             _wp = _x addWaypoint [_pos, 50, 1];
                                             _wp setWaypointBehaviour "COMBAT";
                                             _wp setWaypointCombatMode "RED";
                                             _wp setWaypointCompletionRadius 10;
                                             _wp setWaypointFormation "DIAMOND";
                                             _wp setWaypointSpeed "FULL";
                                             _wp setWaypointType "SAD";
                                             _x setCurrentWaypoint _wp;
                                             _wyPnts pushback _wp;
                                             { _nts pushback _x } forEach (units _x);
                                             [_x] ExecVM ("signAI" call VEMFr_fnc_scriptPath);
                                          } forEach _prGrps;
                                          _plyrs = nearestObjects [_pos, _c, 275];

                                          [-1, "NEW BASE ATTACK", format["A para team is on the way to %1 @ %2's location!", _baseNm, name _nrPlyr], _plyrs] ExecVM ("notificationToClient" call VEMFr_fnc_scriptPath);
                                          ["BaseAttack", 1, format["A para team is on the way to %1 @ %2's location!", _baseNm, name _nrPlyr]] ExecVM ("log" call VEMFr_fnc_scriptPath);

                                          while {true} do
                                             {
                                                scopeName "loop";
                                                _ddCnt = 0;
                                                {
                                                   if (damage _x isEqualTo 1 OR isNull _x) then { _ddCnt = _ddCnt + 1 };
                                                } forEach _nts;
                                                if (_ddCnt isEqualTo _ntCnt) then { breakOut "loop" } else { uiSleep 4 };
                                             };

                                             _plyrs = nearestObjects [_pos, _c, 275];
                                             [-1, "DEFEATED", format["Base-attack on %1 has been defeated!", _baseNm], _plyrs] ExecVM ("notificationToClient" call VEMFr_fnc_scriptPath);
                                             breakOut "outer";
                                       } else
                                          {
                                             {
                                                {
                                                   deleteVehicle _x;
                                                } forEach (units _x);
                                             } forEach _prGrps;
                                             ["BaseAttack", 0, format["Incorrect amount of total units (%1). Should be %2", _ntCnt, (_s1 select 0) * (_s1 select 1)]] ExecVM ("log" call VEMFr_fnc_scriptPath);
                                             breakOut "outer";
                                          };
                                 } else
                                    {
                                       ["BaseAttack", 0, format["Incorrect spawned group count (%1). Should be %2", count _prGrps, _s1 select 0]] ExecVM ("log" call VEMFr_fnc_scriptPath);
                                       breakOut "outer";
                                    };
                           } else
                              {
                                 _hist deleteAt (_hist find _base);
                                 ["BaseAttack", 0, "Can not find player near base!"] ExecVM ("log" call VEMFr_fnc_scriptPath);
                                 breakOut "outer";
                              };
                     } else { breakOut "outer" };
               } else
                  {
                     ["BaseAttack", 0, format["invalid aiSetup setting! (%1)", _s1]] ExecVM ("log" call VEMFr_fnc_scriptPath);
                     breakOut "outer";
                  };
         } else { ["BaseAttack", 0, format["Failed to start mission. Given _mn (%1) is not in active missionList", _mn]] ExecVM ("log" call VEMFr_fnc_scriptPath) };
   };
VEMFrAttackCount = VEMFrAttackCount - 1;
VEMFrMissionCount = VEMFrMissionCount - 1;
