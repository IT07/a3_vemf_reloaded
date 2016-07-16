/*
   Author: IT07

   Description:
   A simple mission for VEMFr that sends a chopper to a player's territory and paradrops all units inside
*/

VEMFrMissionCount = VEMFrMissionCount + 1;
_mn = param [0, "", [""]];
if (isNil "VEMFrAttackCount") then { VEMFrAttackCount = 0 };
VEMFrAttackCount = VEMFrAttackCount + 1;
_s = [[_mn],["maxAttacks","aiSetup","minimumLevel"]] call VEMFr_fnc_config;
_s params ["_s0","_s1","_s2"];
if (VEMFrAttackCount <= _s0) then
{
   scopeName "outer";
   if (_mn in ("missionList" call VEMFr_fnc_config)) then
   {
      if (((_s1 select 0) > 0) AND ((_s1 select 1) > 0)) then
      {
         _hst = uiNamespace getVariable ["VEMFrAttackedFlags",[]];
         _objs = [];
         {
            if (((speed _x) < 25) AND ((vehicle _x) isEqualTo _x)) then
            {
               {
                  if (not(_x in _hst) AND ((_x getVariable ["ExileTerritoryLevel",0]) > _s2)) then { _objs pushBack _x };
               } forEach (nearestObjects [position _x, ["Exile_Construction_Flag_Static"], 150]);
            };
         } forEach allPlayers;

         if (count _objs > 0) then
         {
            _flg = selectRandom _objs;
            _hst pushBack _flg;
            _pos = position _flg;
            _nrPlyr = selectRandom (nearestObjects [_pos, ["Exile_Unit_Player"], 150]);
            if not(isNil "_nrPlyr") then
            {
               _flgNm = _flg getVariable ["exileterritoryname", "ERROR: UNKNOWN NAME"];
               _prGrps = [_pos, _s1 select 0, _s1 select 1, ([[_mn],["aiMode"]] call VEMFr_fnc_config select 0), _mn, 1000 + (random 1000), 150] call VEMFr_fnc_spawnVEMFrAI;
               if not(isNil "_prGrps") then
               {
                  _ntCnt = 0;
                  {
                     if (count (units _x) isEqualTo (_s1 select 1)) then
                     {
                        _ntCnt = _ntCnt + (count(units _x));
                     };
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
                        {
                           _nts pushback _x;
                        } forEach (units _x);
                        [_x] ExecVM "a3_vemf_reloaded\sqf\signAI.sqf";
                     } forEach _prGrps;
                     _plyrs = nearestObjects [_pos, ["Exile_Unit_Player"], 275];
                     [-1, "NEW BASE ATTACK", format["A para team is on the way to %1 @ %2's location!", _flgNm, name _nrPlyr], _plyrs] ExecVM "a3_vemf_reloaded\sqf\notificationToClient.sqf";
                     ["BaseAttack", 1, format["A para team is on the way to %1 @ %2's location!", _flgNm, name _nrPlyr]] ExecVM ("log" call VEMFr_fnc_scriptPath);

                     while {true} do
                     {
                        scopeName "loop";
                        _ddCnt = 0;
                        {
                           if (damage _x isEqualTo 1 OR isNull _x) then
                           {
                              _ddCnt = _ddCnt + 1;
                           };
                        } forEach _nts;
                        if (_ddCnt isEqualTo _ntCnt) then
                        {
                           breakOut "loop";
                        } else
                        {
                           uiSleep 4;
                        };
                     };
                     _plyrs = nearestObjects [_pos, ["Exile_Unit_Player"], 275];
                     [-1, "DEFEATED", format["Base attack on %1 has been defeated!", _flgNm], _plyrs] ExecVM "a3_vemf_reloaded\sqf\notificationToClient.sqf";
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
               _hst deleteAt (_hst find _flg);
               ["BaseAttack", 0, "Can not find player near flag!"] ExecVM ("log" call VEMFr_fnc_scriptPath);
               breakOut "outer";
            };
         } else
         {
            breakOut "outer";
         };
      } else
      {
         ["BaseAttack", 0, format["invalid aiSetup setting! (%1)", _s1]] ExecVM ("log" call VEMFr_fnc_scriptPath);
         breakOut "outer";
      };
   } else
   {
      ["BaseAttack", 0, format["Failed to start mission. Given _mn (%1) is not in active missionList", _mn]] ExecVM ("log" call VEMFr_fnc_scriptPath);
   };
};
VEMFrAttackCount = VEMFrAttackCount - 1;
VEMFrMissionCount = VEMFrMissionCount - 1;
