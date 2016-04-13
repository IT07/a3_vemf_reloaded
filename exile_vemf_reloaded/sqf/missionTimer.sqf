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
                  while {true} do
                  {
                      // Wait random amount
                      uiSleep ((_minNew*60)+ floor random ((_maxNew*60)-(_minNew*60)));

                      // Pick A Mission if enough players online
                      if ([_minPlayers] call VEMFr_fnc_playerCount) then
                      {
                         if _ignoreLimit then
                         {
                             _missionName = selectRandom _missionList;
                             [_missionName] execVM format["exile_vemf_reloaded\missions\%1.sqf", _missionName];
                             _lastMission = serverTime;
                         };
                         if not _ignoreLimit then
                         {
                             if (VEMFrMissionCount <= _maxGlobalMissions) then
                             {
                                  _missionName = selectRandom _missionList;
                                  [_missionName] execVM format["exile_vemf_reloaded\missions\%1.sqf", _missionName];
                                  VEMFrMissionCount = VEMFrMissionCount +1;
                                  _lastMission = serverTime;
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
