/*
   Author: IT07

   Description:
   A simple mission for VEMFr that sends a chopper to a player's territory and paradrops all units inside
*/

VEMFrMissionCount = VEMFrMissionCount + 1;
_missionName = param [0, "", [""]];
if isNil"VEMFrAttackCount" then { VEMFrAttackCount = 0 };
VEMFrAttackCount = VEMFrAttackCount + 1;
if (VEMFrAttackCount <= ([[_missionName],["maxAttacks"]] call VEMFr_fnc_getSetting select 0)) then
{
   scopeName "outer";
   if (_missionName in ("missionList" call VEMFr_fnc_getSetting)) then
   {
      _aiSetup = ([[_missionName],["aiSetup"]] call VEMFr_fnc_getSetting) select 0;
      if (_aiSetup select 0 > 0 AND _aiSetup select 1 > 0) then
      {
         _attackedFlags = uiNamespace getVariable ["VEMFrAttackedFlags",[]];
         _flags = [];
         {
            if (speed _x < 25 AND (vehicle _x isEqualTo _x)) then
            {
               _flagsObjs = nearestObjects [position _x, ["Exile_Construction_Flag_Static"], 150];
               {
                  if not(_x in _attackedFlags) then
                     {
                        _flags pushBack _x;
                     };
               } forEach _flagsObjs;
            };
         } forEach allPlayers;
         if (count _flags > 0) then
         {
            _flagToAttack = selectRandom _flags;
            _attackedFlags pushBack _flagToAttack;
            _flagPos = position _flagToAttack;
            _nearestPlayer = selectRandom (nearestObjects [_flagPos, ["Exile_Unit_Player"], 150]);
            if not isNil"_nearestPlayer" then
            {
               _flagName = _flagToAttack getVariable ["exileterritoryname", "ERROR: UNKNOWN NAME"];
               _paraGroups = [_flagPos, _aiSetup select 0, _aiSetup select 1, ([[_missionName],["aiMode"]] call VEMFr_fnc_getSetting select 0), _missionName, 1000 + (random 1000), 150] call VEMFr_fnc_spawnVEMFrAI;
               if (count _paraGroups isEqualTo (_aiSetup select 0)) then
               {
                  _unitCount = 0;
                  {
                     if (count (units _x) isEqualTo (_aiSetup select 1)) then
                     {
                        _unitCount = _unitCount + (count(units _x));
                     };
                  } forEach _paraGroups;
                  if (_unitCount isEqualTo ((_aiSetup select 0) * (_aiSetup select 1))) then
                  {
                     _wayPoints = [];
                     _units = [];
                     {
                        _wp = _x addWaypoint [_flagPos, 50, 1];
                        _wp setWaypointBehaviour "COMBAT";
                        _wp setWaypointCombatMode "RED";
                        _wp setWaypointCompletionRadius 10;
                        _wp setWaypointFormation "DIAMOND";
                        _wp setWaypointSpeed "FULL";
                        _wp setWaypointType "SAD";
                        _x setCurrentWaypoint _wp;
                        _wayPoints pushback _wp;
                        {
                           _units pushback _x;
                        } forEach (units _x);
                        _signed = [_x] call VEMFr_fnc_signAI;
                     } forEach _paraGroups;
                     _players = nearestObjects [_flagPos, ["Exile_Unit_Player"], 275];
                     [[format["A para team is on the way to %1 @ %2's location!", _flagName, name _nearestPlayer],"BaseAttack", _players]] ExecVM "exile_vemf_reloaded\sqf\broadCast.sqf";
                     ["BaseAttack", 1, format["A para team is on the way to %1 @ %2's location!", _flagName, name _nearestPlayer]] ExecVM "exile_vemf_reloaded\sqf\log.sqf";

                     while {true} do
                     {
                        scopeName "loop";
                        _deadCount = 0;
                        {
                           if (damage _x isEqualTo 1 OR isNull _x) then
                           {
                              _deadCount = _deadCount + 1;
                           };
                        } forEach _units;
                        if (_deadCount isEqualTo _unitCount) then
                        {
                           breakOut "loop";
                        } else
                        {
                           uiSleep 4;
                        };
                     };
                     _players = nearestObjects [_flagPos, ["Exile_Unit_Player"], 275];
                     [[format["Attack on %1 has been defeated", _flagname],"SUCCESS", _players]] ExecVM "exile_vemf_reloaded\sqf\broadCast.sqf";
                     breakOut "outer";
                  } else
                  {
                     {
                        {
                           deleteVehicle _x;
                        } forEach (units _x);
                     } forEach _paraGroups;
                     ["BaseAttack", 0, format["Incorrect amount of total units (%1). Should be %2", _unitCount, (_aiSetup select 0) * (_aiSetup select 1)]] ExecVM "exile_vemf_reloaded\sqf\log.sqf";
                     breakOut "outer";
                  };
               } else
               {
                  ["BaseAttack", 0, format["Incorrect spawned group count (%1). Should be %2", count _paraGroups, _aiSetup select 0]] ExecVM "exile_vemf_reloaded\sqf\log.sqf";
                  breakOut "outer";
               };
            } else
            {
               _index = _attackedFlags find _flagToAttack;
               if (_index > -1) then
               {
                  _attackedFlags deleteAt _index;
                  ["BaseAttack", 1, "Flag deleted from attackedFlag array"] ExecVM "exile_vemf_reloaded\sqf\log.sqf";
               } else
               {
                  ["BaseAttack", 0, "Unable to locate and remove attacked flag!"] ExecVM "exile_vemf_reloaded\sqf\log.sqf";
               };
               ["BaseAttack", 0, "Can not find player near flag!"] ExecVM "exile_vemf_reloaded\sqf\log.sqf";
               breakOut "outer";
            };
         } else
         {
            breakOut "outer";
         };
      } else
      {
         ["BaseAttack", 0, format["invalid aiSetup setting! (%1)", _aiSetup]] ExecVM "exile_vemf_reloaded\sqf\log.sqf";
         breakOut "outer";
      };
   } else
   {
      ["BaseAttack", 0, format["Failed to start mission. Given _missionName (%1) is not in active missionList", _missionName]] ExecVM "exile_vemf_reloaded\sqf\log.sqf";
      breakOut "outer";
   };
};
VEMFrAttackCount = VEMFrAttackCount - 1;
VEMFrMissionCount = VEMFrMissionCount - 1;
