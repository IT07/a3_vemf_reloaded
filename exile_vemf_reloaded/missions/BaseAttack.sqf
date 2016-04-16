/*
   Author: IT07

   Description:
   A simple mission for VEMFr that sends a chopper to a player's territory and paradrops all units inside
*/

_missionName = param [0, "", [""]];
if isNil"VEMFrAttackCount" then { VEMFrAttackCount = 0 };
if (VEMFrAttackCount < ([[_missionName],["maxAttacks"]] call VEMFr_fnc_getSetting select 0)) then
{
   scopeName "outer";
   VEMFrAttackCount = VEMFrAttackCount + 1;
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
               _flag = selectRandom (nearestObjects [position _x, ["Exile_Construction_Flag_Static"], 150]);
               if not isNil"_flag" then
               {
                  if not(_flag in _attackedFlags) then
                  {
                     _flags pushBackUnique _flag;
                  };
               };
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
                        _wp setWaypointType "SAD";
                        _wp setWaypointSpeed "FULL";
                        _wp setWaypointCombatMode "RED";
                        _wp setWaypointBehaviour "AWARE";
                        _x setCurrentWaypoint _wp;
                        _wayPoints pushback _wp;
                        {
                           if (backpack _x isEqualTo "") then
                           {
                              removeBackpack _x;
                           };
                           _x addBackPack "B_Parachute";
                           _units pushback _x;
                        } forEach (units _x);
                        [_x] spawn VEMFr_fnc_signAI;
                     } forEach _paraGroups;
                     _nameOfTarget = name _nearestPlayer;
                     _players = nearestObjects [_flagPos, ["Exile_Unit_Player"], 275];
                     [[format["A paradrop team is on the way to %1's location!", _nameOfTarget],"BaseAttack", _players]] spawn VEMFr_fnc_broadCast;
                     ["BaseAttack", 1, format["A paradrop team is on the way to %1's location!", name _nearestPlayer]] spawn VEMFr_fnc_log;

                     while {true} do
                     {
                        scopeName "loop";
                        _deadCount = 0;
                        {
                           if not(alive _x) then
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
                     [[format["Attack on %1's location has been stopped", _nameOfTarget],"SUCCESS", _players]] spawn VEMFr_fnc_broadCast;
                     VEMFrAttackCount = VEMFrAttackCount - 1;
                     VEMFrMissionCount = VEMFrMissionCount - 1;
                     breakOut "outer";
                  } else
                  {
                     {
                        {
                           deleteVehicle _x;
                        } forEach (units _x);
                     } forEach _paraGroups;
                     ["BaseAttack", 0, format["Incorrect amount of total units (%1). Should be %2", _unitCount, (_aiSetup select 0) * (_aiSetup select 1)]] spawn VEMFr_fnc_log;
                     VEMFrAttackCount = VEMFrAttackCount - 1;
                     VEMFrMissionCount = VEMFrMissionCount - 1;
                     breakOut "outer";
                  };
               } else
               {
                  ["BaseAttack", 0, format["Incorrect spawned group count (%1). Should be %2", count _paraGroups, _aiSetup select 0]] spawn VEMFr_fnc_log;
                  VEMFrAttackCount = VEMFrAttackCount - 1;
                  VEMFrMissionCount = VEMFrMissionCount - 1;
                  breakOut "outer";
               };
            } else
            {
               _index = _attackedFlags find _flagToAttack;
               if (_index > -1) then
               {
                  _attackedFlags deleteAt _index;
                  ["BaseAttack", 1, "Flag deleted from attackedFlag array"] spawn VEMFr_fnc_log;
               } else
               {
                  ["BaseAttack", 0, "Unable to locate and remove attacked flag!"] spawn VEMFr_fnc_log;
               };
               ["BaseAttack", 0, "Can not find player near flag!"] spawn VEMFr_fnc_log;
               VEMFrAttackCount = VEMFrAttackCount - 1;
               VEMFrMissionCount = VEMFrMissionCount - 1;
               breakOut "outer";
            };
         } else
         {
            VEMFrAttackCount = VEMFrAttackCount - 1;
            VEMFrMissionCount = VEMFrMissionCount - 1;
            breakOut "outer";
         };
      } else
      {
         ["BaseAttack", 0, format["invalid aiSetup setting! (%1)", _aiSetup]] spawn VEMFr_fnc_log;
         VEMFrAttackCount = VEMFrAttackCount - 1;
         VEMFrMissionCount = VEMFrMissionCount - 1;
         breakOut "outer";
      };
   } else
   {
      ["BaseAttack", 0, format["Failed to start mission. Given _missionName (%1) is not in active missionList", _missionName]] spawn VEMFr_fnc_log;
      VEMFrAttackCount = VEMFrAttackCount - 1;
      VEMFrMissionCount = VEMFrMissionCount - 1;
      breakOut "outer";
   };
   //
} else
{
   VEMFrMissionCount = VEMFrMissionCount - 1;
};
