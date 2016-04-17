/*
    Author: IT07

    Description:
    Handles the start and timeout of missions

    Params:
    none

    Returns:
    nothing
*/

_maxGlobalMissions = "maxGlobalMissions" call VEMFr_fnc_getSetting;
if (_maxGlobalMissions > 0) then
{
    _minNew = "minNew" call VEMFr_fnc_getSetting;
    if (_minNew > -1) then
    {
        _maxNew = "maxNew" call VEMFr_fnc_getSetting;
        if (_maxNew > 0) then
        {
            _missionList = "missionList" call VEMFr_fnc_getSetting;
            if (count _missionList > 0) then
            {
               [_maxGlobalMissions, _minNew, _maxNew, _missionList] spawn
               {
                  _maxGlobalMissions = _this select 0;
                  _minNew = _this select 1;
                  _maxNew = _this select 2;
                  _missionList = _this select 3;
                  _minFps = "minServerFPS" call VEMFr_fnc_getSetting;
                  _minPlayers = "minPlayers" call VEMFr_fnc_getSetting;
                  waitUntil { uiSleep 5; (if (([_minPlayers] call VEMFr_fnc_playerCount) AND (diag_fps > _minFps)) then { true } else { false }) };
                  ["missionTimer", 1, format["Enough players online (%1) and server FPS (%2) is above %3. Starting missionTimer...", count allPlayers, diag_fps, _minFps]] spawn VEMFr_fnc_log;

                  VEMFrMissionCount = 0;
                  private ["_ignoreLimit"];
                  _ignoreLimit = false;
                  if (_maxGlobalMissions isEqualTo 0) then
                  {
                      _ignoreLimit = true;
                  };
                  _waitForFail =
                  {
                     _count = 0;
                     waitUntil { if (scriptDone _this) then { true } else { _count = _count + 1; if(_count isEqualTo 5) then { true } else { false }} };
                  };
                  _sleep = {
                     // Wait random amount
                     uiSleep ((_minNew*60)+ floor random ((_maxNew*60)-(_minNew*60)));
                  };
                  call _sleep;
                  while {true} do
                  {
                      // Pick A Mission if enough players online
                      if ([_minPlayers] call VEMFr_fnc_playerCount) then
                      {
                        scopeName "pick";
                         if _ignoreLimit then
                         {
                             _missionName = selectRandom _missionList;
                             _mission = [_missionName] execVM format["exile_vemf_reloaded\missions\%1.sqf", _missionName];
                             private["_count"];
                             _mission call _waitForFail;
                             if (_count isEqualTo 5) then
                             {
                                _lastMission = serverTime;
                                call _sleep;
                                breakOut "pick";
                             } else
                             {
                                uiSleep (_minNew*60); // Wait a little bit if mission failed
                             };
                         };
                         if not _ignoreLimit then
                         {
                             if (VEMFrMissionCount <= _maxGlobalMissions) then
                             {
                                  _missionName = selectRandom _missionList;
                                  _mission = [_missionName] execVM format["exile_vemf_reloaded\missions\%1.sqf", _missionName];
                                  private["_count"];
                                  _mission call _waitForFail;
                                  if (_count isEqualTo 5) then
                                  {
                                     VEMFrMissionCount = VEMFrMissionCount + 1;
                                     _lastMission = serverTime;
                                     call _sleep;
                                     breakOut "pick";
                                  } else
                                  {
                                     uiSleep (_minNew*60); // Wait a little bit if mission failed
                                  };
                             };
                         };
                      };
                  };
               };
            };
        };
    };
} else
{
    ["missionTimer", 0, format["Invalid maximum global missions number! it is: %1", _maxGlobalMissions]] spawn VEMFr_fnc_log;
};
