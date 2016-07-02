/*
    Author: IT07

    Description:
    Handles the start and timeout of missions

    Params:
    none

    Returns:
    nothing
*/

scopeName "outer";
_mgm = "maxGlobalMissions" call VEMFr_fnc_config;
["missionTimer", 1, format["Global mission-limit is set at: %1", _mgm]] ExecVM "exile_vemf_reloaded\sqf\log.sqf";
_minNew = "minNew" call VEMFr_fnc_config;
if (_minNew > -1) then
   {
      _maxNew = "maxNew" call VEMFr_fnc_config;
      if (_maxNew > 0) then
         {
            _ml = "missionList" call VEMFr_fnc_config;
            if (count _ml > 0) then
               {
                  _minFps = "minServerFPS" call VEMFr_fnc_config;
                  _mnPlyrs = "minPlayers" call VEMFr_fnc_config;
                  if isNil "VEMFrForceStart" then { VEMFrForceStart = false };
                  waitUntil { if ((((count allPlayers) >= _mnPlyrs) AND (diag_fps > _minFps)) OR VEMFrForceStart) then { true } else { uiSleep 5; false } };
                  if VEMFrForceStart then
                     {
                        ["missionTimer", 1, format["VEMFr has been forced to start. Server FPS: %1", diag_fps]] ExecVM "exile_vemf_reloaded\sqf\log.sqf";
                     } else
                     {
                        ["missionTimer", 1, format["Enough players online (%1) and server FPS (%2) is above %3. Starting missionTimer...", count allPlayers, diag_fps, _minFps]] ExecVM "exile_vemf_reloaded\sqf\log.sqf";
                     };

                  VEMFrMissionCount = 0;
                  _im = false;
                  if (_mgm isEqualTo 0) then { _im = true };
                  _zz = { uiSleep ((_minNew*60)+ floor random ((_maxNew*60)-(_minNew*60))) };
                  call _zz;

                  while {true} do
                     {
                        // Pick A Mission if enough players online
                        if ((count allPlayers) >= _mnPlyrs) then
                           {
                              scopeName "pick";
                              if ((VEMFrMissionCount < _mgm) AND (VEMFrMissionCount >= 0) OR _im) then
                                 {
                                    _mssnNm = selectRandom _ml;
                                    _h = [_mssnNm] execVM format["exile_vemf_reloaded\missions\%1.sqf", _mssnNm];
                                    uiSleep 5;
                                    if (scriptDone _h) then { breakOut "pick" } else { call _zz };
                                 } else
                                 {
                                    if (VEMFrMissionCount < 0) then
                                       {
                                          ["missionTimer", 0, format["VEMFrMissionCount (%1) is BELOW 0! Stopping missionTimer...", VEMFrMissionCount]] ExecVM "exile_vemf_reloaded\sqf\log.sqf";
                                          breakOut "outer";
                                       };
                                    call _zz;
                                 };
                           } else { uiSleep 60 };
                     };
            };
      };
};
