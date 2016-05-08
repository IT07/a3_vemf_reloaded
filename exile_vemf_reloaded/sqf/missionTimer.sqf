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
      scopeName "outer";
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
                              if isNil"VEMFrForceStart" then { VEMFrForceStart = false };
                              waitUntil { if ([_minPlayers] call VEMFr_fnc_playerCount AND diag_fps > _minFps OR VEMFrForceStart) then { true } else { uiSleep 5; false } };
                              if VEMFrForceStart then
                                 {
                                    ["missionTimer", 1, format["VEMFr has been forced to start. Server FPS: %1", diag_fps]] spawn VEMFr_fnc_log;
                                 } else
                                    {
                                       ["missionTimer", 1, format["Enough players online (%1) and server FPS (%2) is above %3. Starting missionTimer...", count allPlayers, diag_fps, _minFps]] spawn VEMFr_fnc_log;
                                    };
                                 VEMFrMissionCount = 0;
                                 private ["_ignoreLimit"];
                                 _ignoreLimit = false;
                                 if (_maxGlobalMissions isEqualTo 0) then
                                    {
                                       _ignoreLimit = true;
                                    };
                                 _sleep =
                                    {
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
                                             if (VEMFrMissionCount <= _maxGlobalMissions AND VEMFrMissionCount >= 0 OR _ignoreLimit) then
                                                {
                                                   _missionName = selectRandom _missionList;
                                                   _mission = [_missionName] execVM format["exile_vemf_reloaded\missions\%1.sqf", _missionName];
                                                   uiSleep 5;
                                                   if (scriptDone _mission) then
                                                      {
                                                         // Mission sqf file finished executing within 5 seconds. Assume it did not meet requirements to spawn.
                                                         breakOut "pick"; // break the current scope and redo the loop (a.k.a. pick a new mission and launch it right away instead of the failed one)
                                                      } else
                                                         {
                                                            // Mission sqf file did not finish within 5 seconds. Assume it is running successfully.
                                                            call _sleep;
                                                         };
                                                } else
                                                {
                                                   if (VEMFrMissionCount < 0) then
                                                      {
                                                         ["missionTimer", 0, format["VEMFrMissionCount (%1) is BELOW 0! Stopping missionTimer...", VEMFrMissionCount]] spawn VEMFr_fnc_log;
                                                         breakOut "outer";
                                                      };
                                                };
                                          } else
                                             {
                                                uiSleep 60; // If no players online, check again in 60 seconds
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
