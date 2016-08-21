/*
   Author: IT07

   Description:
   handles the things that need to be rewarded when player kills an AI

   Params:

*/

params [ "_t", "_nt", "_k", "_nk" ];
if ( isPlayer _k ) then
   {
      scopeName "isPlayer";
      private [ "_rspct", "_crpt" ];
      _mod = call VEMFr_fnc_whichMod;
      if ( _mod isEqualTo "Exile" ) then
         {
            _rspct =
               {
                  _arr = [ [ ] ];
                  ( _arr select 0 ) pushBack [ ( selectRandom [ "AI WACKED", "AI CLIPPED", "AI WIPED", "AI ERASED", "AI LYNCHED", "AI WRECKED", "AI SNUFFED", "AI WASTED", "AI ZAPPED" ] ), _rw ];
                  _dist = _t distance _k;
                  _bns = call
                  {
                     private "_r";
                     if ( _dist <= 10 ) exitWith { _r = 25; _r };
                     if ( _dist <= 25 ) exitWith { _r = 23; _r };
                     if ( _dist <= 45 ) exitWith { _r = 20; _r };
                     if ( _dist <= 65 ) exitWith { _r = 18; _r };
                     if ( _dist <= 85 ) exitWith { _r = 16; _r };
                     if ( _dist <= 100 ) exitWith { _r = 14; _r };
                     if ( _dist <= 150 ) exitWith { _r = 12; _r };
                     if ( _dist <= 175 ) exitWith { _r = 14; _r };
                     if ( _dist <= 200 ) exitWith { _r = 16; _r };
                     if ( _dist <= 250 ) exitWith { _r = 18; _r };
                     if ( _dist <= 350 ) exitWith { _r = 21; _r };
                     if ( _dist <= 475 ) exitWith { _r = 24; _r };
                     if ( _dist > 475 ) exitWith { _r = 25; _r };
                  };

                  ( _arr select 0 ) pushBack [ "BONUS", _bns ];
                  _score = ( _k getVariable [ "ExileScore", 0 ] ) + ( ( ( _arr select 0 ) select 1 ) select 1 ) + _rw;
                  [ _k, "showFragRequest", _arr ] call ExileServer_system_network_send_to;
                  _k setVariable [ "ExileScore", _score ];
                  ExileClientPlayerScore = _score;
                  ( owner _k ) publicVariableClient "ExileClientPlayerScore";
                  ExileClientPlayerScore = nil;

                  _kllCnt = ( _k getVariable [ "ExileKills" , 0 ] ) + 1;
                  _k setVariable [ "ExileKills", _kllCnt ];
                  ExileClientPlayerKills = _kllCnt;
                  ( owner _k ) publicVariableClient "ExileClientPlayerKills";
                  ExileClientPlayerKills = nil;

                  format [ "addAccountKill:%1", getPlayerUID _k ] call ExileServer_system_database_query_fireAndForget;
                  format ["setAccountScore:%1:%2", _score, getPlayerUID _k ] call ExileServer_system_database_query_fireAndForget;
               };
         };

      if ( _mod isEqualTo "Epoch" ) then
         {
            _crpt =
               {
                  _ffct =
                     {
                        _vrs = _k getVariable [ "VARS", nil ];
                        _crptId = EPOCH_customVars find "Crypto";
                        _nwCrpt = ( _vrs select _crptId ) + _rwrd + ( ( [ [ _mod ], [ "cryptoReward" ] ] call VEMFr_fnc_config ) select 0 );
                        _vrs set [ _crptId, _nwCrpt ];
                        _k setVariable [ "VARS", _vrs ];
                        _nwCrpt remoteExec [ "EPOCH_effectCrypto", owner _k ];
                     };

                  _rwrd = 0;
                  _dist = _t distance _k;
                  if ( _dist < 2500 ) then
                     {
                        scopeName "dist";
                        if ( _dist <= 5 ) then { _rwrd = 25; call _ffct; breakOut "dist" };
                        if ( _dist <= 10 ) then { _rwrd = 15; call _ffct; breakOut "dist" };
                        if ( _dist <= 50 ) then { _rwrd = 15; call _ffct; breakOut "dist" };
                        if ( _dist <= 100 ) then { _rwrd = 20; call _ffct; breakOut "dist" };
                        if ( _dist <= 200 ) then { _rwrd = 25; call _ffct; breakOut "dist" };
                        if ( _dist <= 500 ) then { _rwrd = 30; call _ffct; breakOut "dist" };
                        if ( _dist <= 1000 ) then { _rwrd = 45; call _ffct; breakOut "dist" };
                        if ( _dist <= 2000 ) then { _rwrd = 50; call _ffct; breakOut "dist" };
                        if ( _dist > 2000 ) then { _rwrd = 65; call _ffct; breakOut "dist" };
                     };
               };
         };

      _rw = ( [ [ "Exile" ], [ "respectReward" ] ] call VEMFr_fnc_config ) select 0;
      _cw = ( [ [ "Epoch" ], [ "cryptoReward" ] ] call VEMFr_fnc_config ) select 0;
      _sk = "sayKilled" call VEMFr_fnc_config;

      if ( _k isKindOf "Man" ) then // Roadkill or regular kill
         {
            if ( ( vehicle _k ) isEqualTo _k ) then // If on foot
               {
                  if ( ( vehicle _t ) isEqualTo _t ) then
                     {
                        if ( ( _mod isEqualTo "Exile" ) AND ( _rw > 0 ) ) then { call _rspct };
                        if ( ( _mod isEqualTo "Epoch" ) AND ( _cw > 0 ) ) then { call _crpt };
                        if ( _sk isEqualTo "yes" ) then { [ _t, _nt, _k, _nk ] ExecVM ( "sayKilled" call VEMFr_fnc_scriptPath ) };
                     } else
                     {
                        if ( ( typeOf ( vehicle _t ) ) isEqualTo "Steerable_Parachute_F" ) then
                           {
                              if ( ( "logCowardKills" call VEMFr_fnc_config ) isEqualTo "yes") then { [ "fn_aiKilled", 1, format [ "a coward (%1 @ %2) killed a parachuting AI", _nk, mapGridPosition _k ] ] ExecVM ( "log" call VEMFr_fnc_scriptPath ) };
                           } else
                              {
                                 if ( ( _mod isEqualTo "Exile" ) AND ( _rw > 0 ) ) then { call _rspct };
                                 if ( ( _mod isEqualTo "Epoch" ) AND ( _cw > 0 ) ) then { call _crpt };
                                 if ( _sk isEqualTo "yes" ) then { [ _t, _nt, _k, _nk] ExecVM ( "sayKilled" call VEMFr_fnc_scriptPath ) };
                              };
                     };
               } else // If in vehicle (a.k.a. roadkill)
               {
                  if ( ( "punishRoadKills" call VEMFr_fnc_config ) isEqualTo "yes" ) then
                     {
                        if ( _mod isEqualTo "Exile" ) then
                           {
                              _pnsh = ( [ [ "Exile" ], [ "respectRoadKillDeduct" ] ] call VEMFr_fnc_config ) select 0;
                              _nwRspct = ( _k getVariable [ "ExileScore", 0 ] ) - _pnsh;
                              _k setVariable [ "ExileScore", _nwRspct ];
                              ExileClientPlayerScore = _nwRspct;
                              ( owner _k ) publicVariableClient "ExileClientPlayerScore";
                              ExileClientPlayerScore = nil;
                              [ _k, "showFragRequest", [ [ [ "ROADKILL..." ], [ "Penalty:", -_pnsh ] ] ] ] call ExileServer_system_network_send_to;
                              format [ "setAccountScore:%1:%2", _nwRspct, getPlayerUID _k ] call ExileServer_system_database_query_fireAndForget;

                              if ( ( "sayKilled" call VEMFr_fnc_config ) isEqualTo "yes" ) then { [ format [ "%1 roadkilled %2", _nk, if ( ( "sayKilledName" call VEMFr_fnc_config ) isEqualTo "yes" ) then { _nt + " (AI)" } else { "an AI" } ] ] ExecVM ( "systemChatToClient" call VEMFr_fnc_scriptPath ) };
                           };

                        if ( _mod isEqualTo "Epoch" ) then
                           {
                              _vrs = _k getVariable [ "VARS", nil ];
                              _crptId = EPOCH_customVars find "Crypto";
                              _nwCrpt = ( _vrs select _crptId ) - ( ( [ [ "Epoch" ], [ "cryptoRoadKillPunish" ] ] call VEMFr_fnc_config ) select 0 );
                              _vrs set [ _crptId, _nwCrpt ];
                              _k setVariable [ "VARS", _vrs ];
                              _nwCrpt remoteExec [ "EPOCH_effectCrypto", owner _k ];
                           };
                     };
               };
         } else // If kill from vehicle (NOT a roadkill)
         {
            if ( ( typeOf ( vehicle _t ) ) isEqualTo "Steerable_Parachute_F" ) then
               {
                  if ( "logCowardKills" call VEMFr_fnc_config isEqualTo "yes" ) then
                     {
                        [ "fn_aiKilled", 1, format [ "a coward (%1 @ %2) killed a parachuting AI", _nk, mapGridPosition _k ] ] ExecVM ( "log" call VEMFr_fnc_scriptPath );
                     };
               } else
               {
                  _k = effectiveCommander _k;
                  if ( ( _mod isEqualTo "Exile" ) AND ( _rw > 0 ) ) then { call _rspct };
                  if ( ( _mod isEqualTo "Epoch" ) AND ( _cw > 0 ) ) then { call _crpt };
                  if ( _sk isEqualTo "yes" ) then { [ _t, _nt, _k, _nk ] ExecVM ( "sayKilled" call VEMFr_fnc_scriptPath ) };
               };
         };
   };
